import 'package:drift/drift.dart';

class Segments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get uid => integer().customConstraint('REFERENCES messages(uid)')();
  IntColumn get segmentIndex => integer()();       // 0..N-1
  BoolColumn get ackReceived => boolean().withDefault(const Constant(false))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  BlobColumn get payload => blob()();                 // actual segment bytes
}