import 'package:get/get.dart';
import 'electronic_candle_logic.dart';

class ElectronicCandleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ElectronicCandleLogic());
  }
}
