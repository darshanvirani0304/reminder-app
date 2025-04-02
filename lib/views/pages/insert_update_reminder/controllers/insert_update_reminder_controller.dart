import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/db/db_helper.dart';
import 'package:reminder/models/reminder.dart';
import 'package:reminder/services/services.dart';
import 'package:reminder/shared/extensions/build_context_ex.dart';

class InsertUpdateReminderController extends ChangeNotifier {
  InsertUpdateReminderController of(BuildContext context) {
    return context.read<InsertUpdateReminderController>();
  }

  final DbHelper _dbHelper = DbHelper();
  final NotificationService _notificationService = NotificationService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  DateTime _selectedDay = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void Function()? onReminderInsertAndUpdate;

  int? _reminderId;
  bool? _reminderStatus;

  void getReminderData(Reminder? reminder) {
    if (reminder != null) {
      _reminderId = reminder.id;
      _titleController.text = reminder.title;
      _descController.text = reminder.desc;
      _reminderStatus = reminder.status;
      _selectedDay = reminder.reminderDateTime;
      _selectedTime = TimeOfDay.fromDateTime(reminder.reminderDateTime);
      notifyListeners();
    }
  }

  void updateDateTime(DateTime dateTime, TimeOfDay timeOfDay) {
    _selectedDay = dateTime;
    _selectedTime = timeOfDay;
    notifyListeners();
  }

  Future<void> insertUpdateReminder(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        DateTime shedule = DateTime(
          selectedDay.year,
          selectedDay.month,
          selectedDay.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        if (shedule.isBefore(DateTime.now())) {
          context.showSnackBar(
            'Please select a future date and time',
            SnackbarType.info,
          );
          return;
        }

        Reminder reminder = Reminder(
          id: _reminderId ?? 0,
          title: _titleController.text,
          desc: _descController.text,
          reminderDateTime: shedule,
          status: _reminderStatus ?? false,
        );

        int currentReminderId = _reminderId == null
            ? await _dbHelper.addReminder(reminder)
            : await _dbHelper.updateReminder(reminder);

        log(currentReminderId.toString());

        if (currentReminderId > 0) {
          Reminder newReminder = Reminder(
            id: currentReminderId,
            title: _titleController.text,
            desc: _descController.text,
            reminderDateTime: shedule,
            status: _reminderStatus ?? false,
          );
          await _notificationService.setSheduleNotification(
              newReminder.toMap(), shedule);
          log('Reminder ${_reminderId == null ? 'Added' : 'Updated'}');
          onReminderInsertAndUpdate?.call();
        }
      } catch (e) {
        log('Insert Update Reminder Error : $e');
      }
    }
  }

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController get titleController => _titleController;

  TextEditingController get descController => _descController;

  DateTime get selectedDay => _selectedDay;

  TimeOfDay get selectedTime => _selectedTime;
}
