import 'package:get/get.dart';

import 'mood_custom_logic.dart';

class MoodCustomBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      MoodCustomLogic(),
      permanent: true,
    );
  }
}
