import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleService {

  Stream<List<ScanResult>> scanResults() {
    return FlutterBluePlus.scanResults;
  }

  Future<void> startScan() async {
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 5),
    );
  }

  Future<void> connect(BluetoothDevice device) async {
    await device.connect(autoConnect: false, license: License.free);
  }

  Future<void> disconnect(BluetoothDevice device) async {
    await device.disconnect();
  }

  Stream<BluetoothConnectionState> connectionState(
    BluetoothDevice device,
  ) {
    return device.connectionState;
  }
  
}