import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';

class StrobeLightLogic extends GetxController {
  final RxBool isOn = false.obs;
  final RxDouble frequency = 5.0.obs;
  final RxBool isFlashing = false.obs;
  
  Timer? _strobeTimer;
  
  @override
  void onClose() {
    _strobeTimer?.cancel();
    super.onClose();
  }
  
  void toggleLight() {
    isOn.value = !isOn.value;
    if (isOn.value) {
      _startStrobe();
    } else {
      _strobeTimer?.cancel();
      isFlashing.value = false;
    }
    Logger.i('Strobe light ${isOn.value ? "on" : "off"}');
  }
  
  void setFrequency(double value) {
    frequency.value = value.clamp(1.0, 10.0);
    if (isOn.value) {
      _strobeTimer?.cancel();
      _startStrobe();
    }
  }
  
  void _startStrobe() {
    _strobeTimer?.cancel();
    final int durationMs = (1000 / frequency.value).round();
    _strobeTimer = Timer.periodic(
      Duration(milliseconds: durationMs),
      (timer) {
        isFlashing.value = !isFlashing.value;
      },
    );
  }
  
  Color get currentColor => isFlashing.value ? Colors.white : Colors.black;
  
  void goBack() {
    _strobeTimer?.cancel();
    Get.back();
  }
}
