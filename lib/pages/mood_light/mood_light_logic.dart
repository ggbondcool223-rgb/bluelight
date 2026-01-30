import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/logger.dart';
import '../../lang/lang.dart';

class MoodLightLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final RxBool isOn = false.obs;
  final RxInt selectedMoodIndex = 0.obs;
  
  late AnimationController _animationController;
  final RxDouble animationValue = 0.0.obs;
  
  final List<Map<String, dynamic>> moods = [
    {
      'name': Lang.calm,
      'color': Colors.blue,
      'duration': 4000,
    },
    {
      'name': Lang.excited,
      'color': Colors.red,
      'duration': 2000,
    },
    {
      'name': Lang.focused,
      'color': Colors.green,
      'duration': 3000,
    },
    {
      'name': Lang.relaxed,
      'color': Colors.purple,
      'duration': 5000,
    },
    {
      'name': Lang.energetic,
      'color': Colors.orange,
      'duration': 1500,
    },
    {
      'name': Lang.sleep,
      'color': Colors.indigo,
      'duration': 6000,
    },
  ];
  
  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: moods[0]['duration']),
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
      _updateAnimation();
      _animationController.repeat(reverse: true);
    } else {
      _animationController.stop();
    }
    Logger.i('Mood light ${isOn.value ? "on" : "off"}');
  }
  
  void selectMood(int index) {
    selectedMoodIndex.value = index;
    if (isOn.value) {
      _updateAnimation();
      _animationController.repeat(reverse: true);
    }
  }
  
  void _updateAnimation() {
    final mood = moods[selectedMoodIndex.value];
    _animationController.duration = Duration(milliseconds: mood['duration']);
  }
  
  Color get currentColor {
    if (!isOn.value) return Colors.black;
    final mood = moods[selectedMoodIndex.value];
    final Color baseColor = mood['color'];
    final double opacity = 0.5 + (animationValue.value * 0.5);
    return baseColor.withValues(alpha: opacity);
  }
  
  String get currentMoodName => moods[selectedMoodIndex.value]['name'];
  
  void goBack() {
    Get.back();
  }
}
