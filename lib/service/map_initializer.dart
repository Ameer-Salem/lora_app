import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class MapInitializer {
  static const assetPath = 'assets/maps/najaf.mbtiles';
  static const fileName = 'najaf.mbtiles';

  static Future<String> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$fileName';
    final file = File(path);

    if (!await file.exists()) {
      // Load asset in main isolate (safe)
      final data = await rootBundle.load(assetPath);

      // Optionally, write in a separate isolate (just the bytes)
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    }

    return path;
  }
}