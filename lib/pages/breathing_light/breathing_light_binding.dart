import 'package:get/get.dart';
import 'breathing_light_logic.dart';

class BreathingLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BreathingLightLogic());
  }
}
