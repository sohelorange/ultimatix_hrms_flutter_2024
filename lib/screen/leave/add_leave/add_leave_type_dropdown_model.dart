class AddLeaveTypeDropdownModel {
  bool? status;
  int? code;
  String? message;
  List<LeaveData>? data;

  AddLeaveTypeDropdownModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  AddLeaveTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LeaveData>[];
      json['data'].forEach((v) {
        data!.add(LeaveData.fromJson(v));
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
    return 'AddLeaveTypeDropdownModel(status: $status, code: $code, message: $message, data: $data)';
  }
}

class LeaveData {
  final int leaveID;
  final String leaveName;
  final String leaveCode;
  final int attachmentDays;
  final int isDocumentRequired;
  final String leaveType;
  final int applyHourly;
  final String multiBranchID;

  LeaveData({
    required this.leaveID,
    required this.leaveName,
    required this.leaveCode,
    required this.attachmentDays,
    required this.isDocumentRequired,
    required this.leaveType,
    required this.applyHourly,
    required this.multiBranchID,
  });

  factory LeaveData.fromJson(Map<String, dynamic> json) {
    return LeaveData(
      leaveID: json['leave_ID'],
      leaveName: json['leave_Name'],
      leaveCode: json['leave_Code'],
      attachmentDays: json['attachment_Days'],
      isDocumentRequired: json['is_Document_Required'],
      leaveType: json['leave_Type'],
      applyHourly: json['apply_Hourly'],
      multiBranchID: json['multi_Branch_ID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'leave_ID': leaveID,
      'leave_Name': leaveName,
      'leave_Code': leaveCode,
      'attachment_Days': attachmentDays,
      'is_Document_Required': isDocumentRequired,
      'leave_Type': leaveType,
      'apply_Hourly': applyHourly,
      'multi_Branch_ID': multiBranchID,
    };
  }

  @override
  String toString() {
    return 'LeaveData(leaveID: $leaveID, leaveName: $leaveName, leaveCode: $leaveCode, attachmentDays: $attachmentDays,isDocumentRequired:$isDocumentRequired,leaveType:$leaveType,applyHourly:$applyHourly,multiBranchID:$multiBranchID)';
  }
}
