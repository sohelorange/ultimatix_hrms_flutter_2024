import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/forgotpassword/forgot_pass_view.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/login/login_view.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/dashboard_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/dashboard_view.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/serverconnection/server_connection_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/serverconnection/server_connection_view.dart';

import '../screen/auth/forgotpassword/forgot_pass_binding.dart';
import '../screen/auth/login/login_binding.dart';
import '../screen/clockInOut/clock_in_out_bind.dart';
import '../screen/clockInOut/clock_in_out_ui.dart';
import '../screen/splash/splash_view.dart';

/// All routes for app pages are defined here
class AppRoutes {
  static const initialRoute = '/splash_route';

  //auth region
  static const loginRoute = '/login_route';
  static const forgotPasswordRoute = '/forgot_password_route';
  static const setPermissionRoute = '/set_permission_route';
  static const serverRoute = '/server_route';

  //end region

  //dashboard region
  //static const geoFencingRoute = '/geo_fencing_route';
  static const dashBoardRoute = '/dash_board_route';

  //end region

  //leave region
  static const leaveApplicationDetailRoute = '/leave_application_detail_route';
  static const leaveRequestDetailRoute = '/leave_request_detail_route';
  static const addLeaveRoute = '/add_leave_route';

  //end region

  //clock in region
  static const clockInRoute = '/clock_in_route';

  //end region

  //live tracking region
  static const liveTrackingRoute = '/live_tracking_route';

  //end region

  //explore tab region
  static const exploreTabRoute = '/explore_tab_route';

  //end region

  //travel region
  static const travelRoute = '/travel_route';
  static const travelAddRoute = '/travel_add_route';

  //end region

  //attendance region
  static const attendanceRoute = '/attendance_route';
  static const userAttendanceRoute = '/user_attendance_route';
  static const regularizeRequestRoute = '/regularize_request_route';

  //static const regularizationRoute = '/regularization_route';
  //static const regularizationDetailRoute = '/regularization_detail_route';
  //end region

  //medical region
  static const medicalRoute = '/medical_route';
  static const medicalApplicationRoute = '/medical_application_route';
  static const medicalSelfRoute = '/medical_self_route';
  static const medicalOtherRoute = '/medical_Other_route';

  //end region

  //notification region
  static const notificationRoute = '/notification_route';

  //end region

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.initialRoute,
      page: () => SplashView(),
    ),
    GetPage(
      name: AppRoutes.loginRoute,
      binding: LoginBinding(),
      page: () => const LoginView(),
    ),
    GetPage(
      name: AppRoutes.dashBoardRoute,
      binding: DashboardBinding(),
      page: () => const DashboardView(),
    ),
    GetPage(
      name: AppRoutes.serverRoute,
      binding: ServerConnectionBinding(),
      page: () => const ServerConnectionView(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordRoute,
      binding: ForgotPassBinding(),
      page: () => const ForgotPassView(),
    ),
    GetPage(
      name: AppRoutes.clockInRoute,
      binding: ClockInOutBinding(),
      page: () => const ClockInOutUi(),
    )
  ];
}
