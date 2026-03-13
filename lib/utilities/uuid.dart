import 'package:uuid/uuid.dart';
import 'dart:typed_data';


class GetUUID {
  // take first 6 bytes = 48 bits
  static int uid48() {
    final bytes = Uuid().v4obj().toBytes();
    final data = ByteData.sublistView(Uint8List.fromList(bytes));
    final int uid48 =
        data.getUint16(0, Endian.big) << 32 | data.getUint32(2, Endian.big);
    return uid48;
  }
}
