import 'package:get/get.dart';
import 'metronome_light_logic.dart';

class MetronomeLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MetronomeLightLogic());
  }
}
