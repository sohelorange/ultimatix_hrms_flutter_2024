class RelationshipResponse {
  bool? status;
  int? code;
  String? message;
  List<RelationshipModel>? data;

  RelationshipResponse({this.status, this.code, this.message, this.data});

  RelationshipResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RelationshipModel>[];
      json['data'].forEach((v) {
        data!.add(RelationshipModel.fromJson(v));
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

class RelationshipModel {
  int? relationshipID;
  String? relationship;

  RelationshipModel({this.relationshipID, this.relationship});

  RelationshipModel.fromJson(Map<String, dynamic> json) {
    relationshipID = json['Relationship_ID'];
    relationship = json['Relationship'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Relationship_ID'] = relationshipID;
    data['Relationship'] = relationship;
    return data;
  }
}
