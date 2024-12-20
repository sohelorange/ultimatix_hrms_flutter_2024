import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserAttendanceController extends GetxController{

  RxBool isLoading = false.obs;
  Rx<String> currentMonth = "".obs;
  RxString userName = "".obs;
  RxString userProfile = "".obs;
  RxString userDesignation = "".obs;
  Rx<num> userEmpId = 0.obs;
  Rx<num> userCmpId = 0.obs;
  RxInt selectedYear = DateTime.now().year.obs;
  RxInt selectedMonth = DateTime.now().month.obs;

  RxList<String> items = <String>[
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }
}