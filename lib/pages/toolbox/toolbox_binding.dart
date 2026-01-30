import 'package:get/get.dart';
import 'toolbox_logic.dart';

class ToolboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ToolboxLogic());
  }
}
