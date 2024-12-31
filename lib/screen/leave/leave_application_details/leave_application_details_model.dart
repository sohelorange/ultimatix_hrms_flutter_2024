class LeaveApplicationDetailsResponse {
  bool? status;
  int? code;
  String? message;
  List<LeaveApplicationDetailsModel>? data;

  LeaveApplicationDetailsResponse(
      {this.status, this.code, this.message, this.data});

  LeaveApplicationDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LeaveApplicationDetailsModel>[];
      json['data'].forEach((v) {
        data!.add(LeaveApplicationDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'LeaveApplicationDetailsModel(status: $status, code: $code, message: $message, data: $data)';
  }
}

class LeaveApplicationDetailsModel {
  int? leaveApplicationID;
  int? leaveApprovalID;
  String? fromDate;
  String? toDate;
  double? leavePeriod;  // Change to double
  String? leaveName;
  String? leaveAssignAs;
  String? approvalComments;
  String? forDate;
  double? leaveUsed;    // Change to double
  int? tranID;
  int? isApprove;
  double? actualLeaveDay;  // Change to double
  double? leavECANCELPERIOD;  // Change to double
  double? remaiNLEAVEPERIOD;  // Change to double
  String? remaiNDAY;
  String? dayType;
  String? comment;
  String? mComment;
  String? appstatus;

  LeaveApplicationDetailsModel({
    this.leaveApplicationID,
    this.leaveApprovalID,
    this.fromDate,
    this.toDate,
    this.leavePeriod,
    this.leaveName,
    this.leaveAssignAs,
    this.approvalComments,
    this.forDate,
    this.leaveUsed,
    this.tranID,
    this.isApprove,
    this.actualLeaveDay,
    this.leavECANCELPERIOD,
    this.remaiNLEAVEPERIOD,
    this.remaiNDAY,
    this.dayType,
    this.comment,
    this.mComment,
    this.appstatus,
  });

  LeaveApplicationDetailsModel.fromJson(Map<String, dynamic> json) {
    leaveApplicationID = json['leave_Application_ID'];
    leaveApprovalID = json['leave_Approval_ID'];
    fromDate = json['from_Date'];
    toDate = json['to_Date'];
    leavePeriod = json['leave_Period'].toDouble();  // Use toDouble() if it's an integer
    leaveName = json['leave_Name'];
    leaveAssignAs = json['leave_Assign_As'];
    approvalComments = json['approval_Comments'];
    forDate = json['for_Date'];
    leaveUsed = json['leave_Used'].toDouble();  // Use toDouble() if it's an integer
    tranID = json['tran_ID'];
    isApprove = json['is_Approve'];
    actualLeaveDay = json['actual_Leave_Day'].toDouble();  // Use toDouble() if it's an integer
    leavECANCELPERIOD = json['leavE_CANCEL_PERIOD'].toDouble();  // Use toDouble() if it's an integer
    remaiNLEAVEPERIOD = json['remaiN_LEAVE_PERIOD'].toDouble();  // Use toDouble() if it's an integer
    remaiNDAY = json['remaiN_DAY'];
    dayType = json['day_Type'];
    comment = json['comment'];
    mComment = json['mComment'];
    appstatus = json['appstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leave_Application_ID'] = leaveApplicationID;
    data['leave_Approval_ID'] = leaveApprovalID;
    data['from_Date'] = fromDate;
    data['to_Date'] = toDate;
    data['leave_Period'] = leavePeriod;
    data['leave_Name'] = leaveName;
    data['leave_Assign_As'] = leaveAssignAs;
    data['approval_Comments'] = approvalComments;
    data['for_Date'] = forDate;
    data['leave_Used'] = leaveUsed;
    data['tran_ID'] = tranID;
    data['is_Approve'] = isApprove;
    data['actual_Leave_Day'] = actualLeaveDay;
    data['leavE_CANCEL_PERIOD'] = leavECANCELPERIOD;
    data['remaiN_LEAVE_PERIOD'] = remaiNLEAVEPERIOD;
    data['remaiN_DAY'] = remaiNDAY;
    data['day_Type'] = dayType;
    data['comment'] = comment;
    data['mComment'] = mComment;
    data['appstatus'] = appstatus;
    return data;
  }

  @override
  String toString() {
    return 'LeaveApplicationDetailsModel(leaveApprovalId: $leaveApprovalID, leaveApplicationId: $leaveApplicationID, isApprove: $isApprove, fromDate: $fromDate, toDate: $toDate)';
  }
}
