import 'package:get/get.dart';

import 'sun_notic_logic.dart';

class SunNoticBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
