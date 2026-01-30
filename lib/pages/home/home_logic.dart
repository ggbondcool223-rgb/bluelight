import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:torch_light/torch_light.dart';
import '../../utils/logger.dart';
import '../../lang/lang.dart';

class HomeLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final Battery _battery = Battery();
  
  final RxBool isFlashlightOn = false.obs;
  final RxInt selectedTimerIndex = 6.obs;
  final RxString remainingTime = '0小时0分钟'.obs;
  final RxDouble batteryLevel = 100.0.obs;
  
  final List<int> timerOptions = [1, 2, 5, 10, 20, 30, -1];
  
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;
  
  Animation<double> get breathingAnimation => _breathingAnimation;
  
  @override
  void onInit() {
    super.onInit();
    _initBattery();
    _updateRemainingTime();
    _initBreathingAnimation();
  }
  
  void _initBreathingAnimation() {
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    
    _breathingAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _breathingController,
      curve: Curves.easeInOut,
    ));
  }
  
  void _updateBreathingAnimation() {
    if (isFlashlightOn.value) {
      _breathingController.repeat(reverse: true);
    } else {
      _breathingController.stop();
      _breathingController.reset();
    }
  }
  
  @override
  void onClose() {
    _breathingController.dispose();
    super.onClose();
  }
  
  Future<void> _initBattery() async {
    try {
      final level = await _battery.batteryLevel;
      batteryLevel.value = level.toDouble();
      _battery.onBatteryStateChanged.listen((state) async {
        final level = await _battery.batteryLevel;
        batteryLevel.value = level.toDouble();
        _updateRemainingTime();
      });
    } catch (e) {
      Logger.e('Failed to get battery level', e);
    }
  }
  
  void _updateRemainingTime() {
    final estimatedHours = (batteryLevel.value / 100 * 10).floor();
    final estimatedMinutes = ((batteryLevel.value / 100 * 10 % 1) * 60).floor();
    remainingTime.value = '$estimatedHours${Lang.hour}$estimatedMinutes${Lang.minute}';
  }
  
  Future<void> toggleFlashlight() async {
    try {
      if (isFlashlightOn.value) {
        await TorchLight.disableTorch();
        isFlashlightOn.value = false;
        _updateBreathingAnimation();
        Logger.i('Flashlight turned off');
      } else {
        await TorchLight.enableTorch();
        isFlashlightOn.value = true;
        _updateBreathingAnimation();
        Logger.i('Flashlight turned on');
        _startTimer();
      }
    } catch (e) {
      Logger.e('Failed to toggle flashlight', e);
    }
  }
  
  void selectTimer(int index) {
    selectedTimerIndex.value = index;
    if (isFlashlightOn.value && timerOptions[index] != -1) {
      _startTimer();
    }
  }
  
  void _startTimer() {
    final timerMinutes = timerOptions[selectedTimerIndex.value];
    if (timerMinutes == -1) {
      return;
    }
    Future.delayed(Duration(minutes: timerMinutes), () {
      if (isFlashlightOn.value) {
        toggleFlashlight();
      }
    });
  }
  
  void navigateToToolbox() {
    Get.toNamed('/toolbox');
  }
}
