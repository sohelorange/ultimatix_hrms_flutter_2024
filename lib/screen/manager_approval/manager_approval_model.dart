class ManagerApprovalModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  ManagerApprovalModel({this.status, this.code, this.message, this.data});

  ManagerApprovalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? leaveAppCnt;
  int? lateComer;
  int? leaveCancel;
  int? compOffApprovals;
  int? exitApproval;
  int? ticketApprovals;
  int? claimAppCnt;
  int? travelAppCnt;

  Data(
      {this.leaveAppCnt,
      this.lateComer,
      this.leaveCancel,
      this.compOffApprovals,
      this.exitApproval,
      this.ticketApprovals,
      this.claimAppCnt,this.travelAppCnt});

  Data.fromJson(Map<String, dynamic> json) {
    leaveAppCnt = json['leaveAppCnt'];
    lateComer = json['lateComer'];
    leaveCancel = json['leaveCancel'];
    compOffApprovals = json['compOffApprovals'];
    exitApproval = json['exitApproval'];
    ticketApprovals = json['ticketApprovals'];
    claimAppCnt = json['claimAppCnt'];
    travelAppCnt = json['travelAppCnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leaveAppCnt'] = leaveAppCnt;
    data['lateComer'] = lateComer;
    data['leaveCancel'] = leaveCancel;
    data['compOffApprovals'] = compOffApprovals;
    data['exitApproval'] = exitApproval;
    data['ticketApprovals'] = ticketApprovals;
    data['claimAppCnt'] = claimAppCnt;
    data['travelAppCnt'] = travelAppCnt;
    return data;
  }
}
