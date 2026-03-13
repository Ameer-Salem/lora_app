// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// ignore_for_file: type=lint
class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<int> uid = GeneratedColumn<int>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<int> sourceId = GeneratedColumn<int>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _destinationIdMeta = const VerificationMeta(
    'destinationId',
  );
  @override
  late final GeneratedColumn<int> destinationId = GeneratedColumn<int>(
    'destination_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalSegmentsMeta = const VerificationMeta(
    'totalSegments',
  );
  @override
  late final GeneratedColumn<int> totalSegments = GeneratedColumn<int>(
    'total_segments',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadPathMeta = const VerificationMeta(
    'payloadPath',
  );
  @override
  late final GeneratedColumn<String> payloadPath = GeneratedColumn<String>(
    'payload_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uid,
    type,
    sourceId,
    destinationId,
    status,
    timestamp,
    totalSegments,
    payload,
    payloadPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Message> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('destination_id')) {
      context.handle(
        _destinationIdMeta,
        destinationId.isAcceptableOrUnknown(
          data['destination_id']!,
          _destinationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('total_segments')) {
      context.handle(
        _totalSegmentsMeta,
        totalSegments.isAcceptableOrUnknown(
          data['total_segments']!,
          _totalSegmentsMeta,
        ),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('payload_path')) {
      context.handle(
        _payloadPathMeta,
        payloadPath.isAcceptableOrUnknown(
          data['payload_path']!,
          _payloadPathMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}uid'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_id'],
      )!,
      destinationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}destination_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      totalSegments: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_segments'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      ),
      payloadPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_path'],
      ),
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final int id;
  final int uid;
  final int type;
  final int sourceId;
  final int destinationId;
  final String status;
  final int timestamp;
  final int totalSegments;
  final String? payload;
  final String? payloadPath;
  const Message({
    required this.id,
    required this.uid,
    required this.type,
    required this.sourceId,
    required this.destinationId,
    required this.status,
    required this.timestamp,
    required this.totalSegments,
    this.payload,
    this.payloadPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uid'] = Variable<int>(uid);
    map['type'] = Variable<int>(type);
    map['source_id'] = Variable<int>(sourceId);
    map['destination_id'] = Variable<int>(destinationId);
    map['status'] = Variable<String>(status);
    map['timestamp'] = Variable<int>(timestamp);
    map['total_segments'] = Variable<int>(totalSegments);
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    if (!nullToAbsent || payloadPath != null) {
      map['payload_path'] = Variable<String>(payloadPath);
    }
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      uid: Value(uid),
      type: Value(type),
      sourceId: Value(sourceId),
      destinationId: Value(destinationId),
      status: Value(status),
      timestamp: Value(timestamp),
      totalSegments: Value(totalSegments),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
      payloadPath: payloadPath == null && nullToAbsent
          ? const Value.absent()
          : Value(payloadPath),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<int>(json['id']),
      uid: serializer.fromJson<int>(json['uid']),
      type: serializer.fromJson<int>(json['type']),
      sourceId: serializer.fromJson<int>(json['sourceId']),
      destinationId: serializer.fromJson<int>(json['destinationId']),
      status: serializer.fromJson<String>(json['status']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      totalSegments: serializer.fromJson<int>(json['totalSegments']),
      payload: serializer.fromJson<String?>(json['payload']),
      payloadPath: serializer.fromJson<String?>(json['payloadPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uid': serializer.toJson<int>(uid),
      'type': serializer.toJson<int>(type),
      'sourceId': serializer.toJson<int>(sourceId),
      'destinationId': serializer.toJson<int>(destinationId),
      'status': serializer.toJson<String>(status),
      'timestamp': serializer.toJson<int>(timestamp),
      'totalSegments': serializer.toJson<int>(totalSegments),
      'payload': serializer.toJson<String?>(payload),
      'payloadPath': serializer.toJson<String?>(payloadPath),
    };
  }

  Message copyWith({
    int? id,
    int? uid,
    int? type,
    int? sourceId,
    int? destinationId,
    String? status,
    int? timestamp,
    int? totalSegments,
    Value<String?> payload = const Value.absent(),
    Value<String?> payloadPath = const Value.absent(),
  }) => Message(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    type: type ?? this.type,
    sourceId: sourceId ?? this.sourceId,
    destinationId: destinationId ?? this.destinationId,
    status: status ?? this.status,
    timestamp: timestamp ?? this.timestamp,
    totalSegments: totalSegments ?? this.totalSegments,
    payload: payload.present ? payload.value : this.payload,
    payloadPath: payloadPath.present ? payloadPath.value : this.payloadPath,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      type: data.type.present ? data.type.value : this.type,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      destinationId: data.destinationId.present
          ? data.destinationId.value
          : this.destinationId,
      status: data.status.present ? data.status.value : this.status,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      totalSegments: data.totalSegments.present
          ? data.totalSegments.value
          : this.totalSegments,
      payload: data.payload.present ? data.payload.value : this.payload,
      payloadPath: data.payloadPath.present
          ? data.payloadPath.value
          : this.payloadPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('type: $type, ')
          ..write('sourceId: $sourceId, ')
          ..write('destinationId: $destinationId, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp, ')
          ..write('totalSegments: $totalSegments, ')
          ..write('payload: $payload, ')
          ..write('payloadPath: $payloadPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uid,
    type,
    sourceId,
    destinationId,
    status,
    timestamp,
    totalSegments,
    payload,
    payloadPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.type == this.type &&
          other.sourceId == this.sourceId &&
          other.destinationId == this.destinationId &&
          other.status == this.status &&
          other.timestamp == this.timestamp &&
          other.totalSegments == this.totalSegments &&
          other.payload == this.payload &&
          other.payloadPath == this.payloadPath);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<int> uid;
  final Value<int> type;
  final Value<int> sourceId;
  final Value<int> destinationId;
  final Value<String> status;
  final Value<int> timestamp;
  final Value<int> totalSegments;
  final Value<String?> payload;
  final Value<String?> payloadPath;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.type = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.destinationId = const Value.absent(),
    this.status = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.totalSegments = const Value.absent(),
    this.payload = const Value.absent(),
    this.payloadPath = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required int uid,
    required int type,
    required int sourceId,
    required int destinationId,
    required String status,
    required int timestamp,
    this.totalSegments = const Value.absent(),
    this.payload = const Value.absent(),
    this.payloadPath = const Value.absent(),
  }) : uid = Value(uid),
       type = Value(type),
       sourceId = Value(sourceId),
       destinationId = Value(destinationId),
       status = Value(status),
       timestamp = Value(timestamp);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<int>? uid,
    Expression<int>? type,
    Expression<int>? sourceId,
    Expression<int>? destinationId,
    Expression<String>? status,
    Expression<int>? timestamp,
    Expression<int>? totalSegments,
    Expression<String>? payload,
    Expression<String>? payloadPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (type != null) 'type': type,
      if (sourceId != null) 'source_id': sourceId,
      if (destinationId != null) 'destination_id': destinationId,
      if (status != null) 'status': status,
      if (timestamp != null) 'timestamp': timestamp,
      if (totalSegments != null) 'total_segments': totalSegments,
      if (payload != null) 'payload': payload,
      if (payloadPath != null) 'payload_path': payloadPath,
    });
  }

  MessagesCompanion copyWith({
    Value<int>? id,
    Value<int>? uid,
    Value<int>? type,
    Value<int>? sourceId,
    Value<int>? destinationId,
    Value<String>? status,
    Value<int>? timestamp,
    Value<int>? totalSegments,
    Value<String?>? payload,
    Value<String?>? payloadPath,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      type: type ?? this.type,
      sourceId: sourceId ?? this.sourceId,
      destinationId: destinationId ?? this.destinationId,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      totalSegments: totalSegments ?? this.totalSegments,
      payload: payload ?? this.payload,
      payloadPath: payloadPath ?? this.payloadPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<int>(uid.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<int>(sourceId.value);
    }
    if (destinationId.present) {
      map['destination_id'] = Variable<int>(destinationId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (totalSegments.present) {
      map['total_segments'] = Variable<int>(totalSegments.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (payloadPath.present) {
      map['payload_path'] = Variable<String>(payloadPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('type: $type, ')
          ..write('sourceId: $sourceId, ')
          ..write('destinationId: $destinationId, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp, ')
          ..write('totalSegments: $totalSegments, ')
          ..write('payload: $payload, ')
          ..write('payloadPath: $payloadPath')
          ..write(')'))
        .toString();
  }
}

class $SegmentsTable extends Segments with TableInfo<$SegmentsTable, Segment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SegmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<int> uid = GeneratedColumn<int>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _segmentIndexMeta = const VerificationMeta(
    'segmentIndex',
  );
  @override
  late final GeneratedColumn<int> segmentIndex = GeneratedColumn<int>(
    'segment_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ackReceivedMeta = const VerificationMeta(
    'ackReceived',
  );
  @override
  late final GeneratedColumn<bool> ackReceived = GeneratedColumn<bool>(
    'ack_received',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ack_received" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<Uint8List> payload = GeneratedColumn<Uint8List>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uid,
    segmentIndex,
    ackReceived,
    retryCount,
    payload,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'segments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Segment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('segment_index')) {
      context.handle(
        _segmentIndexMeta,
        segmentIndex.isAcceptableOrUnknown(
          data['segment_index']!,
          _segmentIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_segmentIndexMeta);
    }
    if (data.containsKey('ack_received')) {
      context.handle(
        _ackReceivedMeta,
        ackReceived.isAcceptableOrUnknown(
          data['ack_received']!,
          _ackReceivedMeta,
        ),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Segment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Segment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}uid'],
      )!,
      segmentIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}segment_index'],
      )!,
      ackReceived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ack_received'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}payload'],
      )!,
    );
  }

  @override
  $SegmentsTable createAlias(String alias) {
    return $SegmentsTable(attachedDatabase, alias);
  }
}

