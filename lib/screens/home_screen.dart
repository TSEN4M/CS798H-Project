import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings_screen.dart';
import 'task_screen.dart';
import 'timer_screen.dart';
import '../state/timer_settings_provider.dart';
import '../state/theme_provider.dart';
import '../widgets/duration_picker_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _showCustomTimePicker(BuildContext context) async {
    final timerSettings = context.read<TimerSettingsProvider>();
    final theme = context.read<ThemeProvider>().currentTheme;

    int hours = timerSettings.focusDuration.inHours;
    int minutes = timerSettings.focusDuration.inMinutes.remainder(60);

    await showDialog(
      context: context,
      builder:
          (context) => Theme(
            data: Theme.of(context).copyWith(
              dialogTheme: DialogTheme(backgroundColor: theme.secondary),
              textTheme: Theme.of(context).textTheme.apply(
                bodyColor: theme.neutral,
                displayColor: theme.neutral,
              ),
            ),
            child: DurationPickerDialog(
              title: "Set Focus Time",
              initialHours: hours,
              initialMinutes: minutes,
              textColor: theme.neutral,
              backgroundColor: theme.secondary,
              onConfirm: (picked) {
                timerSettings.setFocusDuration(picked);
              },
            ),
          ),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<TimerSettingsProvider>();
    final theme = context.watch<ThemeProvider>().currentTheme;

    final focusDuration = settings.focusDuration;
    final breakDuration = settings.breakDuration;

    return Scaffold(
      backgroundColor: theme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Focus Timer',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: theme.neutral,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: theme.neutral),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Add Task Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TaskScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 14,
                    ),
                  ),
                  child: Text(
                    "Add Task",
                    style: TextStyle(color: theme.neutral, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Timer Display
              GestureDetector(
                onTap: () => _showCustomTimePicker(context),
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.secondary,
                  ),
                  child: Center(
                    child: Text(
                      _formatDuration(focusDuration),
                      style: TextStyle(
                        fontSize: 38,
                        color: theme.neutral,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Tap to change focus duration",
                style: TextStyle(
                  color: theme.neutral.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),

              const Spacer(),

              // Start Focus Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => TimerScreen(
                            duration: focusDuration,
                            breakDuration: breakDuration,
                          ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.accent,
                  foregroundColor: theme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'Start Focus',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
