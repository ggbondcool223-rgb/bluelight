import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';
import '../../lang/lang.dart';

class CustomLightLogic extends GetxController {
  final RxBool isOn = false.obs;
  final RxInt selectedColorIndex = 0.obs;
  final RxInt patternIndex = 0.obs;
  final RxDouble frequency = 5.0.obs;
  final RxBool isFlashing = false.obs;
  
  Timer? _patternTimer;
  
  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.white,
  ];
  
  final List<String> patterns = [
    Lang.solid,
    Lang.flash,
    Lang.pulse,
  ];
  
  @override
  void onClose() {
    _patternTimer?.cancel();
    super.onClose();
  }
  
  void toggleLight() {
    isOn.value = !isOn.value;
    if (isOn.value) {
      _startPattern();
    } else {
      _patternTimer?.cancel();
      isFlashing.value = false;
    }
    Logger.i('Custom light ${isOn.value ? "on" : "off"}');
  }
  
  void selectColor(int index) {
    selectedColorIndex.value = index;
  }
  
  void selectPattern(int index) {
    patternIndex.value = index;
    if (isOn.value) {
      _patternTimer?.cancel();
      _startPattern();
    }
  }
  
  void setFrequency(double value) {
    frequency.value = value.clamp(1.0, 10.0);
    if (isOn.value && patternIndex.value > 0) {
      _patternTimer?.cancel();
      _startPattern();
    }
  }
  
  void _startPattern() {
    _patternTimer?.cancel();
    if (patternIndex.value == 0) {
      isFlashing.value = true;
      return;
    }
    
    final int durationMs = (1000 / frequency.value).round();
    _patternTimer = Timer.periodic(
      Duration(milliseconds: durationMs),
      (timer) {
        isFlashing.value = !isFlashing.value;
      },
    );
  }
  
  Color get currentColor {
    if (!isOn.value) return Colors.black;
    if (patternIndex.value == 0 || isFlashing.value) {
      return colors[selectedColorIndex.value];
    }
    return Colors.black;
  }
  
  void goBack() {
    _patternTimer?.cancel();
    Get.back();
  }
}
