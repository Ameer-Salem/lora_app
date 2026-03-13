import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lora_app/service/ble_service.dart';
import 'package:lora_app/service/database_service.dart';
import 'package:path_provider/path_provider.dart';

enum ServicesStatus { loading, notSupported, bluetoothOff, locationOff, ready }

final bleServiceProvider = Provider<BleService>((ref) {
  return BleService();
});

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  final db = DatabaseService();

  ref.onDispose(() async {
    await db.closeDatabase();
  });

  return db;
});
final userProvider = StreamProvider.family<dynamic, int>((ref, userId) {
  return ref.read(databaseServiceProvider).watchUser(userId);
});

final mbtilesPathProvider = FutureProvider<String>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/najaf.mbtiles');

  if (!await file.exists()) {
    final data = await rootBundle.load('assets/maps/najaf.mbtiles');
    await file.writeAsBytes(data.buffer.asUint8List());
  }

  return file.path;
});
final servicesStatusProvider = StreamProvider<ServicesStatus>((ref) async* {
  if (!await FlutterBluePlus.isSupported) {
    yield ServicesStatus.notSupported;
    return;
  }

  await for (final btState in FlutterBluePlus.adapterState) {
    if (btState != BluetoothAdapterState.on) {
      yield ServicesStatus.bluetoothOff;
      continue;
    }

    // Bluetooth is ON → now track location changes
    while (btState == BluetoothAdapterState.on) {
      final locationEnabled = await Geolocator.isLocationServiceEnabled();

      if (!locationEnabled) {
        yield ServicesStatus.locationOff;
      } else {
        yield ServicesStatus.ready;
      }

      // Re-check location every second
      await Future.delayed(const Duration(seconds: 1));

      // Exit loop if Bluetooth turns OFF
      final currentBt = await FlutterBluePlus.adapterState.first;
      if (currentBt != BluetoothAdapterState.on) {
        break;
      }
    }
  }
});
