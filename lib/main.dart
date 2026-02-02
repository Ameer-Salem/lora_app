
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/logic/session_controller.dart';
import 'package:lora_app/presentation/check_screen.dart';
import 'package:lora_app/presentation/home_screen.dart';
import 'package:lora_app/presentation/scan_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBluePlus.setLogLevel(LogLevel.none);
  await [
    Permission.bluetooth,
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.bluetoothAdvertise,
    Permission.location,
  ].request();
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
  }
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(connectionStatusProvider);
    final services = ref.watch(servicesStatusProvider);

    return MaterialApp(
      home: session.status == ConnectionStatus.connected ? HomeScreen() : services.when(
        loading: () => null,
        error: (e, _) => null,
        data: (status) {
          return (status == ServicesStatus.ready)
              ? ScanScreen()
              : CheckScreen();
        },
      ),
    );
  }
}
