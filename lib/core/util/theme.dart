import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: generateMaterialColor(MyColors.primary),
    brightness: Brightness.light,
    useMaterial3: false,
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: generateMaterialColor(MyColors.primary),
    brightness: Brightness.dark,
    useMaterial3: false,
  );
}

class MyColors {
  // Primary Colors
  static const Color primary = Color(0xFF2D2A7B);
  static const Color primaryDark = Color(0xFF1B194E);
  static const Color accent = Color(0xFF2D2A7B);

  // Basic Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFBCBABA);
  static const Color red = Color(0xFFC11E1E);
  static const Color separator = Color(0xFFBCBABA);
  static const Color menuTextColor = Color(0xFF686868);

  // Background Colors
  static const Color bgItemNormalState = Color(0xFFF7F7F7);

  // Accent Colors
  static const Color colorGreen = Color(0xFF2D5C25);
  static const Color colorOrange = Color(0xFFA95426);
  static const Color colorBlue = Color(0xFF2529A9);
  static const Color colorPink = Color(0xFFAD146B);
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: _tint(color, 0.9),
    100: _tint(color, 0.8),
    200: _tint(color, 0.6),
    300: _tint(color, 0.4),
    400: _tint(color, 0.2),
    500: color,
    600: _shade(color, 0.1),
    700: _shade(color, 0.2),
    800: _shade(color, 0.3),
    900: _shade(color, 0.4),
  });
}

Color _tint(Color color, double factor) {
  return Color.fromARGB(
    255,
    ((color.r + (1 - color.r) * factor) * 255).round() & 0xff,
    ((color.g + (1 - color.g) * factor) * 255).round() & 0xff,
    ((color.b + (1 - color.b) * factor) * 255).round() & 0xff,
  );
}

Color _shade(Color color, double factor) {
  return Color.fromARGB(
    255,
    ((color.r * (1 - factor)) * 255).round() & 0xff,
    ((color.g * (1 - factor)) * 255).round() & 0xff,
    ((color.b * (1 - factor)) * 255).round() & 0xff,
  );
}
