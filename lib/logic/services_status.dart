import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

enum ServicesStatus { loading, notSupported, bluetoothOff, locationOff, ready }


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
    while (true) {
      final locationEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!locationEnabled) {
        yield ServicesStatus.locationOff;
      } else {
        yield ServicesStatus.ready;
      }

      // Re-check location every second
      await Future.delayed(const Duration(seconds: 1));

      // Exit loop if Bluetooth turns OFF
      final currentBt =
          await FlutterBluePlus.adapterState.first;
      if (currentBt != BluetoothAdapterState.on) {
        break;
      }
    }
  }
});