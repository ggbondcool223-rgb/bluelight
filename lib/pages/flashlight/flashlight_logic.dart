import 'dart:async';
import 'package:get/get.dart';
import 'package:torch_light/torch_light.dart';
import '../../utils/logger.dart';

class FlashlightLogic extends GetxController {
  final RxBool isOn = false.obs;
  final RxInt selectedTimerIndex = 6.obs;
  
  final List<int> timerOptions = [1, 2, 5, 10, 20, 30, -1];
  
  Timer? _autoOffTimer;
  
  @override
  void onClose() {
    _autoOffTimer?.cancel();
    super.onClose();
  }
  
  Future<void> toggleLight() async {
    try {
      if (isOn.value) {
        await TorchLight.disableTorch();
        isOn.value = false;
        _autoOffTimer?.cancel();
        Logger.i('Flashlight turned off');
      } else {
        await TorchLight.enableTorch();
        isOn.value = true;
        _startTimer();
        Logger.i('Flashlight turned on');
      }
    } catch (e) {
      Logger.e('Failed to toggle flashlight', e);
    }
  }
  
  void selectTimer(int index) {
    selectedTimerIndex.value = index;
    if (isOn.value && timerOptions[index] != -1) {
      _autoOffTimer?.cancel();
      _startTimer();
    }
  }
  
  void _startTimer() {
    final timerMinutes = timerOptions[selectedTimerIndex.value];
    if (timerMinutes == -1) {
      return;
    }
    _autoOffTimer = Timer(Duration(minutes: timerMinutes), () {
      if (isOn.value) {
        toggleLight();
      }
    });
  }
  
  void goBack() {
    _autoOffTimer?.cancel();
    Get.back();
  }
}
