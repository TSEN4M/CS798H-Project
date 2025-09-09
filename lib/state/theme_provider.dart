import 'package:flutter/material.dart';
import '../models/theme_pallete.dart';

class ThemeProvider extends ChangeNotifier {
  ThemePalette _currentTheme = defaultTheme;

  static const ThemePalette defaultTheme = ThemePalette(
    name: 'Default',

    primary: const Color(0xFF000000),
    secondary: const Color.fromARGB(255, 72, 71, 71),
    accent: const Color.fromARGB(255, 255, 255, 255),
    neutral: const Color.fromARGB(255, 255, 255, 255),
  );

  final List<ThemePalette> allThemes = [
    ThemePalette(
      name: 'Deep Ocean',
      primary: const Color(0xFF2A3A5E),
      secondary: const Color(0xFF5B8CBE),
      accent: const Color.fromARGB(255, 255, 255, 255),
      neutral: const Color.fromARGB(255, 255, 255, 255),
    ),
    ThemePalette(
      name: 'Zen Garden',
      primary: const Color(0xFF88B04B),
      secondary: const Color(0xFFC7D59F),
      accent: const Color.fromARGB(255, 255, 255, 255),
      neutral: const Color.fromARGB(255, 255, 255, 255),
    ),

    ThemePalette(
      name: 'Vintage',
      primary: const Color(0xFF6B4226),
      secondary: const Color(0xFFD4A373),
      accent: const Color.fromARGB(255, 255, 255, 255),
      neutral: const Color.fromARGB(255, 255, 255, 255),
    ),

    ThemePalette(
      name: 'Midnight',
      primary: const Color(0xFF2D3047),
      secondary: const Color.fromARGB(255, 79, 85, 136),
      accent: const Color.fromARGB(255, 255, 255, 255),
      neutral: const Color.fromARGB(255, 255, 255, 255),
    ),
    ThemePalette(
      name: 'Lavender',
      primary: const Color(0xFF9B59B6),
      secondary: const Color(0xFFD6A2E8),
      accent: const Color.fromARGB(255, 255, 255, 255),
      neutral: const Color.fromARGB(255, 255, 255, 255),
    ),

    ThemePalette(
      name: 'High Contrast',
      primary: const Color(0xFF000000),
      secondary: const Color.fromARGB(255, 72, 71, 71),
      accent: const Color.fromARGB(255, 255, 255, 255),
      neutral: const Color.fromARGB(255, 255, 255, 255),
    ),
  ];

  ThemePalette get currentTheme => _currentTheme;

  void setTheme(ThemePalette theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  /// Converts ThemePalette into a full ThemeData object
  ThemeData toThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: _currentTheme.primary,
      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: _currentTheme.neutral,
        displayColor: _currentTheme.neutral,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _currentTheme.primary,
        iconTheme: IconThemeData(color: _currentTheme.neutral),
        titleTextStyle: TextStyle(
          color: _currentTheme.neutral,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(color: _currentTheme.neutral),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _currentTheme.secondary,
          foregroundColor: _currentTheme.neutral,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: _currentTheme.accent, width: 1.2),
          ),
        ),
      ),
      dialogBackgroundColor: _currentTheme.primary,
      cardColor: _currentTheme.secondary,
      dividerColor: _currentTheme.neutral.withOpacity(0.3),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _currentTheme.secondary,
        hintStyle: TextStyle(color: _currentTheme.neutral.withOpacity(0.6)),
        labelStyle: TextStyle(color: _currentTheme.neutral),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _currentTheme.accent),
        ),
      ),
    );
  }
}
