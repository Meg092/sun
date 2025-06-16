import 'package:get/get.dart';

import 'load_error_logic.dart';

class LoadErrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoadErrorLogic());
  }
}
