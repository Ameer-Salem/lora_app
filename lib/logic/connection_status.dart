import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/model/device.dart';
import 'package:lora_app/service/ble_service.dart';

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
  late final BleService _ble;
  StreamSubscription? _connectionSub;

  @override
  DeviceSession build() {
    _ble = BleService();
    return const DeviceSession.disconnected();
  }

  Future<void> connect(BluetoothDevice device) async {
    state = DeviceSession(status: ConnectionStatus.connecting);

    await _ble.connect(device);

    _connectionSub?.cancel();
    _connectionSub = _ble.connectionState(device).listen((stateUpdate) {
      if (stateUpdate == BluetoothConnectionState.disconnected) {
        disconnect();
      }
    });

    state = DeviceSession(
      status: ConnectionStatus.connected,
      device: Device(id: device.remoteId.str, name: device.platformName),
    );
  }
  Future<void> disconnect() async {
    _connectionSub?.cancel();
    _connectionSub = null;
    state = const DeviceSession.disconnected();
  }
}

final connectionStatusProvider =
    NotifierProvider<DeviceSessionNotifier, DeviceSession>(
      DeviceSessionNotifier.new,
    );
