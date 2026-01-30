import 'package:get/get.dart';
import 'flashlight_logic.dart';

class FlashlightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FlashlightLogic());
  }
}
