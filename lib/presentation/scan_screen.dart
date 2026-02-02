import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/session_controller.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  @override
  void initState() {
    super.initState();

    // run AFTER first frame to avoid build conflicts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(connectionStatusProvider.notifier).startScan();
    });
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.read(connectionStatusProvider.notifier);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BLE Scan'),
          actions: [
            IconButton(
              onPressed: () => manager.startScan(),
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: SizedBox(
          height: 400,
          width: double.infinity,
          child: StreamBuilder(
            initialData: const [],
            stream: manager.getScanResults(),
            builder: (context, snapshot) {
              final data = snapshot.data ?? [];

              if (data.isEmpty) {
                return const Center(child: Text('No devices found'));
              }

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    data[index].device.name?.isNotEmpty == true
                        ? data[index].device.name!
                        : 'Unknown',
                  ),
                  subtitle: Text(data[index].rssi.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.connect_without_contact_rounded),
                    onPressed: () => manager.connect(data[index].device),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
