import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:lora_app/model/message_with_segments.dart';
import 'package:lora_app/model/tables/messages_table.dart';
import 'package:lora_app/model/tables/segments_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database_service.g.dart';

@DriftDatabase(tables: [Messages, Segments])
class AppDatabase extends _$AppDatabase {
  AppDatabase(String deviceId) : super(_openConnection(deviceId));

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection(String deviceId) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, '$deviceId.sqlite'));
    return NativeDatabase(file);
  });
}

class DatabaseService {
  AppDatabase? db;

  Future<void> closeDatabase() async {
    await db?.close();
    db = null;
  }

  Future<void> openDatabase(String deviceId) async {
    await db?.close();
    db = AppDatabase(deviceId);
  }

  Future<int> insertMessage(MessagesCompanion message) {
    return db!.into(db!.messages).insert(message);
  }

  Future<int> insertSegment(SegmentsCompanion segment) {
    return db!.into(db!.segments).insert(segment);
  }

  Stream<List<MessageWithSegments>> watchMessages(int destinationId) {
    if (db == null) return Stream.empty();

    final query = db!.select(db!.messages)
      ..where((t) => t.destinationId.equals(destinationId))
      ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]);

    return query.watch().asyncMap((messages) async {
      final results = <MessageWithSegments>[];
      final grouped = <int, List<Segment>>{};
      final segments = await db!.select(db!.segments).get();

      for (final s in segments) {
        grouped.putIfAbsent(s.uid, () => []).add(s);
      }
      for (final msg in messages) {
        results.add(MessageWithSegments(msg, grouped[msg.uid] ?? []));
      }
      return results;
    });
  }

  Future<void> incrementSegmentRetry(Segment segment) async {
    if (db == null) return;
    await (db!.update(db!.segments)..where((s) => s.id.equals(segment.id)))
        .write(SegmentsCompanion(retryCount: Value(segment.retryCount + 1)));
  }

  Future<void> markMessageAck(int uid) async {
    if (db == null) return;

    final segmentsList = await (db!.select(
      db!.segments,
    )..where((s) => s.uid.equals(uid))).get();

    if (segmentsList.any((s) => !s.ackReceived)) return;
    await (db!.update(db!.messages)..where((s) => s.uid.equals(uid))).write(
      MessagesCompanion(status: const Value('delivered')),
    );
  }

  Future<void> markSegmentAck(int segmentId) async {
    if (db == null) return;

    await (db!.update(db!.segments)..where((s) => s.id.equals(segmentId)))
        .write(SegmentsCompanion(ackReceived: const Value(true)));
  }

  Future<Segment> getSegment(int uid, int segmentIndex) async {
    final seg = db!.select(db!.segments)
      ..where((s) => s.uid.equals(uid) & s.segmentIndex.equals(segmentIndex));
    return await seg.getSingle();
  }

  Future<bool> checkUID(int uid) async {
    final row = await (db!.select(
      db!.messages,
    )..where((t) => t.uid.equals(uid))).getSingleOrNull();
    return row != null;
  }
}
