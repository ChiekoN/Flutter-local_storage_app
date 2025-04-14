//import 'dart:js_interop';

import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';

import '../../domain/models/todate.dart';
import '../../domain/repository/todate_repo.dart';
import '../models/data_todate.dart';

class TodateRepoData implements TodateRepo {

  /*
  // Initial data for a sample
  List<Todate> todates = [
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2024, 12, 27),
      title: 'Camping in Margaret River',
      memo: 'Conto campground, 2 nights',
    ),
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2025, 2, 25),
      title: 'Perth business meeting',
      memo: 'At Firaobo 6:00pm',
    ),
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2025, 7, 15),
      title: 'Emma\'s wedding',
      memo: 'At Crown Hall at 11:00am',
    ),
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2025, 10, 3),
      title: 'Holiday in Bangkok',
      memo: 'Return on 10/8',
    ),
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2025, 11, 7),
      title: 'My birthday',
      memo: 'No plan yet',
    ),
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2025, 12, 15),
      title: 'Christmas event',
      memo: 'No plan yet',
    ),
  ];
  */

  final AppDatabase _database = AppDatabase();

  @override
  Future<List<Todate>> getTodates() async {

    List<TodateDbData> todatesDb = await _database.getAllItems();
    List<Todate> todates = todatesDb.map(
      (entry) => Todate(
        id: entry.id.toString(),
        date: entry.date,
        title: entry.title,
        memo: entry.memo,
      )).toList();
    return sortTodates(todates);
  }

  @override
  Future<void> addTodate(Todate newTodate) async {
    newTodate.date = newTodate.dateOnly; // Set the Time in DateTime to 00:00:00 forcibly.
    
    await _database.createItem(
      TodateDbCompanion.insert(
        date: newTodate.date,
        title: newTodate.title,
        memo: Value(newTodate.memo),
      )
    );
  }


  @override
  Future<void> updateTodate(Todate todate) async {
    
    await _database.updateItem(
      TodateDbCompanion(
        id: Value(int.parse(todate.id!)),
        date: Value(todate.date),
        title: Value(todate.title),
        memo: Value(todate.memo),
        )
    );
  }

  @override
  Future<void> deleteTodate(Todate todate) async {

    await _database.deleteItem(int.parse(todate.id!));
  }

  List<Todate> sortTodates(List<Todate> todates) {
    todates.sort((a, b) => a.date.compareTo(b.date));
    return(todates);
  }
} 