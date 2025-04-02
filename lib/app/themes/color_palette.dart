import 'package:flutter/material.dart';

abstract class ColorPalette {
  Color get primary;
  Color get onPrimary;
  Color get secondary;
  Color get onSecondary;
  Color get error;
  Color get onError;
  Color get surface;
  Color get onSurface;
}

class LightThemeColorPalette extends ColorPalette {
  @override
  Color get primary => Color(0xFF22A06B);

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get secondary => Color(0xFF22A06B);

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get error => Colors.red;

  @override
  Color get onError => Colors.white;

  @override
  Color get surface => Colors.white;

  @override
  Color get onSurface => const Color(0xFF1C3329);
}

class DarkThemeColorPalette extends ColorPalette {
  @override
  Color get primary => Color(0xFF164B35);

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get secondary => Color(0xFF1F845A);

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get error => Colors.red;

  @override
  Color get onError => Colors.white;

  @override
  Color get surface => Color(0xFF161A1D);

  @override
  Color get onSurface => Color(0xFFE0FEF2);
}
