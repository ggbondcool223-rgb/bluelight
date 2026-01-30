import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../lang/lang.dart';

class ToolboxLogic extends GetxController {
  final List<Map<String, dynamic>> tools = [
    {'name': Lang.policeLight, 'icon': Icons.local_police, 'route': '/police_light'},
    {'name': Lang.colorfulLight, 'icon': Icons.palette, 'route': '/colorful_light'},
    {'name': Lang.trafficLight, 'icon': Icons.traffic, 'route': '/traffic_light'},
    {'name': Lang.faultLight, 'icon': Icons.warning, 'route': '/fault_light'},
    {'name': Lang.incandescentLight, 'icon': Icons.lightbulb, 'route': '/incandescent_light'},
    {'name': Lang.sosLight, 'icon': Icons.sos, 'route': '/sos_light'},
    {'name': Lang.strobeLight, 'icon': Icons.flash_on_outlined, 'route': '/strobe_light'},
    {'name': Lang.breathingLight, 'icon': Icons.air, 'route': '/breathing_light'},
    {'name': Lang.rainbowLight, 'icon': Icons.gradient, 'route': '/rainbow_light'},
    {'name': Lang.customLight, 'icon': Icons.tune, 'route': '/custom_light'},
    {'name': Lang.metronomeLight, 'icon': Icons.music_note, 'route': '/metronome_light'},
    {'name': Lang.moodLight, 'icon': Icons.emoji_emotions, 'route': '/mood_light'},
    {'name': Lang.timerLight, 'icon': Icons.timer, 'route': '/timer_light'},
  ];

  void navigateToTool(String route) {
    Get.toNamed(route);
  }

  void goBack() {
    Get.back();
  }
}
