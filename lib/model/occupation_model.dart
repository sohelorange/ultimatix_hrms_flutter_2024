class OccupationResponse {
  bool? status;
  int? code;
  String? message;
  List<OccupationModel>? data;

  OccupationResponse({this.status, this.code, this.message, this.data});

  OccupationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OccupationModel>[];
      json['data'].forEach((v) {
        data!.add(OccupationModel.fromJson(v));
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

class OccupationModel {
  int? oID;
  String? occupationName;

  OccupationModel({this.oID, this.occupationName});

  OccupationModel.fromJson(Map<String, dynamic> json) {
    oID = json['O_ID'];
    occupationName = json['Occupation_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['O_ID'] = oID;
    data['Occupation_Name'] = occupationName;
    return data;
  }
}
