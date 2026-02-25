import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/session_controller.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
     _timer = Timer.periodic(Duration(seconds: 8), (_) => ref.read(connectionStatusProvider.notifier).startScan());
    // run AFTER first frame to avoid build conflicts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(connectionStatusProvider.notifier).startScan();
    });
  }
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.read(connectionStatusProvider.notifier);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LoRa Devices'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 4,
              width: double.infinity,
              child: StreamBuilder(
                initialData: const [],
                stream: manager.getScanResults(),
                builder: (context, snapshot) {
                  final data = snapshot.data ;

                  if (data == null) {
                    return const Center(child: Text('No devices found'));
                  }

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Text(
                        data[index].rssi.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                      title: Text(
                        data[index].device.name?.isNotEmpty == true
                            ? data[index].device.name!
                            : 'Unknown',
                      ),
                      subtitle: Text(data[index].device.remoteId.str),
                      onTap: () => manager.connect(data[index].device),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height / 6),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 2.5,
              width: double.infinity,
              child: Image.asset('assets/pngs/searching.png'),
            ),
          ],
        ),
      ),
    );
  }
}
