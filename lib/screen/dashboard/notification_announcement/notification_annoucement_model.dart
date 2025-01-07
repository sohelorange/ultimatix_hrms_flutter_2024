class NotificationAnnouncementModel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  NotificationAnnouncementModel(
      {this.status, this.code, this.message, this.data});

  NotificationAnnouncementModel.fromJson(Map<String, dynamic> json) {
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
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Data {
  int? docID;
  String? docTitle;
  String? description;
  String? docName;
  String? docTooltip;
  String? docFromDate;
  String? docToDate;
  int? empID;
  int? deptId;
  int? isMobileRead;
  String? docType;
  String? docPath;

  Data(
      {docID,
      docTitle,
      description,
      docName,
      docTooltip,
      docFromDate,
      docToDate,
      empID,
      deptId,
      isMobileRead,
      docType,
      docPath});

  Data.fromJson(Map<String, dynamic> json) {
    docID = json['Doc_ID'];
    docTitle = json['Doc_Title'];
    description = json['Description'];
    docName = json['Doc_Name'];
    docTooltip = json['Doc_Tooltip'];
    docFromDate = json['Doc_FromDate'];
    docToDate = json['Doc_ToDate'];
    empID = json['Emp_ID'];
    deptId = json['Dept_Id'];
    isMobileRead = json['Is_Mobile_Read'];
    docType = json['DocType'];
    docPath = json['DocPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Doc_ID'] = docID;
    data['Doc_Title'] = docTitle;
    data['Description'] = description;
    data['Doc_Name'] = docName;
    data['Doc_Tooltip'] = docTooltip;
    data['Doc_FromDate'] = docFromDate;
    data['Doc_ToDate'] = docToDate;
    data['Emp_ID'] = empID;
    data['Dept_Id'] = deptId;
    data['Is_Mobile_Read'] = isMobileRead;
    data['DocType'] = docType;
    data['DocPath'] = docPath;
    return data;
  }
}
