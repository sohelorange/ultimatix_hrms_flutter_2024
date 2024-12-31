class LeaveStatusModel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  LeaveStatusModel({this.status, this.code, this.message, this.data});

  LeaveStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'LeaveStatusModel(status: $status, code: $code, message: $message, data: $data)';
  }
}

class Data {
  int? leaveApprovalId;
  int? leaveApplicationId;
  String? applicationStatus;
  String? appStatus;
  int? cmpId;
  int? leaveId;
  String? fromDate;
  String? toDate;
  String? applicationDate;
  int? leaveAppDays;
  int? leaveApprDays;
  String? leaveCode;
  String? leaveAssignAs;
  String? leaveReason;
  String? leaveName;
  String? seniorEmployee;
  String? empFullName;
  int? empSuperior;
  String? halfLeaveDate;
  String? applicationComments;
  String? approvalComments;
  String? leaveCompOffDates;
  int? leaveCancelCount;

  Data({
    this.leaveApprovalId,
    this.leaveApplicationId,
    this.applicationStatus,
    this.appStatus,
    this.cmpId,
    this.leaveId,
    this.fromDate,
    this.toDate,
    this.applicationDate,
    this.leaveAppDays,
    this.leaveApprDays,
    this.leaveCode,
    this.leaveAssignAs,
    this.leaveReason,
    this.leaveName,
    this.seniorEmployee,
    this.empFullName,
    this.empSuperior,
    this.halfLeaveDate,
    this.applicationComments,
    this.approvalComments,
    this.leaveCompOffDates,
    this.leaveCancelCount,
  });

  Data.fromJson(Map<String, dynamic> json) {
    leaveApprovalId = json['leave_Approval_ID'];
    leaveApplicationId = json['leave_Application_ID'];
    applicationStatus = json['application_Status'];
    appStatus = json['appStatus'];
    cmpId = json['cmp_ID'];
    leaveId = json['leave_ID'];
    fromDate = json['from_Date'];
    toDate = json['to_Date'];
    applicationDate = json['application_Date'];
    leaveAppDays = json['leaveAppDays'];
    leaveApprDays = json['leaveApprDays'];
    leaveCode = json['leave_Code'];
    leaveAssignAs = json['leave_Assign_As'];
    leaveReason = json['leave_Reason'];
    leaveName = json['leave_Name'];
    seniorEmployee = json['senior_Employee'];
    empFullName = json['emp_Full_Name'];
    empSuperior = json['emp_Superior'];
    halfLeaveDate = json['half_Leave_Date'];
    applicationComments = json['application_Comments'];
    approvalComments = json['approval_Comments'];
    leaveCompOffDates = json['leave_CompOff_Dates'];
    leaveCancelCount = json['leaveCancelCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['leave_Approval_ID'] = leaveApprovalId;
    map['leave_Application_ID'] = leaveApplicationId;
    map['application_Status'] = applicationStatus;
    map['appStatus'] = appStatus;
    map['cmp_ID'] = cmpId;
    map['leave_ID'] = leaveId;
    map['from_Date'] = fromDate;
    map['to_Date'] = toDate;
    map['application_Date'] = applicationDate;
    map['leaveAppDays'] = leaveAppDays;
    map['leaveApprDays'] = leaveApprDays;
    map['leave_Code'] = leaveCode;
    map['leave_Assign_As'] = leaveAssignAs;
    map['leave_Reason'] = leaveReason;
    map['leave_Name'] = leaveName;
    map['senior_Employee'] = seniorEmployee;
    map['emp_Full_Name'] = empFullName;
    map['emp_Superior'] = empSuperior;
    map['half_Leave_Date'] = halfLeaveDate;
    map['application_Comments'] = applicationComments;
    map['approval_Comments'] = approvalComments;
    map['leave_CompOff_Dates'] = leaveCompOffDates;
    map['leaveCancelCount'] = leaveCancelCount;
    return map;
  }

  @override
  String toString() {
    return 'Data(leaveApprovalId: $leaveApprovalId, leaveApplicationId: $leaveApplicationId, applicationStatus: $applicationStatus, fromDate: $fromDate, toDate: $toDate)';
  }
}
