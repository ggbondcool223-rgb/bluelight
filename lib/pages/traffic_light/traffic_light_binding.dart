import 'package:get/get.dart';
import 'traffic_light_logic.dart';

class TrafficLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrafficLightLogic());
  }
}
