import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';

class BreathingLightLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final RxBool isOn = false.obs;
  final RxDouble speed = 0.5.obs;
  
  late AnimationController _animationController;
  final RxDouble animationValue = 0.0.obs;
  
  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
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
      _updateAnimationSpeed();
      _animationController.repeat(reverse: true);
    } else {
      _animationController.stop();
    }
    Logger.i('Breathing light ${isOn.value ? "on" : "off"}');
  }
  
  void setSpeed(double value) {
    speed.value = value.clamp(0.0, 1.0);
    if (isOn.value) {
      _updateAnimationSpeed();
    }
  }
  
  void _updateAnimationSpeed() {
    final int durationMs = ((1.0 - speed.value) * 2000 + 1000).round();
    _animationController.duration = Duration(milliseconds: durationMs);
  }
  
  Color get currentColor {
    if (!isOn.value) return Colors.black;
    final double opacity = 0.3 + (animationValue.value * 0.7);
    return Colors.white.withValues(alpha: opacity);
  }
  
  void goBack() {
    Get.back();
  }
}
