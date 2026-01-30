import 'package:get/get.dart';
import 'rainbow_light_logic.dart';

class RainbowLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RainbowLightLogic());
  }
}
