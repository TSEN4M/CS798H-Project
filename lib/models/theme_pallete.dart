import 'package:flutter/material.dart';

class ThemePalette {
  final String name;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color neutral;

  const ThemePalette({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.neutral,
  });
}
