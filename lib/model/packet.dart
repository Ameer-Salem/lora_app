import 'dart:typed_data';

import 'package:lora_app/utilities/converter.dart';

class Packet {
  final int type;
  final int sourceId;
  final int destinationId;
  final int uid;
  final int segmentIndex;
  final int totalSegments;
  final Uint8List payload;

  Packet({
    required this.type,
    required this.sourceId,
    required this.destinationId,
    required this.uid,
    required this.segmentIndex,
    required this.totalSegments,
    required this.payload,
  });

  /// Serialize to bytes
  Uint8List toBytes() {
    final bytes = BytesBuilder();
    final payloadLength = payload.length;
    bytes.add([type]);
    bytes.add(Converter.intToUint8List(sourceId, 4));
    bytes.add(Converter.intToUint8List(destinationId, 4));
    bytes.add(Converter.intToUint8List(uid, 6));
    bytes.add([segmentIndex, totalSegments, payloadLength]);
    bytes.add(payload);
    return bytes.toBytes();
  }

  /// Parse bytes into Packet. Returns null if format invalid.
  static Packet? fromBytes(Uint8List data) {
    if (data.length < 2) return null;

    int offset = 0;
    final type = data[offset++];
    final sourceId = Converter.uint8ListToInt(
      data.sublist(offset, offset + 4), 4
    );
    offset += 4;
    final destinationId = Converter.uint8ListToInt(
      data.sublist(offset, offset + 4),4
    );
    offset += 4;
    final uid = Converter.uint8ListToInt(data.sublist(offset, offset + 6) , 6);
    offset += 6;
    final segmentIndex = data[offset];
    offset += 1;
    final totalSegments = data[offset];
    offset += 1;
    final payloadLength = data[offset];
    offset += 1;
    if (data.length < offset + payloadLength) return null;
    final payload = data.sublist(offset, offset + payloadLength);
    return Packet(
      type: type,
      sourceId: sourceId,
      destinationId: destinationId,
      uid: uid,
      segmentIndex: segmentIndex,
      totalSegments: totalSegments,
      payload: Uint8List.fromList(payload),
    );
  }
}
