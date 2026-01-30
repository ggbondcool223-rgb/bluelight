import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';

class ColorfulLightLogic extends GetxController {
  final RxBool isOn = false.obs;
  final RxInt currentColorIndex = 0.obs;
  final RxBool isAutoCycle = false.obs;
  
  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.purple,
    Colors.pink,
  ];
  
  Timer? _cycleTimer;
  
  @override
  void onClose() {
    _cycleTimer?.cancel();
    super.onClose();
  }
  
  void toggleLight() {
    isOn.value = !isOn.value;
    if (isOn.value && isAutoCycle.value) {
      _startAutoCycle();
    } else {
      _cycleTimer?.cancel();
    }
    Logger.i('Colorful light ${isOn.value ? "on" : "off"}');
  }
  
  void toggleAutoCycle() {
    isAutoCycle.value = !isAutoCycle.value;
    if (isOn.value) {
      if (isAutoCycle.value) {
        _startAutoCycle();
      } else {
        _cycleTimer?.cancel();
      }
    }
  }
  
  void selectColor(int index) {
    currentColorIndex.value = index;
    if (isAutoCycle.value) {
      _cycleTimer?.cancel();
      isAutoCycle.value = false;
    }
  }
  
  void _startAutoCycle() {
    _cycleTimer?.cancel();
    _cycleTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      currentColorIndex.value = (currentColorIndex.value + 1) % colors.length;
    });
  }
  
  Color get currentColor => colors[currentColorIndex.value];
  
  void goBack() {
    _cycleTimer?.cancel();
    Get.back();
  }
}
