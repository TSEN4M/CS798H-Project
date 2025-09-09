import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../state/theme_provider.dart';

class TimerScreen extends StatefulWidget {
  final Duration duration;
  final Duration breakDuration;

  const TimerScreen({
    super.key,
    required this.duration,
    this.breakDuration = const Duration(minutes: 5),
  });

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Duration _remaining;
  late Duration _initialDuration;
  Timer? _timer;
  bool _isRunning = false;
  bool _isHorizontal = false;
  bool _isFocusSession = true;

  @override
  void initState() {
    super.initState();
    _initialDuration = widget.duration;
    _remaining = _initialDuration;
    _startTimer();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds <= 0) {
        timer.cancel();
        setState(() => _isRunning = false);
        _handleSessionEnd();
      } else {
        setState(() => _remaining -= const Duration(seconds: 1));
      }
    });

    setState(() => _isRunning = true);
  }

  void _handleSessionEnd() async {
    final theme = context.read<ThemeProvider>().currentTheme;

    if (_isFocusSession) {
      final result = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => Theme(
              data: Theme.of(context).copyWith(
                dialogTheme: DialogTheme(backgroundColor: theme.secondary),
                textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: theme.neutral,
                  displayColor: theme.neutral,
                ),
              ),
              child: AlertDialog(
                title: const Text("Focus Session Complete!"),
                content: Text(
                  "Would you like to start a ${widget.breakDuration.inMinutes}-minute break?",
                  style: TextStyle(color: theme.neutral),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, "skip"),
                    child: Text("Skip", style: TextStyle(color: theme.neutral)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, "break"),
                    child: Text(
                      "Start Break",
                      style: TextStyle(color: theme.neutral),
                    ),
                  ),
                ],
              ),
            ),
      );

      if (!mounted) return;

      if (result == "break") {
        setState(() {
          _isFocusSession = false;
          _initialDuration = widget.breakDuration;
          _remaining = widget.breakDuration;
        });
        _startTimer();
      } else {
        setState(() {
          _isFocusSession = true;
          _initialDuration = widget.duration;
          _remaining = widget.duration;
        });
        _startTimer();
      }
    } else {
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
              child: AlertDialog(
                title: const Text("Break Over"),
                content: const Text("Time to get back to work!"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK", style: TextStyle(color: theme.neutral)),
                  ),
                ],
              ),
            ),
      );
      if (mounted) Navigator.pop(context);
    }
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remaining = _initialDuration;
      _isRunning = false;
    });
  }

  void _toggleOrientation() {
    setState(() {
      _isHorizontal = !_isHorizontal;
      SystemChrome.setPreferredOrientations(
        _isHorizontal
            ? [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]
            : [DeviceOrientation.portraitUp],
      );
    });
  }

  Widget _buildDigitBox(
    String digit,
    double width,
    double height,
    double fontSize,
  ) {
    return Container(
      margin: const EdgeInsets.all(6),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        digit,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _portraitLayout(BoxConstraints constraints) {
    final boxHeight = constraints.maxHeight * 0.25;
    final boxWidth = constraints.maxWidth * 0.8;
    final fontSize = boxHeight * 0.45;

    final hours = _remaining.inHours.toString().padLeft(2, '0');
    final minutes = _remaining.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = _remaining.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDigitBox(hours, boxWidth, boxHeight, fontSize),
        _buildDigitBox(minutes, boxWidth, boxHeight, fontSize),
        _buildDigitBox(seconds, boxWidth, boxHeight, fontSize),
      ],
    );
  }

  Widget _landscapeLayout(BoxConstraints constraints) {
    final boxHeight = constraints.maxHeight * 0.7;
    final boxWidth = constraints.maxWidth * 0.27;
    final fontSize = boxHeight * 0.45;

    final hours = _remaining.inHours.toString().padLeft(2, '0');
    final minutes = _remaining.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = _remaining.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDigitBox(hours, boxWidth, boxHeight, fontSize),
        Text(
          ":",
          style: TextStyle(fontSize: fontSize * 0.8, color: Colors.white),
        ),
        _buildDigitBox(minutes, boxWidth, boxHeight, fontSize),
        Text(
          ":",
          style: TextStyle(fontSize: fontSize * 0.8, color: Colors.white),
        ),
        _buildDigitBox(seconds, boxWidth, boxHeight, fontSize),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().currentTheme;

    return Scaffold(
      backgroundColor: theme.primary,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child:
                        _isHorizontal
                            ? _landscapeLayout(constraints)
                            : _portraitLayout(constraints),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 30,
                        icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                        color: Colors.white,
                        onPressed: _isRunning ? _pauseTimer : _startTimer,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.replay),
                        color: Colors.white,
                        onPressed: _resetTimer,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        iconSize: 30,
                        icon: Icon(
                          _isHorizontal
                              ? Icons.stay_current_portrait
                              : Icons.stay_current_landscape,
                        ),
                        color: Colors.white70,
                        onPressed: _toggleOrientation,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }
}
