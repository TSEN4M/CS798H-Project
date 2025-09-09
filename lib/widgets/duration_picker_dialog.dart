import 'package:flutter/material.dart';

class DurationPickerDialog extends StatefulWidget {
  final String title;
  final int initialHours;
  final int initialMinutes;
  final void Function(Duration) onConfirm;
  final Color textColor;
  final Color backgroundColor;

  const DurationPickerDialog({
    super.key,
    required this.title,
    required this.initialHours,
    required this.initialMinutes,
    required this.onConfirm,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  State<DurationPickerDialog> createState() => _DurationPickerDialogState();
}

class _DurationPickerDialogState extends State<DurationPickerDialog> {
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
      backgroundColor: widget.backgroundColor,
      title: Text(
        widget.title,
        style: TextStyle(color: widget.textColor, fontSize: 20),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "HH",
                style: TextStyle(color: widget.textColor, fontSize: 16),
              ),
              DropdownButton<int>(
                value: tempHours,
                dropdownColor: widget.backgroundColor,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                iconEnabledColor: widget.textColor,
                items:
                    List.generate(6, (i) => i)
                        .map(
                          (val) => DropdownMenuItem(
                            value: val,
                            child: Text(
                              val.toString().padLeft(2, '0'),
                              style: TextStyle(fontSize: 20),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "MM",
                style: TextStyle(color: widget.textColor, fontSize: 16),
              ),
              DropdownButton<int>(
                value: tempMinutes,
                dropdownColor: widget.backgroundColor,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 22, // Increased font size
                  fontWeight: FontWeight.w600,
                ),
                iconEnabledColor: widget.textColor,
                items:
                    List.generate(60, (i) => i)
                        .map(
                          (val) => DropdownMenuItem(
                            value: val,
                            child: Text(
                              val.toString().padLeft(2, '0'),
                              style: TextStyle(fontSize: 20),
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
          child: Text(
            "Cancel",
            style: TextStyle(color: widget.textColor, fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirm(Duration(hours: tempHours, minutes: tempMinutes));
            Navigator.pop(context);
          },
          child: Text(
            "Set",
            style: TextStyle(color: widget.textColor, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
