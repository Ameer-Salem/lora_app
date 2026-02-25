import 'dart:typed_data';

class Converter {
  static int uint8ListToInt(Uint8List bytes, int length) {
    if (bytes.isEmpty || bytes.length > 6) {
      throw RangeError('Bytes length must be 1–6');
    }

    int value = 0;
    for (int i = 0; i < bytes.length; i++) {
      final shift = (8 * (bytes.length - 1 - i));
      value |= bytes[i] << shift;
    }
    return value;
  }

  static Uint8List intToUint8List(int value, int length) {
    if (length < 1 || length > 6) {
      throw RangeError('Length must be between 1 and 6');
    }

    final bytes = Uint8List(length);
    for (int i = 0; i < length; i++) {
      final shift = (8 * (length - 1 - i));
      bytes[i] = (value >> shift) & 0xFF;
    }
    return bytes;
  }

  static double bytesToFloatBE(Uint8List data, int offset) {
    final byteData = ByteData.sublistView(data, offset, offset + 4);
    return byteData.getFloat32(0, Endian.big);
  }
}
