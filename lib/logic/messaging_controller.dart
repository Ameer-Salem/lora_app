import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/logic/session_controller.dart';
import 'package:lora_app/model/message_with_segments.dart';
import 'package:lora_app/model/packet.dart';
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

  void watchMessages(int destinationId)  {
    _sub?.cancel();
    state = const AsyncValue.loading();
    _sub = _db.watchMessages(Constants.delivered).listen((messages) {
      if (messages.isEmpty) return;

      state = AsyncValue.data(
        messages
            .where(
              (x) =>
                  x.message.destinationId == destinationId ||
                  x.message.sourceId == destinationId,
            )
            .toList(),
      );
    }, onError: (e, _) => state = AsyncValue.error(e, StackTrace.current));
  }

  void onTextPacket(Packet packet) async {
    final existsUID = await _db.storedUID(packet.uid);
    if (!existsUID) {
      await _db.insertMessage(
        type: packet.type,
        sourceId: packet.sourceId,
        destinationId: packet.destinationId,
        uid: packet.uid,
        totalSegments: packet.totalSegments,
        status: Constants.pending,
      );
    }
    if (await _db.getSegmentExists(packet.uid, packet.segmentIndex) == null) {
      await _db.insertSegment(
        uid: packet.uid,
        segmentIndex: packet.segmentIndex,
        payload: packet.payload,
        ackReceived: true,
      );
    }
    ref
        .read(bleServiceProvider)
        .sendPacket(
          type: Constants.ackTYPE,
          sourceId: packet.destinationId,
          destinationId: packet.sourceId,
          uid: packet.uid,
          segmentIndex: packet.segmentIndex,
          totalSegments: packet.totalSegments,
        );
    final segments = await _db.getSegmentsForUid(packet.uid);
    if (segments.length != packet.totalSegments) return;
    final buffer = BytesBuilder();
    for (final s in segments) {
      buffer.add(s.payload);
    }
    final fullBytes = buffer.toBytes();
    final text = utf8.decode(fullBytes);
    await _db.updateMessage(packet.uid, text, Constants.delivered);
  }

  void onACKPacket(Packet packet) async {
    await _db.markSegmentAck(packet.uid, packet.segmentIndex);
    final segments = await _db.getSegmentsForUid(packet.uid);
    
    if (segments.length != packet.totalSegments) return;
    await _db.markMessageAck(packet.uid, Constants.delivered);
  }

  Future<void> sendText(int destinationId, String text) async {
    if( await _db.getUser(destinationId) == null) _db.insertOrUpdateUser(address: destinationId);
    final bytes = Uint8List.fromList(utf8.encode(text));
    final sourceId = ref.read(connectionStatusProvider).device!.id;
    int uid;
    do {
      uid = GetUUID.uid48();
    } while (await _db.storedUID(uid));
    final totalSegments = (bytes.length / Constants.segmentSize).ceil();

    await _db.insertMessage(
      type: Constants.textTYPE,
      sourceId: int.parse(sourceId),
      destinationId: destinationId,
      uid: uid,
      totalSegments: totalSegments,
      payload: bytes,
      status: Constants.pending,
    );

    for (var i = 0; i < bytes.length; i += Constants.segmentSize) {
      final segmentIndex = i ~/ Constants.segmentSize + 1;
      final end = (i + Constants.segmentSize < bytes.length)
          ? i + Constants.segmentSize
          : bytes.length;
      final payload = bytes.sublist(i, end);

      await _db.insertSegment(
        uid: uid,
        segmentIndex: segmentIndex,
        payload: payload,
      );
      
      await ref
          .read(bleServiceProvider)
          .sendPacket(
            type: Constants.textTYPE,
            sourceId: int.parse(sourceId),
            destinationId: destinationId,
            uid: uid,
            totalSegments: totalSegments,
            segmentIndex: segmentIndex,
            payload: payload,
          );
    }
  }
}
