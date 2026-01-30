import 'package:get/get.dart';
import 'timer_light_logic.dart';

class TimerLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TimerLightLogic());
  }
}
