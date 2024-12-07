import 'package:get/get.dart';
import 'clock_in_out_controller.dart';

class ClockInOutBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> ClockInOutController());
  }
}