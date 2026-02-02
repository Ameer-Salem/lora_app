import 'package:drift/drift.dart';

class Messages extends Table {
  IntColumn get id => integer().autoIncrement()(); // local DB ID
  IntColumn get uid => integer()();             // globally unique ID (e.g., UUID)
  IntColumn get type => integer()();              // message type (text, voice, file)
  IntColumn get sourceId => integer()();          // source device ID
  IntColumn get destinationId => integer()();        // target device ID
  TextColumn get status => text()();              // pending, sent, delivered, acknowledged, failed
  IntColumn get timestamp => integer()();         // Unix timestamp
  IntColumn get totalSegments => integer().withDefault(const Constant(1))(); // number of segments
  TextColumn get payload => text().nullable()();             // for text messages
  TextColumn get payloadPath => text().nullable()(); // for voice/file messages
}
