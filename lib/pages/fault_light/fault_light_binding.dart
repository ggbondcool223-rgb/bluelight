import 'package:get/get.dart';
import 'fault_light_logic.dart';

class FaultLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaultLightLogic());
  }
}
