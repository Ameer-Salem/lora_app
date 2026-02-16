import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lora_app/service/ble_service.dart';
import 'package:lora_app/service/database_service.dart';

enum ServicesStatus { loading, notSupported, bluetoothOff, locationOff, ready }

final bleServiceProvider = Provider<BleService>((ref) {
  return BleService();
});

final locationProvider = StateNotifierProvider<LocationNotifier, Position?>(
  (ref) => LocationNotifier(),
);

class LocationNotifier extends StateNotifier<Position?> {
  LocationNotifier() : super(null) {
    _init();
  }

  void _init() async {
    await Geolocator.requestPermission();

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      ),
    ).listen((pos) {
      state = pos;
    });
  }
}

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  final db = DatabaseService();

  ref.onDispose(() async {
    await db.closeDatabase();
  });

  return db;
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
