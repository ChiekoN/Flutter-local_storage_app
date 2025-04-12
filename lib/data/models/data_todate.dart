import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'data_todate.g.dart';

class ToDateDb extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get title => text()();
  TextColumn get memo => text().nullable()();
}

@DriftDatabase(tables: [ToDateDb])
class AppDatabase extends _$AppDatabase {

  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  // Get all entries
  Future<List<ToDateDbData>> getAllItems() => select(toDateDb).get();

  // Add
  Future<int> createItem(ToDateDbCompanion entry) => into(toDateDb).insert(entry);

  // Update
  Future<int> updateItem(ToDateDbCompanion entry) => into(toDateDb).insert(entry);

  // Delete
  Future<int> deleteItem(int id) => 
    (delete(toDateDb)..where((t) => t.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'todo_database.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}