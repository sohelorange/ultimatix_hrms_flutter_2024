import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/attendance_main_bind.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/attendance_main_ui.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/regularizationListApprovals/regularization_list_approvals_bind.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/regularizeApplication/regularize_apply_bind.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/regularizeApplication/regularize_apply_ui.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/forgotpassword/forgot_pass_view.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/dashboard_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/dashboard_view.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/serverconnection/server_connection_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/serverconnection/server_connection_view.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/drawer/drawer_dash_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/drawer/drawer_dash_view.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/notification_announcement/notification_announcement_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/notification_announcement/notification_announcement_view.dart';
import 'package:ultimatix_hrms_flutter/screen/explore/explore_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/explore/explore_view.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/add_leave/add_leave_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/add_leave/add_leave_view.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_app_view.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_application_details/leave_application_details_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_application_details/leave_application_details_view.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_approval_status/leave_approval_status_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_approval_status/leave_approval_status_view.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/liveTracking/live_tracking_bind.dart';
import 'package:ultimatix_hrms_flutter/screen/liveTracking/live_tracking_ui.dart';
import 'package:ultimatix_hrms_flutter/screen/settings/change_password/change_password_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/settings/change_password/change_password_view.dart';
import 'package:ultimatix_hrms_flutter/screen/settings/feedback/feedback_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/settings/feedback/feedback_view.dart';
import 'package:ultimatix_hrms_flutter/screen/settings/settings_binding.dart';
import 'package:ultimatix_hrms_flutter/screen/settings/settings_view.dart';

import '../screen/attendanceReg/regularizationListApprovals/regularization_list_approvals_ui.dart';
import '../screen/attendanceReg/regularizeApprovals/regularization_approval_bind.dart';
import '../screen/attendanceReg/regularizeApprovals/regularization_approval_ui.dart';
import '../screen/attendanceReg/userAttendanceRegularize/attendance_user_bind.dart';
import '../screen/attendanceReg/userAttendanceRegularize/attendance_user_ui.dart';
import '../screen/auth/forgotpassword/forgot_pass_binding.dart';
import '../screen/auth/login/login_binding.dart';
import '../screen/auth/login/login_view_new.dart';
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
  static const drawerRoute = '/drawer_route';
  static const notificationAnnouncementRoute =
      '/notification_announcement_route';

  //end region

  //leave region
  static const leaveApplicationRoute = '/leave_application_route';
  static const leaveRequestDetailRoute = '/leave_request_detail_route';
  static const addLeaveRoute = '/add_leave_route';
  static const leaveApprovalRoute = '/leave__approval_route';

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
  static const attendanceMainRoute = '/attendance_main_route';
  static const userAttendanceRoute = '/user_attendance_route';
  static const regularizeApplyRoute = '/regularize_apply_route';
  static const regularizeListApprovals = '/regularize_list_approvals';
  static const regularizeApproval = '/regularize_approval';

  //static const regularizationRoute = '/regularization_route';
  //static const regularizationDetailRoute = '/regularization_detail_route';
  //end region

  //medical region
  static const medicalRoute = '/medical_route';
  static const medicalApplicationRoute = '/medical_application_route';
  static const medicalSelfRoute = '/medical_self_route';
  static const medicalOtherRoute = '/medical_Other_route';

  //end region

  //settings region
  static const settingsRoute = '/settings_route';
  static const changePasswordRoute = '/change_password_route';
  static const feedbackRoute = '/feedback_route';

  //end region

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.initialRoute,
      page: () => SplashView(),
    ),
    GetPage(
      name: AppRoutes.loginRoute,
      binding: LoginBinding(),
      page: () => const LoginViewNew(),
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
    ),
    GetPage(
      name: AppRoutes.liveTrackingRoute,
      binding: LiveTrackingBinding(),
      page: () => const LiveTrackingUi(),
    ),
    GetPage(
      name: AppRoutes.attendanceMainRoute,
      binding: AttendanceMainBinding(),
      page: () => const AttendanceMainUi(),
    ),
    GetPage(
      name: AppRoutes.userAttendanceRoute,
      binding: AttendanceUserBind(),
      page: () => const UserAttendanceUi(),
    ),
    GetPage(
      name: AppRoutes.regularizeApplyRoute,
      binding: RegularizeApplyBinding(),
      page: () => const RegularizeApplyUi(),
    ),
    GetPage(
      name: AppRoutes.regularizeListApprovals,
      binding: RegularizationListApprovalsBind(),
      page: () => const RegularizationListApprovalsUi(),
    ),
    GetPage(
      name: AppRoutes.regularizeApproval,
      binding: RegularizationApprovalBind(),
      page: () => const RegularizationApprovalUi(),
    ),
    GetPage(
      name: AppRoutes.exploreTabRoute,
      binding: ExploreBinding(),
      page: () => const ExploreView(),
    ),
    GetPage(
      name: AppRoutes.drawerRoute,
      binding: DrawerDashBinding(),
      page: () => const DrawerDashView(),
    ),
    GetPage(
      name: AppRoutes.leaveApplicationRoute,
      binding: LeaveBinding(),
      page: () => const LeaveAppView(),
    ),
    GetPage(
      name: AppRoutes.addLeaveRoute,
      binding: AddLeaveBinding(),
      page: () => const AddLeaveView(),
    ),
    GetPage(
      name: AppRoutes.leaveRequestDetailRoute,
      binding: LeaveApplicationDetailsBinding(),
      page: () => const LeaveApplicationDetailsView(),
    ),
    GetPage(
      name: AppRoutes.leaveApprovalRoute,
      binding: LeaveApprovalStatusBinding(),
      page: () => const LeaveApprovalStatusView(),
    ),
    GetPage(
      name: AppRoutes.notificationAnnouncementRoute,
      binding: NotificationAnnouncementBinding(),
      page: () => const NotificationAnnouncementView(),
    ),
    GetPage(
      name: AppRoutes.settingsRoute,
      binding: SettingsBinding(),
      page: () => const SettingsView(),
    ),
    GetPage(
      name: AppRoutes.changePasswordRoute,
      binding: ChangePasswordBinding(),
      page: () => const ChangePasswordView(),
    ),
    GetPage(
      name: AppRoutes.feedbackRoute,
      binding: FeedbackBinding(),
      page: () => const FeedbackView(),
    ),
  ];
}
