class LeaveManagerApprovalModel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  LeaveManagerApprovalModel({this.status, this.code, this.message, this.data});

  LeaveManagerApprovalModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? rowID;
  int? cmpID;
  int? leaveID;
  int? empID;
  String? empFullName;
  String? leaveName;
  String? applicationCode;
  String? applicationStatus;
  String? seniorEmployee;
  int? leaveApplicationID;
  String? empFirstName;
  String? empCode;
  String? branchName;
  String? desigName;
  String? alphaEmpCode;
  String? leaveReason;
  String? applicationDate;
  int? rptLevel;
  int? schemeID;
  String? leave;
  int? finalApprover;
  int? isFwdLeaveRej;
  String? fromDate;
  String? toDate;
  int? leavePeriod;
  int? isPassOver;
  int? actualLeaveId;
  String? actualCancelWoHo;
  int? branchId;
  String? isBackdatedApplication;
  String? leaveType;
  int? verticalID;
  int? subVerticalId;
  int? deptID;
  String? deptName;
  String? leaveApplicationStatus;
  String? inTime;
  String? outTime;
  String? imagePath;

  Data(
      {this.rowID,
      this.cmpID,
      this.leaveID,
      this.empID,
      this.empFullName,
      this.leaveName,
      this.applicationCode,
      this.applicationStatus,
      this.seniorEmployee,
      this.leaveApplicationID,
      this.empFirstName,
      this.empCode,
      this.branchName,
      this.desigName,
      this.alphaEmpCode,
      this.leaveReason,
      this.applicationDate,
      this.rptLevel,
      this.schemeID,
      this.leave,
      this.finalApprover,
      this.isFwdLeaveRej,
      this.fromDate,
      this.toDate,
      this.leavePeriod,
      this.isPassOver,
      this.actualLeaveId,
      this.actualCancelWoHo,
      this.branchId,
      this.isBackdatedApplication,
      this.leaveType,
      this.verticalID,
      this.subVerticalId,
      this.deptID,
      this.deptName,
      this.leaveApplicationStatus,
      this.inTime,
      this.outTime,
      this.imagePath});

  Data.fromJson(Map<String, dynamic> json) {
    rowID = json['row_ID'];
    cmpID = json['cmp_ID'];
    leaveID = json['leave_ID'];
    empID = json['emp_ID'];
    empFullName = json['emp_Full_Name'];
    leaveName = json['leave_Name'];
    applicationCode = json['application_Code'];
    applicationStatus = json['application_Status'];
    seniorEmployee = json['senior_Employee'];
    leaveApplicationID = json['leave_Application_ID'];
    empFirstName = json['emp_first_name'];
    empCode = json['emp_Code'];
    branchName = json['branch_Name'];
    desigName = json['desig_Name'];
    alphaEmpCode = json['alpha_Emp_code'];
    leaveReason = json['leave_Reason'];
    applicationDate = json['application_Date'];
    rptLevel = json['rpt_Level'];
    schemeID = json['scheme_ID'];
    leave = json['leave'];
    finalApprover = json['final_Approver'];
    isFwdLeaveRej = json['is_Fwd_Leave_Rej'];
    fromDate = json['from_Date'];
    toDate = json['to_Date'];
    leavePeriod = json['leave_Period'];
    isPassOver = json['is_pass_over'];
    actualLeaveId = json['actual_leave_id'];
    actualCancelWoHo = json['actual_cancel_wo_ho'];
    branchId = json['branch_id'];
    isBackdatedApplication = json['is_Backdated_Application'];
    leaveType = json['leave_Type'];
    verticalID = json['vertical_ID'];
    subVerticalId = json['subVertical_Id'];
    deptID = json['dept_ID'];
    deptName = json['dept_Name'];
    leaveApplicationStatus = json['leave_Application_Status'];
    inTime = json['in_Time'];
    outTime = json['out_Time'];
    imagePath = json['image_Path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['row_ID'] = rowID;
    data['cmp_ID'] = cmpID;
    data['leave_ID'] = leaveID;
    data['emp_ID'] = empID;
    data['emp_Full_Name'] = empFullName;
    data['leave_Name'] = leaveName;
    data['application_Code'] = applicationCode;
    data['application_Status'] = applicationStatus;
    data['senior_Employee'] = seniorEmployee;
    data['leave_Application_ID'] = leaveApplicationID;
    data['emp_first_name'] = empFirstName;
    data['emp_Code'] = empCode;
    data['branch_Name'] = branchName;
    data['desig_Name'] = desigName;
    data['alpha_Emp_code'] = alphaEmpCode;
    data['leave_Reason'] = leaveReason;
    data['application_Date'] = applicationDate;
    data['rpt_Level'] = rptLevel;
    data['scheme_ID'] = schemeID;
    data['leave'] = leave;
    data['final_Approver'] = finalApprover;
    data['is_Fwd_Leave_Rej'] = isFwdLeaveRej;
    data['from_Date'] = fromDate;
    data['to_Date'] = toDate;
    data['leave_Period'] = leavePeriod;
    data['is_pass_over'] = isPassOver;
    data['actual_leave_id'] = actualLeaveId;
    data['actual_cancel_wo_ho'] = actualCancelWoHo;
    data['branch_id'] = branchId;
    data['is_Backdated_Application'] = isBackdatedApplication;
    data['leave_Type'] = leaveType;
    data['vertical_ID'] = verticalID;
    data['subVertical_Id'] = subVerticalId;
    data['dept_ID'] = deptID;
    data['dept_Name'] = deptName;
    data['leave_Application_Status'] = leaveApplicationStatus;
    data['in_Time'] = inTime;
    data['out_Time'] = outTime;
    data['image_Path'] = imagePath;
    return data;
  }
}
