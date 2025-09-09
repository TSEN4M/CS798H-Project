import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_pallete.dart';
import '../state/timer_settings_provider.dart';
import '../state/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _pickDuration({
    required BuildContext context,
    required String title,
    required Duration initialDuration,
    required Function(Duration) onDurationSet,
  }) async {
    int hours = initialDuration.inHours;
    int minutes = initialDuration.inMinutes.remainder(60);
    final theme = context.read<ThemeProvider>().currentTheme;

    await showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(backgroundColor: theme.secondary),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: theme.neutral,
              displayColor: theme.neutral,
            ),
          ),
          child: _DurationPickerDialog(
            title: title,
            initialHours: hours,
            initialMinutes: minutes,
            onConfirm: onDurationSet,
            textColor: theme.neutral,
          ),
        );
      },
    );
  }

  String _formatDuration(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.inHours)}:${two(d.inMinutes.remainder(60))}';
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<TimerSettingsProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final selectedTheme = themeProvider.currentTheme;
    final themes = themeProvider.allThemes;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text(
              "Focus Timer",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              _formatDuration(settings.focusDuration),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap:
                () => _pickDuration(
                  context: context,
                  title: "Set Focus Timer",
                  initialDuration: settings.focusDuration,
                  onDurationSet: settings.setFocusDuration,
                ),
          ),
          ListTile(
            title: const Text(
              "Break Timer",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              _formatDuration(settings.breakDuration),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap:
                () => _pickDuration(
                  context: context,
                  title: "Set Break Timer",
                  initialDuration: settings.breakDuration,
                  onDurationSet: settings.setBreakDuration,
                ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const Text(
            'Preferences',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SwitchListTile(
            title: const Text(
              "Strict Mode",
              style: TextStyle(color: Colors.white),
            ),
            value: settings.strictMode,
            onChanged: settings.setStrictMode,
          ),
          SwitchListTile(
            title: const Text(
              "Vibration",
              style: TextStyle(color: Colors.white),
            ),
            value: settings.vibration,
            onChanged: settings.setVibration,
          ),
          SwitchListTile(
            title: const Text(
              "White Noise",
              style: TextStyle(color: Colors.white),
            ),
            value: settings.whiteNoise,
            onChanged: settings.setWhiteNoise,
          ),
          const Divider(height: 40),
          const Text(
            'Theme Selection',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(themes.length, (index) {
              final theme = themes[index];
              return ThemeSelectionItem(
                theme: theme,
                isSelected: theme.name == selectedTheme.name,
                onTap: () => themeProvider.setTheme(theme),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _DurationPickerDialog extends StatefulWidget {
  final String title;
  final int initialHours;
  final int initialMinutes;
  final void Function(Duration) onConfirm;
  final Color textColor;

  const _DurationPickerDialog({
    required this.title,
    required this.initialHours,
    required this.initialMinutes,
    required this.onConfirm,
    required this.textColor,
  });

  @override
  State<_DurationPickerDialog> createState() => _DurationPickerDialogState();
}

class _DurationPickerDialogState extends State<_DurationPickerDialog> {
  late int tempHours;
  late int tempMinutes;

  @override
  void initState() {
    super.initState();
    tempHours = widget.initialHours;
    tempMinutes = widget.initialMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title, style: TextStyle(color: widget.textColor)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("HH", style: TextStyle(color: widget.textColor)),
              DropdownButton<int>(
                value: tempHours,
                dropdownColor: Theme.of(context).dialogTheme.backgroundColor,
                style: TextStyle(color: widget.textColor, fontSize: 22),
                iconEnabledColor: widget.textColor,
                iconDisabledColor: widget.textColor,
                items:
                    List.generate(6, (i) => i)
                        .map(
                          (val) => DropdownMenuItem(
                            value: val,
                            child: Text(
                              val.toString().padLeft(2, '0'),
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (val) => setState(() => tempHours = val!),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("MM", style: TextStyle(color: widget.textColor)),
              DropdownButton<int>(
                value: tempMinutes,
                dropdownColor: Theme.of(context).dialogTheme.backgroundColor,
                style: TextStyle(color: widget.textColor, fontSize: 22),
                iconEnabledColor: widget.textColor,
                iconDisabledColor: widget.textColor,
                items:
                    List.generate(60, (i) => i)
                        .map(
                          (val) => DropdownMenuItem(
                            value: val,
                            child: Text(
                              val.toString().padLeft(2, '0'),
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (val) => setState(() => tempMinutes = val!),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: widget.textColor)),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirm(Duration(hours: tempHours, minutes: tempMinutes));
            Navigator.pop(context);
          },
          child: Text("Set", style: TextStyle(color: widget.textColor)),
        ),
      ],
    );
  }
}

class ThemeSelectionItem extends StatelessWidget {
  final ThemePalette theme;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeSelectionItem({
    super.key,
    required this.theme,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.primary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.accent : Colors.transparent,
            width: 3,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 8,
              left: 8,
              child: Text(
                theme.name,
                style: TextStyle(
                  color: theme.neutral,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (isSelected)
              Center(
                child: Icon(Icons.check_circle, color: theme.accent, size: 28),
              ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: theme.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