class Segment extends DataClass implements Insertable<Segment> {
  final int id;
  final int uid;
  final int segmentIndex;
  final bool ackReceived;
  final int retryCount;
  final Uint8List payload;
  const Segment({
    required this.id,
    required this.uid,
    required this.segmentIndex,
    required this.ackReceived,
    required this.retryCount,
    required this.payload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uid'] = Variable<int>(uid);
    map['segment_index'] = Variable<int>(segmentIndex);
    map['ack_received'] = Variable<bool>(ackReceived);
    map['retry_count'] = Variable<int>(retryCount);
    map['payload'] = Variable<Uint8List>(payload);
    return map;
  }

  SegmentsCompanion toCompanion(bool nullToAbsent) {
    return SegmentsCompanion(
      id: Value(id),
      uid: Value(uid),
      segmentIndex: Value(segmentIndex),
      ackReceived: Value(ackReceived),
      retryCount: Value(retryCount),
      payload: Value(payload),
    );
  }

  factory Segment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Segment(
      id: serializer.fromJson<int>(json['id']),
      uid: serializer.fromJson<int>(json['uid']),
      segmentIndex: serializer.fromJson<int>(json['segmentIndex']),
      ackReceived: serializer.fromJson<bool>(json['ackReceived']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      payload: serializer.fromJson<Uint8List>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uid': serializer.toJson<int>(uid),
      'segmentIndex': serializer.toJson<int>(segmentIndex),
      'ackReceived': serializer.toJson<bool>(ackReceived),
      'retryCount': serializer.toJson<int>(retryCount),
      'payload': serializer.toJson<Uint8List>(payload),
    };
  }

  Segment copyWith({
    int? id,
    int? uid,
    int? segmentIndex,
    bool? ackReceived,
    int? retryCount,
    Uint8List? payload,
  }) => Segment(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    segmentIndex: segmentIndex ?? this.segmentIndex,
    ackReceived: ackReceived ?? this.ackReceived,
    retryCount: retryCount ?? this.retryCount,
    payload: payload ?? this.payload,
  );
  Segment copyWithCompanion(SegmentsCompanion data) {
    return Segment(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      segmentIndex: data.segmentIndex.present
          ? data.segmentIndex.value
          : this.segmentIndex,
      ackReceived: data.ackReceived.present
          ? data.ackReceived.value
          : this.ackReceived,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      payload: data.payload.present ? data.payload.value : this.payload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Segment(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('segmentIndex: $segmentIndex, ')
          ..write('ackReceived: $ackReceived, ')
          ..write('retryCount: $retryCount, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uid,
    segmentIndex,
    ackReceived,
    retryCount,
    $driftBlobEquality.hash(payload),
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Segment &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.segmentIndex == this.segmentIndex &&
          other.ackReceived == this.ackReceived &&
          other.retryCount == this.retryCount &&
          $driftBlobEquality.equals(other.payload, this.payload));
}

class SegmentsCompanion extends UpdateCompanion<Segment> {
  final Value<int> id;
  final Value<int> uid;
  final Value<int> segmentIndex;
  final Value<bool> ackReceived;
  final Value<int> retryCount;
  final Value<Uint8List> payload;
  const SegmentsCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.segmentIndex = const Value.absent(),
    this.ackReceived = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.payload = const Value.absent(),
  });
  SegmentsCompanion.insert({
    this.id = const Value.absent(),
    required int uid,
    required int segmentIndex,
    this.ackReceived = const Value.absent(),
    this.retryCount = const Value.absent(),
    required Uint8List payload,
  }) : uid = Value(uid),
       segmentIndex = Value(segmentIndex),
       payload = Value(payload);
  static Insertable<Segment> custom({
    Expression<int>? id,
    Expression<int>? uid,
    Expression<int>? segmentIndex,
    Expression<bool>? ackReceived,
    Expression<int>? retryCount,
    Expression<Uint8List>? payload,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (segmentIndex != null) 'segment_index': segmentIndex,
      if (ackReceived != null) 'ack_received': ackReceived,
      if (retryCount != null) 'retry_count': retryCount,
      if (payload != null) 'payload': payload,
    });
  }

  SegmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? uid,
    Value<int>? segmentIndex,
    Value<bool>? ackReceived,
    Value<int>? retryCount,
    Value<Uint8List>? payload,
  }) {
    return SegmentsCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      segmentIndex: segmentIndex ?? this.segmentIndex,
      ackReceived: ackReceived ?? this.ackReceived,
      retryCount: retryCount ?? this.retryCount,
      payload: payload ?? this.payload,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<int>(uid.value);
    }
    if (segmentIndex.present) {
      map['segment_index'] = Variable<int>(segmentIndex.value);
    }
    if (ackReceived.present) {
      map['ack_received'] = Variable<bool>(ackReceived.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (payload.present) {
      map['payload'] = Variable<Uint8List>(payload.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SegmentsCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('segmentIndex: $segmentIndex, ')
          ..write('ackReceived: $ackReceived, ')
          ..write('retryCount: $retryCount, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<int> address = GeneratedColumn<int>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSeenMeta = const VerificationMeta(
    'lastSeen',
  );
  @override
  late final GeneratedColumn<int> lastSeen = GeneratedColumn<int>(
    'last_seen',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rssiMeta = const VerificationMeta('rssi');
  @override
  late final GeneratedColumn<int> rssi = GeneratedColumn<int>(
    'rssi',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    address,
    name,
    lastSeen,
    latitude,
    longitude,
    rssi,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('last_seen')) {
      context.handle(
        _lastSeenMeta,
        lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta),
      );
    } else if (isInserting) {
      context.missing(_lastSeenMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('rssi')) {
      context.handle(
        _rssiMeta,
        rssi.isAcceptableOrUnknown(data['rssi']!, _rssiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {address};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}address'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      lastSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_seen'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      rssi: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rssi'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int address;
  final String? name;
  final int lastSeen;
  final double? latitude;
  final double? longitude;
  final int? rssi;
  const User({
    required this.address,
    this.name,
    required this.lastSeen,
    this.latitude,
    this.longitude,
    this.rssi,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['address'] = Variable<int>(address);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['last_seen'] = Variable<int>(lastSeen);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || rssi != null) {
      map['rssi'] = Variable<int>(rssi);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      address: Value(address),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      lastSeen: Value(lastSeen),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      rssi: rssi == null && nullToAbsent ? const Value.absent() : Value(rssi),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      address: serializer.fromJson<int>(json['address']),
      name: serializer.fromJson<String?>(json['name']),
      lastSeen: serializer.fromJson<int>(json['lastSeen']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      rssi: serializer.fromJson<int?>(json['rssi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'address': serializer.toJson<int>(address),
      'name': serializer.toJson<String?>(name),
      'lastSeen': serializer.toJson<int>(lastSeen),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'rssi': serializer.toJson<int?>(rssi),
    };
  }

  User copyWith({
    int? address,
    Value<String?> name = const Value.absent(),
    int? lastSeen,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<int?> rssi = const Value.absent(),
  }) => User(
    address: address ?? this.address,
    name: name.present ? name.value : this.name,
    lastSeen: lastSeen ?? this.lastSeen,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    rssi: rssi.present ? rssi.value : this.rssi,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      address: data.address.present ? data.address.value : this.address,
      name: data.name.present ? data.name.value : this.name,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      rssi: data.rssi.present ? data.rssi.value : this.rssi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('address: $address, ')
          ..write('name: $name, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('rssi: $rssi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(address, name, lastSeen, latitude, longitude, rssi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.address == this.address &&
          other.name == this.name &&
          other.lastSeen == this.lastSeen &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.rssi == this.rssi);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> address;
  final Value<String?> name;
  final Value<int> lastSeen;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<int?> rssi;
  const UsersCompanion({
    this.address = const Value.absent(),
    this.name = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.rssi = const Value.absent(),
  });
  UsersCompanion.insert({
    this.address = const Value.absent(),
    this.name = const Value.absent(),
    required int lastSeen,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.rssi = const Value.absent(),
  }) : lastSeen = Value(lastSeen);
  static Insertable<User> custom({
    Expression<int>? address,
    Expression<String>? name,
    Expression<int>? lastSeen,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<int>? rssi,
  }) {
    return RawValuesInsertable({
      if (address != null) 'address': address,
      if (name != null) 'name': name,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (rssi != null) 'rssi': rssi,
    });
  }

  UsersCompanion copyWith({
    Value<int>? address,
    Value<String?>? name,
    Value<int>? lastSeen,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<int?>? rssi,
  }) {
    return UsersCompanion(
      address: address ?? this.address,
      name: name ?? this.name,
      lastSeen: lastSeen ?? this.lastSeen,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rssi: rssi ?? this.rssi,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (address.present) {
      map['address'] = Variable<int>(address.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<int>(lastSeen.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (rssi.present) {
      map['rssi'] = Variable<int>(rssi.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('address: $address, ')
          ..write('name: $name, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('rssi: $rssi')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $SegmentsTable segments = $SegmentsTable(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    messages,
    segments,
    users,
  ];
}

typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      required int uid,
      required int type,
      required int sourceId,
      required int destinationId,
      required String status,
      required int timestamp,
      Value<int> totalSegments,
      Value<String?> payload,
      Value<String?> payloadPath,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      Value<int> uid,
      Value<int> type,
      Value<int> sourceId,
      Value<int> destinationId,
      Value<String> status,
      Value<int> timestamp,
      Value<int> totalSegments,
      Value<String?> payload,
      Value<String?> payloadPath,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get destinationId => $composableBuilder(
    column: $table.destinationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSegments => $composableBuilder(
    column: $table.totalSegments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadPath => $composableBuilder(
    column: $table.payloadPath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get destinationId => $composableBuilder(
    column: $table.destinationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSegments => $composableBuilder(
    column: $table.totalSegments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadPath => $composableBuilder(
    column: $table.payloadPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<int> get destinationId => $composableBuilder(
    column: $table.destinationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get totalSegments => $composableBuilder(
    column: $table.totalSegments,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get payloadPath => $composableBuilder(
    column: $table.payloadPath,
    builder: (column) => column,
  );
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
          Message,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> uid = const Value.absent(),
                Value<int> type = const Value.absent(),
                Value<int> sourceId = const Value.absent(),
                Value<int> destinationId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<int> totalSegments = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<String?> payloadPath = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                uid: uid,
                type: type,
                sourceId: sourceId,
                destinationId: destinationId,
                status: status,
                timestamp: timestamp,
                totalSegments: totalSegments,
                payload: payload,
                payloadPath: payloadPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int uid,
                required int type,
                required int sourceId,
                required int destinationId,
                required String status,
                required int timestamp,
                Value<int> totalSegments = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<String?> payloadPath = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                uid: uid,
                type: type,
                sourceId: sourceId,
                destinationId: destinationId,
                status: status,
                timestamp: timestamp,
                totalSegments: totalSegments,
                payload: payload,
                payloadPath: payloadPath,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
      Message,
      PrefetchHooks Function()
    >;
typedef $$SegmentsTableCreateCompanionBuilder =
    SegmentsCompanion Function({
      Value<int> id,
      required int uid,
      required int segmentIndex,
      Value<bool> ackReceived,
      Value<int> retryCount,
      required Uint8List payload,
    });
typedef $$SegmentsTableUpdateCompanionBuilder =
    SegmentsCompanion Function({
      Value<int> id,
      Value<int> uid,
      Value<int> segmentIndex,
      Value<bool> ackReceived,
      Value<int> retryCount,
      Value<Uint8List> payload,
    });

class $$SegmentsTableFilterComposer
    extends Composer<_$AppDatabase, $SegmentsTable> {
  $$SegmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get segmentIndex => $composableBuilder(
    column: $table.segmentIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get ackReceived => $composableBuilder(
    column: $table.ackReceived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SegmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $SegmentsTable> {
  $$SegmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get segmentIndex => $composableBuilder(
    column: $table.segmentIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get ackReceived => $composableBuilder(
    column: $table.ackReceived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SegmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SegmentsTable> {
  $$SegmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<int> get segmentIndex => $composableBuilder(
    column: $table.segmentIndex,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get ackReceived => $composableBuilder(
    column: $table.ackReceived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);
}

class $$SegmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SegmentsTable,
          Segment,
          $$SegmentsTableFilterComposer,
          $$SegmentsTableOrderingComposer,
          $$SegmentsTableAnnotationComposer,
          $$SegmentsTableCreateCompanionBuilder,
          $$SegmentsTableUpdateCompanionBuilder,
          (Segment, BaseReferences<_$AppDatabase, $SegmentsTable, Segment>),
          Segment,
          PrefetchHooks Function()
        > {
  $$SegmentsTableTableManager(_$AppDatabase db, $SegmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SegmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SegmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SegmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> uid = const Value.absent(),
                Value<int> segmentIndex = const Value.absent(),
                Value<bool> ackReceived = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<Uint8List> payload = const Value.absent(),
              }) => SegmentsCompanion(
                id: id,
                uid: uid,
                segmentIndex: segmentIndex,
                ackReceived: ackReceived,
                retryCount: retryCount,
                payload: payload,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int uid,
                required int segmentIndex,
                Value<bool> ackReceived = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                required Uint8List payload,
              }) => SegmentsCompanion.insert(
                id: id,
                uid: uid,
                segmentIndex: segmentIndex,
                ackReceived: ackReceived,
                retryCount: retryCount,
                payload: payload,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SegmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SegmentsTable,
      Segment,
      $$SegmentsTableFilterComposer,
      $$SegmentsTableOrderingComposer,
      $$SegmentsTableAnnotationComposer,
      $$SegmentsTableCreateCompanionBuilder,
      $$SegmentsTableUpdateCompanionBuilder,
      (Segment, BaseReferences<_$AppDatabase, $SegmentsTable, Segment>),
      Segment,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> address,
      Value<String?> name,
      required int lastSeen,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<int?> rssi,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> address,
      Value<String?> name,
      Value<int> lastSeen,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<int?> rssi,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rssi => $composableBuilder(
    column: $table.rssi,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rssi => $composableBuilder(
    column: $table.rssi,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<int> get rssi =>
      $composableBuilder(column: $table.rssi, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> address = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<int> lastSeen = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<int?> rssi = const Value.absent(),
              }) => UsersCompanion(
                address: address,
                name: name,
                lastSeen: lastSeen,
                latitude: latitude,
                longitude: longitude,
                rssi: rssi,
              ),
          createCompanionCallback:
              ({
                Value<int> address = const Value.absent(),
                Value<String?> name = const Value.absent(),
                required int lastSeen,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<int?> rssi = const Value.absent(),
              }) => UsersCompanion.insert(
                address: address,
                name: name,
                lastSeen: lastSeen,
                latitude: latitude,
                longitude: longitude,
                rssi: rssi,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$SegmentsTableTableManager get segments =>
      $$SegmentsTableTableManager(_db, _db.segments);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
