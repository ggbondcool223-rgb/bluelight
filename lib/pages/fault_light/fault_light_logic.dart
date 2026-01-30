import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';

class FaultLightLogic extends GetxController {
  final RxBool isOn = false.obs;
  final RxInt speedIndex = 1.obs;
  final RxBool isFlashing = false.obs;
  
  final List<int> speedDurations = [600, 400, 200];
  
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
      isFlashing.value = false;
    }
    Logger.i('Fault light ${isOn.value ? "on" : "off"}');
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
        isFlashing.value = !isFlashing.value;
      },
    );
  }
  
  Color get currentColor => isFlashing.value ? Colors.yellow : Colors.black;
  
  void goBack() {
    _flashTimer?.cancel();
    Get.back();
  }
}
