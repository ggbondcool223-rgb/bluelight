import 'package:get/get.dart';
import 'sos_light_logic.dart';

class SosLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SosLightLogic());
  }
}
