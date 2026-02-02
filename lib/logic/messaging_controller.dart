import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/logic/session_controller.dart';
import 'package:lora_app/model/message_with_segments.dart';
import 'package:lora_app/service/database_service.dart';
import 'package:lora_app/utilities/constants.dart';
import 'package:lora_app/utilities/uuid.dart';

final messagesProvider =
    NotifierProvider<MessagesNotifier, AsyncValue<List<MessageWithSegments>>>(
      MessagesNotifier.new,
    );

class MessagesNotifier extends Notifier<AsyncValue<List<MessageWithSegments>>> {
  late final DatabaseService _db;
  StreamSubscription? _sub;

  @override
  AsyncValue<List<MessageWithSegments>> build() {
    _db = ref.read(databaseServiceProvider);
    ref.onDispose(() => _sub?.cancel());
    ref.listen(connectionStatusProvider, (_, next) {
      if (next.status == ConnectionStatus.disconnected) {
        state = const AsyncValue.loading();
      }
    });
    return const AsyncValue.loading();
  }

  void watchMessages(int destinationId) {
    _sub?.cancel();
    state = const AsyncValue.loading();
    _sub = _db
        .watchMessages(destinationId)
        .listen(
          (messages) => state = AsyncValue.data(messages),
          onError: (e, _) => state = AsyncValue.error(e, StackTrace.current),
        );
  }

  void onTextPacket(Uint8List data) {}

  void onACKPacket(Uint8List data) {}

  Future<void> sendText(int destinationId, String text) async {
    final bytes = Uint8List.fromList(utf8.encode(text));
    final sourceId = ref.read(connectionStatusProvider).device!.id;
    int uid;
    do {
      uid = GetUUID.uid48();
    } while (await _db.checkUID(uid));

    final message = buildTextMessage(sourceId, destinationId, text, uid, bytes);
    await _db.insertMessage(message);

    final segments = buildTextSegments(message, bytes);
    for (final segment in segments) {
      await _db.insertSegment(segment);

      await ref
          .read(bleServiceProvider)
          .sendPacket(
            Constants.textTYPE,
            int.parse(sourceId),
            destinationId,
            message.totalSegments.value,
            segment,
          );
    }
  }
}

List<SegmentsCompanion> buildTextSegments(
  MessagesCompanion message,
  Uint8List bytes,
) {
  List<SegmentsCompanion> segmentsCompanions = [];
  for (
    int offset = 0, index = 0;
    offset < bytes.length;
    offset += Constants.segmentSize, index++
  ) {
    final end = (offset + Constants.segmentSize).clamp(0, bytes.length);

    final payload = bytes.sublist(offset, end);

    segmentsCompanions.add(
      SegmentsCompanion.insert(
        uid: message.uid.value,
        segmentIndex: index,
        payload: payload,
      ),
    );
  }

  return segmentsCompanions;
}

MessagesCompanion buildTextMessage(
  String sourceId,
  int destinationId,
  String text,
  int uid,
  Uint8List bytes,
) {
  final totalSegments = (bytes.length / Constants.segmentSize).ceil();

  MessagesCompanion message = MessagesCompanion.insert(
    destinationId: (destinationId),
    payload: Value(text),
    timestamp: (DateTime.now().millisecondsSinceEpoch),
    uid: uid,
    type: Constants.textTYPE,
    sourceId: int.parse(sourceId),
    status: 'pending',
    totalSegments: Value(totalSegments),
  );
  return message;
}
