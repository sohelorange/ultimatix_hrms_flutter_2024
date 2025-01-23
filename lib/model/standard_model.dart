class StandardResponse {
  bool? status;
  int? code;
  String? message;
  List<StandardModel>? data;

  StandardResponse({this.status, this.code, this.message, this.data});

  StandardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StandardModel>[];
      json['data'].forEach((v) {
        data!.add(StandardModel.fromJson(v));
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

class StandardModel {
  int? sID;
  String? standardName;

  StandardModel({this.sID, this.standardName});

  StandardModel.fromJson(Map<String, dynamic> json) {
    sID = json['S_ID'];
    standardName = json['StandardName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['S_ID'] = sID;
    data['StandardName'] = standardName;
    return data;
  }
}
