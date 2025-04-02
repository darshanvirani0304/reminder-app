import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

extension BuildContextEx on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get width => mediaQuery.size.width;

  double get height => mediaQuery.size.height;

  ThemeData get themeData => Theme.of(this);

  TextTheme get textTheme => themeData.textTheme;

  ColorScheme get colorScheme => themeData.colorScheme;

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  bool get isDark => themeData.colorScheme.brightness == Brightness.dark;

  void showSnackBar(String message, SnackbarType snackbarType) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(snackbarType.icon, color: colorScheme.onPrimary,),
            Gap(6.w),
            Text(message),
          ],
        ),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),),
        backgroundColor: snackbarType.color,
      ),
    );
  }

}

enum SnackbarType { success, info, fail }

extension SnackbarTypeEx on SnackbarType {
  IconData get icon {
    return switch (this) {
      SnackbarType.success => Icons.check_circle,
      SnackbarType.info => Icons.warning_rounded,
      SnackbarType.fail => Icons.cancel
    };
  }
  Color get color {
    return switch (this) {
      SnackbarType.success => Color(0xFF42A5F5),
      SnackbarType.info => Colors.red,
      SnackbarType.fail => Colors.red,
    };
  }
}

