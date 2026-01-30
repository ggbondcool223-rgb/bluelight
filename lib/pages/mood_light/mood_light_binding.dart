import 'package:get/get.dart';
import 'mood_light_logic.dart';

class MoodLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoodLightLogic());
  }
}
