import 'package:get/get.dart';

import 'sun_add_logic.dart';

class SunAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SunAddLogic());
  }
}
