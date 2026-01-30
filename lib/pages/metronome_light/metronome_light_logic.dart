import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';

class MetronomeLightLogic extends GetxController {
  final RxBool isOn = false.obs;
  final RxInt bpm = 120.obs;
  final RxBool isFlashing = false.obs;
  
  Timer? _metronomeTimer;
  
  @override
  void onClose() {
    _metronomeTimer?.cancel();
    super.onClose();
  }
  
  void toggleLight() {
    isOn.value = !isOn.value;
    if (isOn.value) {
      _startMetronome();
    } else {
      _metronomeTimer?.cancel();
      isFlashing.value = false;
    }
    Logger.i('Metronome light ${isOn.value ? "on" : "off"}');
  }
  
  void setBpm(int value) {
    bpm.value = value.clamp(40, 200);
    if (isOn.value) {
      _metronomeTimer?.cancel();
      _startMetronome();
    }
  }
  
  void _startMetronome() {
    _metronomeTimer?.cancel();
    final int durationMs = (60000 / bpm.value).round();
    _metronomeTimer = Timer.periodic(
      Duration(milliseconds: durationMs),
      (timer) {
        isFlashing.value = true;
        Timer(const Duration(milliseconds: 50), () {
          isFlashing.value = false;
        });
      },
    );
  }
  
  Color get currentColor => isFlashing.value ? Colors.white : Colors.black;
  
  void goBack() {
    _metronomeTimer?.cancel();
    Get.back();
  }
}
