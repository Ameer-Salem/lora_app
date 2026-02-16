import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/model/neighbor.dart';
import 'package:lora_app/service/ble_service.dart';
import 'package:lora_app/utilities/constants.dart';

final neighborsProvider = NotifierProvider<NeighborsNotifier, List<Neighbor>>(
  NeighborsNotifier.new,
);

class NeighborsNotifier extends Notifier<List<Neighbor>> {
  late final BleService _ble;
  @override
  List<Neighbor> build() {
    _ble = ref.read(bleServiceProvider);
    return [];
  }

  void updateFromPacket(Uint8List data) {
    state = onNeighborsPacket(data);
  }

  void clear() {
    state = [];
  }

  Future<void> getNeighbors() async {
    await _ble.writeCharacteristic!.write([Constants.neighborsTYPE]);
  }

  List<Neighbor> onNeighborsPacket(Uint8List bytes) {
    int offset = 1;

    final count = bytes[offset++];

    final neighbors = <Neighbor>[];

    for (int i = 0; i < count; i++) {
      final id = bytes.buffer.asByteData().getUint32(offset, Endian.big);
      offset += 4;

      final rssi = bytes.buffer.asByteData().getInt8(offset++);

      final lastSeen = bytes.buffer.asByteData().getUint32(offset, Endian.big);
      offset += 4;

      neighbors.add(Neighbor(id, rssi, lastSeen));
      state = neighbors;
    }

    return neighbors;
  }
}
