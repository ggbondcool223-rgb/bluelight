import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';

class RainbowLightLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final RxBool isOn = false.obs;
  final RxDouble flowSpeed = 0.5.obs;
  
  late AnimationController _animationController;
  final RxDouble animationValue = 0.0.obs;
  
  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    
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
      _animationController.repeat();
    } else {
      _animationController.stop();
    }
    Logger.i('Rainbow light ${isOn.value ? "on" : "off"}');
  }
  
  void setFlowSpeed(double value) {
    flowSpeed.value = value.clamp(0.0, 1.0);
    if (isOn.value) {
      _updateAnimationSpeed();
    }
  }
  
  void _updateAnimationSpeed() {
    final int durationMs = ((1.0 - flowSpeed.value) * 2000 + 1000).round();
    _animationController.duration = Duration(milliseconds: durationMs);
  }
  
  Color getRainbowColor(double offset) {
    final double hue = (animationValue.value + offset) % 1.0;
    return HSVColor.fromAHSV(1.0, hue * 360, 1.0, 1.0).toColor();
  }
  
  void goBack() {
    Get.back();
  }
}
