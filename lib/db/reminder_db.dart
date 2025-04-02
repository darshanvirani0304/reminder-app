import 'dart:developer';
import 'package:sqflite/sqflite.dart';

class ReminderDb {
  const ReminderDb._();

  factory ReminderDb() => ReminderDb._();

  static Database? db;
}

Future<Database?> openDb() async {
  try {
    String directory = await getDatabasesPath();
    String path = '$directory/reminder_db.db';
    log('Database Path : $path');
    return await openDatabase(path, version: 1);
  } catch (ex) {
    log('Open Database Error : $ex');
  }
  return null;
}
