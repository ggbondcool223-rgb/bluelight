import 'package:get/get.dart';
import 'strobe_light_logic.dart';

class StrobeLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StrobeLightLogic());
  }
}
