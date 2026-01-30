import 'package:get/get.dart';
import 'custom_light_logic.dart';

class CustomLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomLightLogic());
  }
}
