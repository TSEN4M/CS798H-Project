import 'package:flutter/material.dart';

class TimerSettingsProvider extends ChangeNotifier {
  Duration _focusDuration = const Duration(minutes: 25);
  Duration _breakDuration = const Duration(minutes: 5);
  bool _strictMode = false;
  bool _vibration = true;
  bool _whiteNoise = false;

  Duration get focusDuration => _focusDuration;
  Duration get breakDuration => _breakDuration;
  bool get strictMode => _strictMode;
  bool get vibration => _vibration;
  bool get whiteNoise => _whiteNoise;

  void setFocusDuration(Duration duration) {
    _focusDuration = duration;
    notifyListeners();
  }

  void setBreakDuration(Duration duration) {
    _breakDuration = duration;
    notifyListeners();
  }

  void setStrictMode(bool value) {
    _strictMode = value;
    notifyListeners();
  }

  void setVibration(bool value) {
    _vibration = value;
    notifyListeners();
  }

  void setWhiteNoise(bool value) {
    _whiteNoise = value;
    notifyListeners();
  }
}
