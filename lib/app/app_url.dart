import '../utility/preference_utils.dart';

class AppURL {
  //Static getServerIP link : https://hrms.webpayroll.in/Mobile_License/MobileLicence.asmx?op=ServerConnection
  //Server IP : mobilerest
  //Username : 0060@mobile,0058@mobile,0057@mobile,0020@mobile,0032@mobile
  //Password : m5o0t5 or admin

  //static const String baseURL = "https://hrms.webpayroll.in/mobile_license_new/"; //TODO: Swagger Local

  //static const String baseURL = "https://hrms.webpayroll.in/mobile_license_new/"; //TODO :Swagger Stage

  static const String baseURL =
      "https://hrms.webpayroll.in/mobile_license_new/"; //TODO : Swagger Live
  static const String emailBaseUrl =
      'http://120.72.91.75:1203//Email_Webservice.asmx';
  static const String sentEmailUrl = '${emailBaseUrl}SentEmail';

  //{TranID=587102; EmailType=Attendance Regularization; }

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
  static String addLocations =
      "${PreferenceUtils.getAppUrl()}api/v1/AddGeoLocation";
  static String logoutURL = "${PreferenceUtils.getAppUrl()}api/v1/Logout";

  //end region

  //ClockIn region
  static String clockInURL = '${PreferenceUtils.getAppUrl()}api/v1/clockin';
  static String clockOutURL = '${PreferenceUtils.getAppUrl()}api/v1/clockout';
  static String checkInOutStatusURL =
      '${PreferenceUtils.getAppUrl()}api/v1/CheckINOUT';
  static String geolocationrecords =
      '${PreferenceUtils.getAppUrl()}api/v1/GeoLocationRecords';

  //end region

  //Employee region
  static String getEmployeeDetailsURL =
      '${PreferenceUtils.getAppUrl()}api/v1/EmployeeDetails';
  static String updateEmployeeDetailsURL =
      '${PreferenceUtils.getAppUrl()}api/v1/UpdateEmployeeDetails';
  static String getEmployeeFavDetailsURL =
      '${PreferenceUtils.getAppUrl()}api/v1/EmployeeFavDetails';
  static String getEmployeeFamilyDetailsURL =
      '${PreferenceUtils.getAppUrl()}api/v1/EmployeeChildrenDetails_List';
  static String getEmployeeFamilyDropdownURL =
      '${PreferenceUtils.getAppUrl()}api/v1/UnisonMaster';
  static String insertEmployeeFamilyDetailsURL =
      '${PreferenceUtils.getAppUrl()}api/v1/EmpChildDetailInsert';
  static String updateEmployeeFamilyDetailsURL =
      '${PreferenceUtils.getAppUrl()}api/v1/EmpChildDetailUpdate';
  static String getFamilyInformationDetailsURL =
      '${PreferenceUtils.getAppUrl()}api/v1/EmployeeChildrenDetail';
  static String deleteFamilyInformationDetailsURL =
      '${PreferenceUtils.getAppUrl()}api/v1/EmpChildDetailDelete';

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
  static String getCancelLeaveURL =
      "${PreferenceUtils.getAppUrl()}api/v1/LeaveApprovalDetails";
  static String insertCancelLeaveURL =
      "${PreferenceUtils.getAppUrl()}api/v1/LeaveCancellationApplication";

  //end region

  //approval region
  static String managerApprovalCount =
      "${PreferenceUtils.getAppUrl()}api/v1/GetDashboardApplicationsCount";
  static String managerApprovalLeaveURL =
      "${PreferenceUtils.getAppUrl()}api/v1/LeaveApplicationRecords";
  static String managerApprovalInsertURL =
      "${PreferenceUtils.getAppUrl()}api/v1/LeaveApproval";

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

  //Attendance Regularize Approval
  static String attendanceRegularizeApplicationRecord =
      "${PreferenceUtils.getAppUrl()}api/v1/AttendanceRegularizeApplicationRecord";
  static String getAttendanceRegularizeApplicationDetails =
      "${PreferenceUtils.getAppUrl()}api/v1/GetAttendanceRegularizeApplicationDetails";
  static String attendanceRegularizeApproval =
      "${PreferenceUtils.getAppUrl()}api/v1/AttendanceRegularizeApproval";

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
