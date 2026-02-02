import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/messaging_controller.dart';
import 'package:lora_app/logic/neighbors_controller.dart';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/model/device.dart';
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

  @override
  DeviceSession build() {
    return const DeviceSession.disconnected();
  }

  Future<void> connect(BluetoothDevice device) async {
    state = DeviceSession(status: ConnectionStatus.connecting);
    try {
      await ref.read(bleServiceProvider).connect(device);
      await ref.read(databaseServiceProvider).openDatabase(device.remoteId.str);
      _connectionSub?.cancel();
      _connectionSub = ref.read(bleServiceProvider).connectionState(device).listen((stateUpdate) {
        if (stateUpdate == BluetoothConnectionState.disconnected) {
          disconnect();
        }
      });
      state = DeviceSession(
        status: ConnectionStatus.connected,
        device: Device(id: device.platformName, name: device.platformName),
      );

      _dataSub?.cancel();
      _dataSub = ref.read(bleServiceProvider).notifyCharacteristic!.onValueReceived.listen((values) {
        final data = Uint8List.fromList(values);
        switch (data[0]) {
          case Constants.ackTYPE:
            // ACK packet
            ref.read(messagesProvider.notifier).onACKPacket(data);
            break;
          case Constants.textTYPE:
            // Text packet
            ref.read(messagesProvider.notifier).onTextPacket(data);
            break;
          case Constants.neighborsTYPE:
            // Neighbors packet
            ref.read(neighborsProvider.notifier).updateFromPacket(data);
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
    _connectionSub?.cancel();
    _connectionSub = null;
    ref.read(neighborsProvider.notifier).clear();
    await ref.read(databaseServiceProvider).closeDatabase();
    state = const DeviceSession.disconnected();
  }

  Stream<List<ScanResult>> getScanResults() {
    return ref.read(bleServiceProvider).scanResults();
  }

  

  Future<void> startScan() async {
    await ref.read(bleServiceProvider).startScan();
  }
}

final connectionStatusProvider =
    NotifierProvider<DeviceSessionNotifier, DeviceSession>(
      DeviceSessionNotifier.new,
    );

