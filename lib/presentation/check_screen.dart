import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/providers.dart';

class CheckScreen extends ConsumerWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(servicesStatusProvider);

    return statusAsync.when(
      data: (status) {
        String message = switch (status) {
          ServicesStatus.notSupported => "Device not supported",
          ServicesStatus.bluetoothOff => "Bluetooth is off",
          ServicesStatus.locationOff => "Location is off",
          ServicesStatus.ready => "All set!",
          _ => "",
        };

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.device_unknown,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                Text(message, style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        );
      },
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
