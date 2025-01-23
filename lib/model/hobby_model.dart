class HobbyResponse {
  bool? status;
  int? code;
  String? message;
  List<HobbyModel>? data;

  HobbyResponse({this.status, this.code, this.message, this.data});

  HobbyResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HobbyModel>[];
      json['data'].forEach((v) {
        data!.add(HobbyModel.fromJson(v));
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

class HobbyModel {
  int? hID;
  String? hobbyName;

  HobbyModel({this.hID, this.hobbyName});

  HobbyModel.fromJson(Map<String, dynamic> json) {
    hID = json['H_ID'];
    hobbyName = json['HobbyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['H_ID'] = hID;
    data['HobbyName'] = hobbyName;
    return data;
  }
}
