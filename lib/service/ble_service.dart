import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:lora_app/utilities/converter.dart';

class BleService {
  Guid serviceGUID = Guid('ffffffff-ffff-ffff-ffff-ffffffffffff');
  Guid notifyGUID = Guid('ffffffff-ffff-ffff-ffff-fffffffffff0');
  Guid writeGUID = Guid('ffffffff-ffff-ffff-ffff-fffffffff000');
  int? deviceID;
  List<BluetoothService> services = [];
  BluetoothCharacteristic? writeCharacteristic;
  BluetoothCharacteristic? notifyCharacteristic;

  Future<void> turnOn() async {
    await FlutterBluePlus.turnOn();
  }

  Future<void> connect(BluetoothDevice device) async {
    await device.connect(autoConnect: false, license: License.free);
    deviceID = int.parse(device.platformName);
    services = await device.discoverServices();
    for (var s in services) {
      for (var c in s.characteristics) {
        if (c.uuid == writeGUID) {
          // Store write characteristic
          writeCharacteristic = c;
          
        }
        if (c.uuid == notifyGUID) {
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

  Future<void> sendPacket({
    int? type,
    int sourceId = 0,
    int destinationId = 0,
    int uid = 0,
    int totalSegments = 1,
    int segmentIndex = 1,
    Uint8List? payload,
  }) async {
    final bytes = BytesBuilder();
    final payloadLength = payload != null ? payload.length : 0;

    bytes.add([type!]);
    bytes.add(Converter.intToUint8List(sourceId, 4));
    bytes.add(Converter.intToUint8List(destinationId, 4));
    bytes.add(Converter.intToUint8List(uid, 6));
    bytes.add([segmentIndex, totalSegments, payloadLength]);
    bytes.add(payload ?? Uint8List(0));

    await writeCharacteristic!.write(bytes.toBytes() ,allowLongWrite: true);
  }
}
