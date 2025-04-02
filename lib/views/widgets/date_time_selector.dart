import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:reminder/shared/extensions/extensions.dart';

class DateTimeSelector extends StatelessWidget {
  final DateTime selectedDay;
  final TimeOfDay selectedTime;
  final Function(DateTime, TimeOfDay) onDateTimeChange;

  const DateTimeSelector({
    super.key,
    required this.selectedDay,
    required this.selectedTime,
    required this.onDateTimeChange,
  });

  Future<void> _selectDate(BuildContext context) async {
    final pickDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (pickDate != null && pickDate != selectedDay) {
      onDateTimeChange(pickDate, selectedTime);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickTime != null && pickTime != selectedTime) {
      onDateTimeChange(selectedDay, pickTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _selectDate(context),
            icon: Icon(
              Icons.calendar_month,
              size: 18.w,
              color: context.colorScheme.secondary,
            ),
            label: Text(
              'Date : ${DateFormat('dd/MM/yyyy').format(selectedDay)}',
              style: context.textTheme.bodySmall?.copyWith(fontSize: 13.sp),
            ),
          ),
        ),
        Gap(12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _selectTime(context),
            icon: Icon(
              Icons.access_time_filled,
              size: 18.w,
              color: context.colorScheme.secondary,
            ),
            label: Text(
              'Time : ${selectedTime.format(context)}',
              style: context.textTheme.bodySmall?.copyWith(fontSize: 13.sp),
            ),
          ),
        ),
      ],
    );
  }
}
