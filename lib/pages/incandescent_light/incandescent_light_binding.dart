import 'package:get/get.dart';
import 'incandescent_light_logic.dart';

class IncandescentLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IncandescentLightLogic());
  }
}
