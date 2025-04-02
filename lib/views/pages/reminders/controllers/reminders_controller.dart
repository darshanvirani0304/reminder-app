import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/db/db_helper.dart';
import 'package:reminder/models/reminder.dart';

class RemindersController extends ChangeNotifier {
  RemindersController of(BuildContext context) {
    return context.read<RemindersController>();
  }

  final DbHelper _dbHelper = DbHelper();

  void Function()? onSuccess;

  List<Reminder> _reminders = [];

  Future<void> getReminders() async {
    try {
      List<Reminder> data = await _dbHelper.getReminders();
      data.sort((a, b) {
        return (a.status ? 1 : 0).compareTo(b.status ? 1 : 0);
      });
      _reminders = data;
      log('All reminder Gotten');
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateReminderStatus(int id, bool? isCompleted) async {
    try {
      int updatedReminderId = await _dbHelper.updateReminderStatus(
        id: id,
        isCompleted: isCompleted!,
      );
      if (updatedReminderId > 0) {
        log('Reminder Status Updated');
        await getReminders();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  List<Reminder> get reminders => _reminders;
}
