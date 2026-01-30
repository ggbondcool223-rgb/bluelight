import 'package:get/get.dart';
import 'police_light_logic.dart';

class PoliceLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PoliceLightLogic());
  }
}
