import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';

class PoliceLightLogic extends GetxController {
  final RxBool isOn = false.obs;
  final RxInt speedIndex = 1.obs;
  final RxBool isRed = true.obs;
  
  final List<int> speedDurations = [500, 300, 150];
  
  Timer? _flashTimer;
  
  @override
  void onClose() {
    _flashTimer?.cancel();
    super.onClose();
  }
  
  void toggleLight() {
    isOn.value = !isOn.value;
    if (isOn.value) {
      _startFlashing();
    } else {
      _flashTimer?.cancel();
    }
    Logger.i('Police light ${isOn.value ? "on" : "off"}');
  }
  
  void setSpeed(int index) {
    speedIndex.value = index;
    if (isOn.value) {
      _flashTimer?.cancel();
      _startFlashing();
    }
  }
  
  void _startFlashing() {
    _flashTimer?.cancel();
    _flashTimer = Timer.periodic(
      Duration(milliseconds: speedDurations[speedIndex.value]),
      (timer) {
        isRed.value = !isRed.value;
      },
    );
  }
  
  Color get currentColor => isRed.value ? Colors.red : Colors.blue;
  
  void goBack() {
    _flashTimer?.cancel();
    Get.back();
  }
}
