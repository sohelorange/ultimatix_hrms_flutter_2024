class LeaveBalanceModel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  LeaveBalanceModel({this.status, this.code, this.message, this.data});

  LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return 'LeaveBalanceModel(status: $status, code: $code, message: $message, data: $data)';
  }
}

class Data {
  int? cmpID;
  int? empID;
  String? forDate;
  int? leaveOpening;
  int? leaveCredit;
  int? leaveUsed;
  int? leaveClosing;
  int? leaveID;
  String? leaveType;
  String? leaveName;
  String? empFullName;
  int? empCode;
  String? alphaEmpCode;
  String? empFirstName;
  String? grdName;
  String? compName;
  String? branchName;
  String? deptName;
  String? desigName;
  String? cmpName;
  String? cmpAddress;
  String? pFromDate;
  String? pToDate;
  int? branchId;
  String? typeName;
  int? desigDisNo;
  String? verticalName;
  String? subVerticalName;
  String? subBranchName;
  String? leaveCode;
  String? gender;

  Data(
      {this.cmpID,
      this.empID,
      this.forDate,
      this.leaveOpening,
      this.leaveCredit,
      this.leaveUsed,
      this.leaveClosing,
      this.leaveID,
      this.leaveType,
      this.leaveName,
      this.empFullName,
      this.empCode,
      this.alphaEmpCode,
      this.empFirstName,
      this.grdName,
      this.compName,
      this.branchName,
      this.deptName,
      this.desigName,
      this.cmpName,
      this.cmpAddress,
      this.pFromDate,
      this.pToDate,
      this.branchId,
      this.typeName,
      this.desigDisNo,
      this.verticalName,
      this.subVerticalName,
      this.subBranchName,
      this.leaveCode,
      this.gender});

  Data.fromJson(Map<String, dynamic> json) {
    cmpID = json['cmp_ID'];
    empID = json['emp_ID'];
    forDate = json['for_Date'];
    leaveOpening = json['leave_Opening'];
    leaveCredit = json['leave_Credit'];
    leaveUsed = json['leave_Used'];
    leaveClosing = json['leave_Closing'];
    leaveID = json['leave_ID'];
    leaveType = json['leave_Type'];
    leaveName = json['leave_Name'];
    empFullName = json['emp_Full_Name'];
    empCode = json['emp_Code'];
    alphaEmpCode = json['alpha_Emp_Code'];
    empFirstName = json['emp_First_Name'];
    grdName = json['grd_Name'];
    compName = json['comp_Name'];
    branchName = json['branch_Name'];
    deptName = json['dept_Name'];
    desigName = json['desig_Name'];
    cmpName = json['cmp_Name'];
    cmpAddress = json['cmp_Address'];
    pFromDate = json['p_From_Date'];
    pToDate = json['p_To_Date'];
    branchId = json['branch_Id'];
    typeName = json['type_Name'];
    desigDisNo = json['desig_Dis_No'];
    verticalName = json['vertical_Name'];
    subVerticalName = json['subVertical_Name'];
    subBranchName = json['subBranch_Name'];
    leaveCode = json['leave_Code'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmp_ID'] = cmpID;
    data['emp_ID'] = empID;
    data['for_Date'] = forDate;
    data['leave_Opening'] = leaveOpening;
    data['leave_Credit'] = leaveCredit;
    data['leave_Used'] = leaveUsed;
    data['leave_Closing'] = leaveClosing;
    data['leave_ID'] = leaveID;
    data['leave_Type'] = leaveType;
    data['leave_Name'] = leaveName;
    data['emp_Full_Name'] = empFullName;
    data['emp_Code'] = empCode;
    data['alpha_Emp_Code'] = alphaEmpCode;
    data['emp_First_Name'] = empFirstName;
    data['grd_Name'] = grdName;
    data['comp_Name'] = compName;
    data['branch_Name'] = branchName;
    data['dept_Name'] = deptName;
    data['desig_Name'] = desigName;
    data['cmp_Name'] = cmpName;
    data['cmp_Address'] = cmpAddress;
    data['p_From_Date'] = pFromDate;
    data['p_To_Date'] = pToDate;
    data['branch_Id'] = branchId;
    data['type_Name'] = typeName;
    data['desig_Dis_No'] = desigDisNo;
    data['vertical_Name'] = verticalName;
    data['subVertical_Name'] = subVerticalName;
    data['subBranch_Name'] = subBranchName;
    data['leave_Code'] = leaveCode;
    data['gender'] = gender;
    return data;
  }

  @override
  String toString() {
    return 'Data(cmpID: $cmpID, empID: $empID, leaveType: $leaveType, leaveClosing: $leaveClosing)';
  }
}
