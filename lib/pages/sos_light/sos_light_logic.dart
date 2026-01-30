import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';

class SosLightLogic extends GetxController {
  final RxBool isOn = false.obs;
  final RxInt speedIndex = 1.obs;
  final RxBool isFlashing = false.obs;
  
  final List<int> dotDuration = [200, 150, 100];
  final List<int> dashDuration = [600, 450, 300];
  final List<int> pauseDuration = [200, 150, 100];
  
  Timer? _morseTimer;
  int _currentStep = 0;
  
  final List<bool> sosPattern = [
    true, false, true, false, true, false,
    true, true, true, false, true, true, true, false, true, true, true,
    true, false, true, false, true, false,
  ];
  
  @override
  void onClose() {
    _morseTimer?.cancel();
    super.onClose();
  }
  
  void toggleLight() {
    isOn.value = !isOn.value;
    if (isOn.value) {
      _currentStep = 0;
      _startMorse();
    } else {
      _morseTimer?.cancel();
      isFlashing.value = false;
    }
    Logger.i('SOS light ${isOn.value ? "on" : "off"}');
  }
  
  void setSpeed(int index) {
    speedIndex.value = index;
    if (isOn.value) {
      _morseTimer?.cancel();
      _currentStep = 0;
      _startMorse();
    }
  }
  
  void _startMorse() {
    _morseTimer?.cancel();
    _flashNext();
  }
  
  void _flashNext() {
    if (!isOn.value) return;
    
    if (_currentStep >= sosPattern.length) {
      _currentStep = 0;
    }
    
    final bool isDot = sosPattern[_currentStep];
    final int duration = isDot ? dotDuration[speedIndex.value] : dashDuration[speedIndex.value];
    
    isFlashing.value = true;
    
    _morseTimer = Timer(Duration(milliseconds: duration), () {
      isFlashing.value = false;
      _currentStep++;
      
      Timer(Duration(milliseconds: pauseDuration[speedIndex.value]), () {
        _flashNext();
      });
    });
  }
  
  Color get currentColor => isFlashing.value ? Colors.white : Colors.black;
  
  void goBack() {
    _morseTimer?.cancel();
    Get.back();
  }
}
