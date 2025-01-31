import 'package:get/get.dart';

import 'regularize_apply_controller.dart';

class RegularizeApplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegularizeApplyController());
  }
}
