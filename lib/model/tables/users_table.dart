import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get address => integer()(); // integer address
  TextColumn get name => text().nullable()();
  IntColumn get lastSeen => integer()(); // timestamp in millis
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  IntColumn get rssi => integer().nullable()();

  @override
  Set<Column> get primaryKey => {address};
}
