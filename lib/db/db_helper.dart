import 'dart:developer';
import 'package:reminder/db/reminder_db.dart';
import 'package:reminder/models/reminder.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final Database? _db = ReminderDb.db;

  final String _tableReminder = 'reminders';
  final String _columnId = 'id';
  final String _columnTitle = 'title';
  final String _columnDesc = 'desc';
  final String _columnReminderDateTime = 'reminder_date_time';
  final String _columnStatus = 'status';

  Future<void> createTable() async {
    if (_db == null) {
      throw Exception("Database instance is null. Table creation failed.");
    }

    await _db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableReminder (
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_columnTitle TEXT NOT NULL,
        $_columnDesc TEXT NOT NULL,
        $_columnReminderDateTime TEXT NOT NULL,
        $_columnStatus INTEGER NOT NULL
      )
    ''');

    log('$_tableReminder table is Created.');
  }

  Future<int> addReminder(Reminder reminder) async {
    if (_db == null) return 0;

    try {
      return await _db.insert(
        _tableReminder,
        reminder.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> updateReminder(Reminder reminder) async {
    if (_db == null) return 0;

    try {
      return await _db.update(
        _tableReminder,
        reminder.toMap(),
        where: '$_columnId = ?',
        whereArgs: [reminder.id],
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> updateReminderStatus({
    required int id,
    required bool isCompleted,
  }) async {
    if (_db == null) return 0;

    try {
      return await _db.update(
        _tableReminder,
        {
          _columnStatus: isCompleted ? 0 : 1,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> deleteReminder(int id) async {
    if (_db == null) return 0;

    try {
      return await _db.delete(
        _tableReminder,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Reminder>> getReminders() async {
    if (_db == null) return [];

    try {
      List<Map<String, dynamic>> reminders = await _db.query(_tableReminder);
      return List.from(reminders.map((e) => Reminder.formMap(e)));
    } catch (e) {
      throw Exception(e);
    }
  }
}
