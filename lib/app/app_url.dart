import '../utility/preference_utils.dart';

class AppURL {
  //Static getServerIP link : https://hrms.webpayroll.in/Mobile_License/MobileLicence.asmx?op=ServerConnection
  //mobilerest

  //static const String baseURL = "https://hrms.webpayroll.in/mobile_license_new/"; //TODO: Swagger Local

  //static const String baseURL = "https://hrms.webpayroll.in/mobile_license_new/"; //TODO :Swagger Stage

  static const String baseURL =
      "https://hrms.webpayroll.in/mobile_license_new/"; //TODO : Swagger Live

  //Auth region
  static const String serverConnectionURL = "${baseURL}api/v1/ServerConnection";
  static String loginURL = "${PreferenceUtils.getAppUrl()}api/v1/LoginCheck";
  static String forgotPassWordURL =
      "${PreferenceUtils.getAppUrl()}api/v1/ForgotPassword";
  static String otpVerificationURL =
      "${PreferenceUtils.getAppUrl()}api/v1/otp/verification";
  static String resetPasswordURL =
      "${PreferenceUtils.getAppUrl()}api/v1/ChangePassword";

  //end region

  //Dashboard region
  static String dashboardURL = "${PreferenceUtils.getAppUrl()}api/v1/Dashboard";
  static String clockInOutTimeURL =
      "${PreferenceUtils.getAppUrl()}api/v1/GetPresentDayDuration";
  static const String geoLocation = 'api/v1/GeoLocationTracking';
  static const String addLocations = "api/v1/AddGeoLocation";
  static String logoutURL = "${PreferenceUtils.getAppUrl()}api/v1/Logout";

  //end region

  //ClockIn region
  static String clockInURL = '${PreferenceUtils.getAppUrl()}api/v1/clockin';
  static String clockOutURL = '${PreferenceUtils.getAppUrl()}api/v1/clockout';

  //end region

  //Leave region
  static String getLeaveBalanceURL =
      "${PreferenceUtils.getAppUrl()}api/v1/leavebalance";
  static String getLeaveStatusURL =
      "${PreferenceUtils.getAppUrl()}api/v1/GetLeaveApplicationRecords";
  static String getLeaveApplicationRecordsURL =
      "${PreferenceUtils.getAppUrl()}api/v1/GetLeaveApplicationRecords";
  static String managerApprovalDetailsURL =
      "${PreferenceUtils.getAppUrl()}api/v1/ManagerApprovalDetails";
  static String leaveCancellationApplicationURL =
      "${PreferenceUtils.getAppUrl()}api/v1/LeaveCancellationApplication";
  static String leaveApplicationURL =
      "${PreferenceUtils.getAppUrl()}api/v1/LeaveApplication";
  static String getLeaveRecordsURL =
      "${PreferenceUtils.getAppUrl()}api/v1/GetLeaveRecords";
  static String getShiftDetailsURL =
      "${PreferenceUtils.getAppUrl()}api/v1/GetShiftDeatails";
  static String getCompOffLeaveURL =
      "${PreferenceUtils.getAppUrl()}api/v1/GetCompOffLeave";
  static String getCancelLeaveURL = "${PreferenceUtils.getAppUrl()}api/v1/LeaveApprovalDetails";

  //end region

  //Live Tracking region
  static String geoLocationURL =
      '${PreferenceUtils.getAppUrl()}api/v1/GeoLocationTracking';
  static String getGeoLocationTrackingList =
      "${PreferenceUtils.getAppUrl()}api/v1/GeoLocationTrackingList";
  static String addLocationsURL =
      "${PreferenceUtils.getAppUrl()}api/v1/AddGeoLocation";

  //end region

  //Attendance region
  static String myTeamAttendanceURL =
      "${PreferenceUtils.getAppUrl()}api/v1/MyTeamAttendance";
  static String attendanceRegularizeDetailsURL =
      "${PreferenceUtils.getAppUrl()}api/v1/AttendanceRegularizeDetails";
  static String attendanceRegularizeInsertURL =
      "${PreferenceUtils.getAppUrl()}api/v1/AttendanceRegularizeInsert";
  static String attendanceGetReasonURL =
      "${PreferenceUtils.getAppUrl()}api/v1/GetReason";

  //end region

  //Medical region
  static String bindMedicalDepDetailsURL =
      "${PreferenceUtils.getAppUrl()}api/v1/BindMedicalDepDetails";
  static String bindMedicalIncidentURL =
      "${PreferenceUtils.getAppUrl()}api/v1/BindMedicalIncident";
  static String medicalInsertURL =
      "${PreferenceUtils.getAppUrl()}api/v1/MedicalInsert";

  //end region

  //Common region
  static String getStateURL = "${PreferenceUtils.getAppUrl()}api/v1/GetState";
  static String getCityURL = "${PreferenceUtils.getAppUrl()}api/v1/GetCity";

  //end region

  //Notification region
  static String getNotificationURL =
      "${PreferenceUtils.getAppUrl()}api/v1/GetNotification";

  //end region

  //Settings region
  static String changePassURL =
      "${PreferenceUtils.getAppUrl()}api/v1/ChangePassword";
  static String feedbackURL =
      "${PreferenceUtils.getAppUrl()}api/v1/AddTicketFeedback";
  //end region
}
