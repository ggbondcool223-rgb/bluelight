import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';

class TimerLightLogic extends GetxController {
  final RxBool isRunning = false.obs;
  final RxInt totalSeconds = 300.obs;
  final RxInt remainingSeconds = 300.obs;
  final RxBool isFlashing = false.obs;
  
  Timer? _countdownTimer;
  
  @override
  void onClose() {
    _countdownTimer?.cancel();
    super.onClose();
  }
  
  void setTime(int minutes) {
    totalSeconds.value = minutes * 60;
    remainingSeconds.value = totalSeconds.value;
  }
  
  void startTimer() {
    if (remainingSeconds.value <= 0) return;
    isRunning.value = true;
    _startCountdown();
    Logger.i('Timer started: ${remainingSeconds.value} seconds');
  }
  
  void pauseTimer() {
    isRunning.value = false;
    _countdownTimer?.cancel();
    Logger.i('Timer paused');
  }
  
  void resetTimer() {
    isRunning.value = false;
    _countdownTimer?.cancel();
    remainingSeconds.value = totalSeconds.value;
    isFlashing.value = false;
    Logger.i('Timer reset');
  }
  
  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        final double progress = 1.0 - (remainingSeconds.value / totalSeconds.value);
        if (progress > 0.7) {
          isFlashing.value = !isFlashing.value;
        } else {
          isFlashing.value = false;
        }
      } else {
        _countdownTimer?.cancel();
        isRunning.value = false;
        isFlashing.value = true;
        Logger.i('Timer finished');
      }
    });
  }
  
  String get formattedTime {
    final int minutes = remainingSeconds.value ~/ 60;
    final int seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  
  Color get currentColor {
    if (!isRunning.value && remainingSeconds.value == totalSeconds.value) {
      return Colors.black;
    }
    final double progress = 1.0 - (remainingSeconds.value / totalSeconds.value);
    final double intensity = progress.clamp(0.0, 1.0);
    if (isFlashing.value && remainingSeconds.value == 0) {
      return Colors.red;
    }
    return Colors.white.withValues(alpha: intensity);
  }
  
  void goBack() {
    _countdownTimer?.cancel();
    Get.back();
  }
}
