import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:reminder/shared/extensions/extensions.dart';

class ReminderLabel extends StatelessWidget {
  final IconData iconData;
  final String label;

  const ReminderLabel({super.key, required this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: context.isDark ? 0.14 : 0.1,),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(iconData, color: Theme.of(context).colorScheme.secondary, size: 22.w,),
          Gap(10.w),
          Expanded(child: Text(label, style: context.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}