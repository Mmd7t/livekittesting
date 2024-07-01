import 'package:flutter/material.dart';

class TimingNavigatorObserver extends NavigatorObserver {
  DateTime? startTime;

  void startTiming() {
    startTime = DateTime.now();
  }

  void logDuration() {
    if (startTime != null) {
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime!);
      print('Time taken to navigate: ${duration.inSeconds} secs');
      startTime = null;
    }
  }
}
