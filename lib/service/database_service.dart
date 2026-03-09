import 'dart:convert';
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

  Stream<List> getLatestMessages(int myId) {
    return db!.select(db!.messages).watch().map((allMessages) {
      final Map<int, Message> lastMessages = {};

      for (var msg in allMessages) {
        // figure out the other user
        final otherId = msg.sourceId == myId ? msg.destinationId : msg.sourceId;

        // check if we already have a message for this user
        final current = lastMessages[otherId];

        // keep only the newest message
        if (current == null || msg.timestamp > current.timestamp) {
          lastMessages[otherId] = msg;
        }
      }

      // return the newest message per conversation, sorted by time
      final list = lastMessages.values.toList();
      list.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return list;
    });
  }

  Future<void> closeDatabase() async {
    await db?.close();
    db = null;
  }

  Future<void> openDatabase(String deviceId) async {
    await db?.close();
    db = AppDatabase(deviceId);
  }

  Future<int> insertMessage({
    required int? type,
    required int? sourceId,
    required int? destinationId,
    required int? uid,
    required String? status,
    int? totalSegments,
    Uint8List? payload,
  }) async {
    MessagesCompanion message = MessagesCompanion.insert(
      type: type!,
      sourceId: sourceId!,
      destinationId: destinationId!,
      uid: uid!,
      totalSegments: Value(totalSegments!),
      status: status!,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      payload: Value(utf8.decode(payload ?? Uint8List(0))),
    );
    return db!.into(db!.messages).insert(message);
  }

  Future<int> insertSegment({
    int? uid,
    int? segmentIndex,
    bool ackReceived = false,
    Uint8List? payload,
  }) async {
    SegmentsCompanion segment = SegmentsCompanion.insert(
      uid: uid!,
      segmentIndex: segmentIndex!,
      ackReceived: Value(ackReceived),
      payload: payload ?? Uint8List(0),
    );
    return db!.into(db!.segments).insert(segment);
  }

  Stream<List<MessageWithSegments>> watchMessages(String status) {
    if (db == null) return Stream.empty();

    final SimpleSelectStatement<$MessagesTable, Message> query =
        db!.select(db!.messages)
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

  Future<List<Segment>> getPendingSegments({int maxRetries = 3}) async {
    if (db == null) return [];

    return (db!.select(db!.segments)..where(
          (s) =>
              s.ackReceived.equals(false) &
              s.retryCount.isSmallerThanValue(maxRetries),
        ))
        .get();
  }

  Future<void> incrementSegmentRetry(Segment segment) async {
    if (db == null) return;
    await (db!.update(db!.segments)..where((s) => s.id.equals(segment.id)))
        .write(SegmentsCompanion(retryCount: Value(segment.retryCount + 1)));
  }

  Future<void> updateMessage(int uid, String text, String status) async {
    if (db == null) return;

    await (db!.update(db!.messages)..where((s) => s.uid.equals(uid))).write(
      MessagesCompanion(payload: Value(text), status: Value(text)),
    );
  }

  Future<void> markSegmentAck(int uid, int segmentIndex) async {
    if (db == null) return;

    await (db!.update(db!.segments)..where(
          (s) => (s.uid.equals(uid) & s.segmentIndex.equals(segmentIndex)),
        ))
        .write(SegmentsCompanion(ackReceived: const Value(true)));
  }

  Future<void> markMessageAck(int uid, String text) async {
    if (db == null) return;

    await (db!.update(db!.messages)..where((m) => m.uid.equals(uid))).write(
      MessagesCompanion(status: Value(text)),
    );
  }

  Future<Segment?> getSegmentExists(int uid, int segmentIndex) async {
    final seg = db!.select(db!.segments)
      ..where((s) => s.uid.equals(uid) & s.segmentIndex.equals(segmentIndex));
    return await seg.getSingleOrNull();
  }

  Future<List<Segment>> getSegmentsForUid(int uid) {
    return (db!.select(db!.segments)
          ..where((s) => s.uid.equals(uid))
          ..orderBy([(s) => OrderingTerm.asc(s.segmentIndex)]))
        .get();
  }

  Future<Message> getMessage(int uid) async {
    final msg = db!.select(db!.messages)..where((m) => m.uid.equals(uid));
    return await msg.getSingle();
  }

  Future<bool> storedUID(int uid) async {
    final row = await (db!.select(
      db!.messages,
    )..where((t) => t.uid.equals(uid))).getSingleOrNull();
    return row != null;
  }
}
