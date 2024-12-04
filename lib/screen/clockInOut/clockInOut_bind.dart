import 'package:get/get.dart';
import 'clockInOut_controller.dart';

class ClockInOutBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> ClockInOutController());
  }
}