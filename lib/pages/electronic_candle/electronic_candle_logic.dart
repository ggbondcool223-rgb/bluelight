import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';

class ElectronicCandleLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final RxBool isOn = false.obs;
  final RxDouble brightness = 0.8.obs;
  final RxDouble flameSize = 0.5.obs;
  
  late AnimationController _animationController;
  final RxDouble animationValue = 0.0.obs;
  
  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    
    _animationController.addListener(() {
      animationValue.value = _animationController.value;
    });
  }
  
  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
  
  void toggleLight() {
    isOn.value = !isOn.value;
    if (isOn.value) {
      _animationController.repeat(reverse: true);
    } else {
      _animationController.stop();
    }
    Logger.i('Electronic candle ${isOn.value ? "on" : "off"}');
  }
  
  void setBrightness(double value) {
    brightness.value = value.clamp(0.0, 1.0);
  }
  
  void setFlameSize(double value) {
    flameSize.value = value.clamp(0.0, 1.0);
  }
  
  Color getFlameColor(double offset) {
    if (!isOn.value) return Colors.black;
    final double variation = sin(animationValue.value * 2 * pi + offset) * 0.1;
    final double intensity = brightness.value + variation;
    final double r = (255 * intensity).clamp(200.0, 255.0);
    final double g = (150 * intensity).clamp(100.0, 200.0);
    final double b = (50 * intensity).clamp(30.0, 100.0);
    return Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), 1.0);
  }
  
  double getFlameHeight() {
    return 0.3 + flameSize.value * 0.2;
  }
  
  void goBack() {
    Get.back();
  }
}
