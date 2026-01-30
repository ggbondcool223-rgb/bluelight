import 'package:get/get.dart';
import 'colorful_light_logic.dart';

class ColorfulLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColorfulLightLogic());
  }
}
