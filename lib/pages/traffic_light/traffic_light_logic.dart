import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';
import '../../lang/lang.dart';

class TrafficLightLogic extends GetxController {
  final RxBool isOn = false.obs;
  final RxInt currentState = 0.obs;
  final RxInt intervalSeconds = 5.obs;
  
  Timer? _cycleTimer;
  
  final List<Color> states = [
    Colors.red,
    Colors.yellow,
    Colors.green,
  ];
  
  @override
  void onClose() {
    _cycleTimer?.cancel();
    super.onClose();
  }
  
  void toggleLight() {
    isOn.value = !isOn.value;
    if (isOn.value) {
      _startCycle();
    } else {
      _cycleTimer?.cancel();
    }
    Logger.i('Traffic light ${isOn.value ? "on" : "off"}');
  }
  
  void setInterval(int seconds) {
    intervalSeconds.value = seconds;
    if (isOn.value) {
      _cycleTimer?.cancel();
      _startCycle();
    }
  }
  
  void _startCycle() {
    _cycleTimer?.cancel();
    _cycleTimer = Timer.periodic(
      Duration(seconds: intervalSeconds.value),
      (timer) {
        currentState.value = (currentState.value + 1) % states.length;
      },
    );
  }
  
  Color get currentColor => states[currentState.value];
  
  String get currentStateName {
    switch (currentState.value) {
      case 0:
        return Lang.red;
      case 1:
        return Lang.yellow;
      case 2:
        return Lang.green;
      default:
        return '';
    }
  }
  
  void goBack() {
    _cycleTimer?.cancel();
    Get.back();
  }
}
