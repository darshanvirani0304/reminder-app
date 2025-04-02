import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder/shared/extensions/build_context_ex.dart';

class ReminderTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator validator;
  final int? maxlines;
  final String hintText;
  final Icon prefixIcon;

  const ReminderTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.maxlines,
    required this.hintText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autofocus: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: context.textTheme.bodySmall?.copyWith(
        decoration: TextDecoration.none,
        decorationThickness: 0,
        decorationColor: Colors.transparent,
      ),
      maxLines: maxlines ?? 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
        prefixIconColor: Theme.of(context).colorScheme.secondary,
        errorMaxLines: 1,
        errorStyle: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.error,
          fontSize: 12.sp,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 13.h,
        ),
      ),
    );
  }
}
