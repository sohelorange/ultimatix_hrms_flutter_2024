import 'package:get/get.dart';

import '../../api/model/AttendanceRegularizeDetails.dart';
import '../../api/model/team_attendance_response.dart';

class AttendanceMainController extends GetxController{

  RxBool isLoading = true.obs;
  RxString userAddress = "".obs;
  RxString userCheckInTime = "10:00 AM".obs;
  RxString userCheckoutTime = "6:00 PM".obs;
  RxInt selectedYear = DateTime.now().year.obs;
  RxInt selectedMonth = DateTime.now().month.obs;
  RxList<String> items = <String>[
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ].obs;

  Rx<TeamAttendanceResponse> teamAttendanceResponse = TeamAttendanceResponse().obs;
  Rx<AttendanceRegularizeDetails> attendanceRegularizeDetails = AttendanceRegularizeDetails().obs;
  @override
  void onInit() {
    isLoading.value = false;
    super.onInit();
  }
}