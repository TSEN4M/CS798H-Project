import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'state/theme_provider.dart';
import 'state/timer_settings_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TimerSettingsProvider()),
      ],
      child: const MinimalistFocusApp(),
    ),
  );
}

class MinimalistFocusApp extends StatelessWidget {
  const MinimalistFocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Minimalist Focus App',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.toThemeData(),
      home: const HomeScreen(),
    );
  }
}
