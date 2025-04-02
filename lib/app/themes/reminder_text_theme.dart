import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReminderTextTheme extends TextTheme {
  final FontWeight _regular = FontWeight.w400;
  final FontWeight _medium = FontWeight.w500;
  final FontWeight _bold = FontWeight.w800;
  final double _letterSpacing = 0.2;

  @override
  TextStyle? get displayLarge {
    return TextStyle(
      fontSize: 22.sp,
      fontWeight: _bold,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get displayMedium {
    return TextStyle(
      fontSize: 22.sp,
      fontWeight: _medium,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get displaySmall {
    return TextStyle(
      fontSize: 22.sp,
      fontWeight: _regular,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get headlineLarge {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: _bold,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get headlineMedium {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: _medium,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get headlineSmall {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: _regular,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get titleLarge {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: _bold,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get titleMedium {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: _medium,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get titleSmall {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: _regular,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get labelLarge {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: _bold,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get labelMedium {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: _medium,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get labelSmall {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: _regular,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get bodyLarge {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: _bold,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get bodyMedium {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: _medium,
      letterSpacing: _letterSpacing,
    );
  }

  @override
  TextStyle? get bodySmall {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: _regular,
      letterSpacing: _letterSpacing,
    );
  }
}
