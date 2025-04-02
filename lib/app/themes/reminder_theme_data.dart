import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder/app/themes/themes.dart';

class ReminderThemeData {
  final Brightness brightness;

  ReminderThemeData._({required this.brightness});

  static ThemeData light() {
    return ReminderThemeData._(brightness: Brightness.light)._themeData(
      LightThemeColorPalette(),
    );
  }

  static ThemeData dark() {
    return ReminderThemeData._(brightness: Brightness.dark)._themeData(
      DarkThemeColorPalette(),
    );
  }

  ThemeData _themeData(ColorPalette palette) {
    TextTheme reminderTextTheme = ReminderTextTheme().apply(
      bodyColor: palette.onSurface,
      displayColor: palette.onSurface,
      decorationColor: palette.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme(palette),
      textTheme: reminderTextTheme,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      scaffoldBackgroundColor: palette.surface,
      appBarTheme: _appBarTheme(palette, reminderTextTheme),
      elevatedButtonTheme: _elevatedButtonThemeData(palette),
      outlinedButtonTheme: _outlinedButtonThemeData(palette),
      textButtonTheme: _textButtonThemeData(palette),
      iconButtonTheme: _iconButtonThemeData(palette),
      inputDecorationTheme: _inputDecorationTheme(palette),
      datePickerTheme: _datePickerThemeData(palette, reminderTextTheme),
      timePickerTheme: _timePickerThemeData(palette, reminderTextTheme),
      floatingActionButtonTheme: _floatingActionButtonThemeData(palette),
      radioTheme: _radioThemeData(palette),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
          TargetPlatform.values,
          value: (_) => const CupertinoPageTransitionsBuilder(),
        ),
      ),
    );
  }

  ColorScheme _colorScheme(ColorPalette palette) {
    return ColorScheme(
      brightness: brightness,
      primary: palette.primary,
      onPrimary: palette.onPrimary,
      secondary: palette.secondary,
      onSecondary: palette.onSecondary,
      error: palette.error,
      onError: palette.onError,
      surface: palette.surface,
      onSurface: palette.onSurface,
    );
  }

  AppBarTheme _appBarTheme(ColorPalette palette, TextTheme reminderTextTheme) {
    return AppBarTheme(
      foregroundColor: palette.onSurface,
      titleTextStyle: reminderTextTheme.headlineMedium?.copyWith(
        color: palette.onSurface,
      ),
      centerTitle: true,
      actionsIconTheme: IconThemeData(color: palette.onSurface),
      surfaceTintColor: Colors.transparent
    );
  }

  OutlineInputBorder _outlineInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.8,
        color: borderColor,
      ),
      borderRadius: BorderRadius.circular(10.r),
    );
  }

  InputDecorationTheme _inputDecorationTheme(ColorPalette palette) {
    return InputDecorationTheme(
      border: _outlineInputBorder(palette.secondary.withValues(alpha: 0.5)),
      enabledBorder:
          _outlineInputBorder(palette.secondary.withValues(alpha: 0.5)),
      focusedBorder:
          _outlineInputBorder(palette.secondary.withValues(alpha: 0.8)),
      errorBorder: _outlineInputBorder(palette.error),
      focusedErrorBorder: _outlineInputBorder(palette.error),
      disabledBorder:
          _outlineInputBorder(palette.secondary.withValues(alpha: 0.3)),
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData(ColorPalette palette) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: palette.primary,
        foregroundColor: palette.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        padding: const EdgeInsets.all(16),
      ),
    );
  }

  OutlinedButtonThemeData _outlinedButtonThemeData(ColorPalette palette) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        side: BorderSide(
          width: 1.8,
          color: palette.secondary.withValues(alpha: 0.8),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
      ),
    );
  }

  TextButtonThemeData _textButtonThemeData(ColorPalette palette) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        overlayColor: Colors.transparent,
        disabledForegroundColor: Colors.grey,
      ),
    );
  }

  IconButtonThemeData _iconButtonThemeData(ColorPalette palette) {
    return IconButtonThemeData(
      style: IconButton.styleFrom(highlightColor: Colors.transparent),
    );
  }

  DatePickerThemeData _datePickerThemeData(
    ColorPalette palette,
    TextTheme reminderTextTheme,
  ) {
    return DatePickerThemeData(
      headerBackgroundColor: palette.primary,
      headerForegroundColor: palette.onPrimary,
      inputDecorationTheme: InputDecorationTheme(),
      dividerColor: palette.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      cancelButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          reminderTextTheme.bodySmall?.copyWith(color: palette.secondary),
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          reminderTextTheme.bodySmall?.copyWith(color: palette.secondary),
        ),
      ),
    );
  }

  TimePickerThemeData _timePickerThemeData(
    ColorPalette palette,
    TextTheme reminderTextTheme,
  ) {
    return TimePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      cancelButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          reminderTextTheme.bodySmall?.copyWith(color: palette.secondary),
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          reminderTextTheme.bodySmall?.copyWith(color: palette.secondary),
        ),
      ),
    );
  }

  FloatingActionButtonThemeData _floatingActionButtonThemeData(
    ColorPalette palette,
  ) {
    return FloatingActionButtonThemeData(elevation: 0, highlightElevation: 0);
  }

  RadioThemeData _radioThemeData(ColorPalette palette) {
    return RadioThemeData(fillColor: WidgetStatePropertyAll(palette.secondary));
  }
}
