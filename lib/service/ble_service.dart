import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:lora_app/service/database_service.dart';
import 'package:lora_app/utilities/converter.dart';

class BleService {
  Guid serviceGUID = Guid('ffffffff-ffff-ffff-ffff-ffffffffffff');
  Guid notifyGUID = Guid('ffffffff-ffff-ffff-ffff-fffffffffff0');
  Guid writeGUID = Guid('ffffffff-ffff-ffff-ffff-fffffffff000');
  List<BluetoothService> services = [];
  BluetoothCharacteristic? writeCharacteristic;
  BluetoothCharacteristic? notifyCharacteristic;
  Stream<List<ScanResult>> scanResults() {
    return FlutterBluePlus.scanResults;
  }

  Future<void> startScan() async {
    try {
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 5),
        withServices: [serviceGUID],
      );
    } on Exception {
      return;
    }
  }

  Future<void> connect(BluetoothDevice device) async {
    await device.connect(autoConnect: false, license: License.free);
    services = await device.discoverServices();
    for (var s in services) {
      for (var c in s.characteristics) {
        if (c.uuid == writeGUID) {
          // Store write characteristic
          writeCharacteristic = c;
        }
        if (c.uuid == notifyGUID) {
          // Store notify characteristic and set up notifications
          notifyCharacteristic = c;
          await c.setNotifyValue(true);
        }
      }
    }
  }

  Future<void> disconnect(BluetoothDevice device) async {
    await device.disconnect();
  }

  Stream<BluetoothConnectionState> connectionState(BluetoothDevice device) {
    return device.connectionState;
  }

  Future<void> sendPacket(
    int type,
    int sourceId,
    int destinationId,
    int totalSegments,
    SegmentsCompanion seg,
  ) async {
    final bytes = BytesBuilder();
    final payloadLength = seg.payload.value.length;

    bytes.add([type]);
    bytes.add(Converter.intToUint8List(sourceId, 4));
    bytes.add(Converter.intToUint8List(destinationId, 4));
    bytes.add(Converter.intToUint8List(seg.uid.value, 6));
    bytes.add([seg.segmentIndex.value, totalSegments, payloadLength]);
    bytes.add(seg.payload.value);

    await writeCharacteristic!.write(bytes.toBytes());
  }
}
