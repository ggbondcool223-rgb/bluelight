import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';

class IncandescentLightLogic extends GetxController {
  final RxBool isOn = false.obs;
  final RxDouble brightness = 0.8.obs;
  final RxDouble colorTemperature = 0.5.obs;
  
  void toggleLight() {
    isOn.value = !isOn.value;
    Logger.i('Incandescent light ${isOn.value ? "on" : "off"}');
  }
  
  void setBrightness(double value) {
    brightness.value = value.clamp(0.0, 1.0);
  }
  
  void setColorTemperature(double value) {
    colorTemperature.value = value.clamp(0.0, 1.0);
  }
  
  Color get currentColor {
    if (!isOn.value) return Colors.black;
    final double warmness = colorTemperature.value;
    final int r = (255 * (1 - warmness * 0.3)).round();
    final int g = (220 * (1 - warmness * 0.2)).round();
    final int b = (180 * (1 - warmness * 0.4)).round();
    return Color.fromRGBO(r, g, b, brightness.value);
  }
  
  void goBack() {
    Get.back();
  }
}
