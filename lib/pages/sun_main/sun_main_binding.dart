import 'package:get/get.dart';

import 'sun_main_logic.dart';

class SunMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SunMainLogic());
  }
}
