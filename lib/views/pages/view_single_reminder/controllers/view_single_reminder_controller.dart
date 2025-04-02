import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/db/db_helper.dart';

class ViewSingleReminderController extends ChangeNotifier {
  ViewSingleReminderController of(BuildContext context) {
    return context.read<ViewSingleReminderController>();
  }

  final DbHelper _dbHelper = DbHelper();

  void Function()? onDeleteReminder;

  Future<void> deleteReminder(int id) async {
    try {
      int reminderId = await _dbHelper.deleteReminder(id);
      if(reminderId > 0) {
        log('Reminder Deleted');
        onDeleteReminder?.call();
      }
    } catch (e) {
      log('Delete Reminder Error : $e');
    }
  }
}
