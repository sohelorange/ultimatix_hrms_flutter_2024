class Leavebalancemodel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  Leavebalancemodel({this.status, this.code, this.message, this.data});

  Leavebalancemodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cmp_ID'] = this.cmpID;
    data['emp_ID'] = this.empID;
    data['for_Date'] = this.forDate;
    data['leave_Opening'] = this.leaveOpening;
    data['leave_Credit'] = this.leaveCredit;
    data['leave_Used'] = this.leaveUsed;
    data['leave_Closing'] = this.leaveClosing;
    data['leave_ID'] = this.leaveID;
    data['leave_Type'] = this.leaveType;
    data['leave_Name'] = this.leaveName;
    data['emp_Full_Name'] = this.empFullName;
    data['emp_Code'] = this.empCode;
    data['alpha_Emp_Code'] = this.alphaEmpCode;
    data['emp_First_Name'] = this.empFirstName;
    data['grd_Name'] = this.grdName;
    data['comp_Name'] = this.compName;
    data['branch_Name'] = this.branchName;
    data['dept_Name'] = this.deptName;
    data['desig_Name'] = this.desigName;
    data['cmp_Name'] = this.cmpName;
    data['cmp_Address'] = this.cmpAddress;
    data['p_From_Date'] = this.pFromDate;
    data['p_To_Date'] = this.pToDate;
    data['branch_Id'] = this.branchId;
    data['type_Name'] = this.typeName;
    data['desig_Dis_No'] = this.desigDisNo;
    data['vertical_Name'] = this.verticalName;
    data['subVertical_Name'] = this.subVerticalName;
    data['subBranch_Name'] = this.subBranchName;
    data['leave_Code'] = this.leaveCode;
    data['gender'] = this.gender;
    return data;
  }

}