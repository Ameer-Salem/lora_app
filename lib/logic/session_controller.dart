import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/location_controller.dart';
import 'package:lora_app/logic/messaging_controller.dart';
import 'package:lora_app/logic/neighbors_controller.dart';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/model/device.dart';
import 'package:lora_app/model/packet.dart';
import 'package:lora_app/service/ble_service.dart';
import 'package:lora_app/service/database_service.dart';
import 'package:lora_app/utilities/constants.dart';

enum ConnectionStatus { disconnected, connecting, connected }

class DeviceSession {
  final ConnectionStatus status;
  final Device? device;

  const DeviceSession({required this.status, this.device});

  const DeviceSession.disconnected()
    : status = ConnectionStatus.disconnected,
      device = null;
}

class DeviceSessionNotifier extends Notifier<DeviceSession> {
  StreamSubscription? _connectionSub;
  StreamSubscription? _dataSub;
  Timer? _retryTimer;
  Timer? _neighborTimer;
  late BleService ble;
  late DatabaseService db;
  late NeighborsNotifier neighborProvider;

  @override
  DeviceSession build() {
    ble = ref.read(bleServiceProvider);
    db = ref.read(databaseServiceProvider);
    neighborProvider = ref.read(neighborsProvider.notifier);
    return const DeviceSession.disconnected();
  }

  Future<void> connect(BluetoothDevice device) async {
    state = DeviceSession(status: ConnectionStatus.connecting);
    try {
      final position = ref.read(locationProvider);
      await ble.connect(device, position!);
      await db.openDatabase(device.remoteId.str);
      device.requestMtu(512);
      _connectionSub?.cancel();
      _connectionSub = ble.connectionState(device).listen((stateUpdate) {
        if (stateUpdate == BluetoothConnectionState.disconnected) {
          disconnect();
        }
      });
      state = DeviceSession(
        status: ConnectionStatus.connected,
        device: Device(id: device.platformName, name: device.platformName),
      );

      _dataSub?.cancel();
      // wait until characteristic exists
      while (ble.notifyCharacteristic == null) {
        await Future.delayed(const Duration(milliseconds: 50));
      }
      _startRetryLoop();
      _startNeighborsGetter();
      final messageProvider = ref.read(messagesProvider.notifier);
      _dataSub = ble.notifyCharacteristic!.onValueReceived.listen((values) {
        final data = Uint8List.fromList(values);
        switch (data[0]) {
          case Constants.ackTYPE:
            // ACK packet
            final Packet packet = Packet.fromBytes(data)!;
            messageProvider.onACKPacket(packet);
            break;
          case Constants.textTYPE:
            // Text packet
            final Packet packet = Packet.fromBytes(data)!;
            messageProvider.onTextPacket(packet);
            break;
          case Constants.neighborsTYPE:
            // Neighbors packet
            neighborProvider.updateFromPacket(data);
            break;

          default:
            // Unknown packet
            break;
        }
      });
    } catch (e) {
      return;
    }
  }

  Future<void> disconnect() async {
    _retryTimer?.cancel();
    _retryTimer = null;
    _neighborTimer?.cancel();
    _neighborTimer = null;
    _connectionSub?.cancel();
    _connectionSub = null;
    neighborProvider.clear;
    await db.closeDatabase();
    state = const DeviceSession.disconnected();
  }

  Stream<List<ScanResult>> getScanResults() {
    final devices = <ScanResult>[];
    final controller = StreamController<List<ScanResult>>();
    FlutterBluePlus.scanResults.listen((results) {
      for (var r in results) {
        final exists = devices.any(
          (d) => d.device.remoteId == r.device.remoteId,
        );
        if (!exists) devices.add(r);
      }
      controller.add(List.unmodifiable(devices)); // emit a copy
    });
    return controller.stream;
  }

  Future<void> startScan() async {
    try {
      FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 5),
        withServices: [ref.read(bleServiceProvider).serviceGUID],
      );
    } on Exception {
      return;
    }
  }

  void _startRetryLoop() {
    _retryTimer?.cancel();

    _retryTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      if (state.status != ConnectionStatus.connected) return;

      final segments = await db.getPendingSegments(
        maxRetries: Constants.maxRetries,
      );

      for (final segment in segments) {
        await db.incrementSegmentRetry(segment);
        final message = await db.getMessage(segment.uid);

        ble.sendPacket(
          type: message.type,
          sourceId: message.sourceId,
          destinationId: message.destinationId,
          uid: segment.uid,
          segmentIndex: segment.segmentIndex,
          totalSegments: message.totalSegments,
          payload: segment.payload,
        );

        // keep the radio happy
        await Future.delayed(const Duration(milliseconds: 130));
      }
    });
  }

  void _startNeighborsGetter() {

    _neighborTimer?.cancel();
    _neighborTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      if (state.status != ConnectionStatus.connected) return;
      await neighborProvider.getNeighbors();
      // keep the radio happy
      await Future.delayed(const Duration(milliseconds: 130));
    });
  }
}

final connectionStatusProvider =
    NotifierProvider<DeviceSessionNotifier, DeviceSession>(
      DeviceSessionNotifier.new,
    );
