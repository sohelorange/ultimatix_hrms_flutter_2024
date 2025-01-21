class ProfileFamilyModel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  ProfileFamilyModel({this.status, this.code, this.message, this.data});

  ProfileFamilyModel.fromJson(Map<String, dynamic> json) {
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
  int? empID;
  int? rowID;
  int? cmpID;
  String? name;
  String? gender;
  String? dateOfBirth;
  int? cAge;
  String? relationship;
  bool? isResi;
  bool? isDependant;
  String? imagePath;
  String? panCardNo;
  String? adharCardNo;
  String? height;
  String? weight;
  int? occupationID;
  String? hobbyID;
  String? hobbyName;
  String? depCompanyName;
  int? standardID;
  String? shcoolCollege;
  String? extraActivity;
  String? city;
  String? cdtm;
  String? cmpCity;
  String? stdSpecialization;
  String? depWorkTime;
  int? requestId;
  String? requestType;

  Data(
      {this.empID,
      this.rowID,
      this.cmpID,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.cAge,
      this.relationship,
      this.isResi,
      this.isDependant,
      this.imagePath,
      this.panCardNo,
      this.adharCardNo,
      this.height,
      this.weight,
      this.occupationID,
      this.hobbyID,
      this.hobbyName,
      this.depCompanyName,
      this.standardID,
      this.shcoolCollege,
      this.extraActivity,
      this.city,
      this.cdtm,
      this.cmpCity,
      this.stdSpecialization,
      this.depWorkTime,
      this.requestId,
      this.requestType});

  Data.fromJson(Map<String, dynamic> json) {
    empID = json['emp_ID'];
    rowID = json['row_ID'];
    cmpID = json['cmp_ID'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['date_Of_Birth'];
    cAge = json['c_age'];
    relationship = json['relationship'];
    isResi = json['is_Resi'];
    isDependant = json['is_Dependant'];
    imagePath = json['image_Path'];
    panCardNo = json['pan_Card_No'];
    adharCardNo = json['adhar_Card_No'];
    height = json['height'];
    weight = json['weight'];
    occupationID = json['occupationID'];
    hobbyID = json['hobbyID'];
    hobbyName = json['hobbyName'];
    depCompanyName = json['depCompanyName'];
    standardID = json['standard_ID'];
    shcoolCollege = json['shcool_College'];
    extraActivity = json['extraActivity'];
    city = json['city'];
    cdtm = json['cdtm'];
    cmpCity = json['cmpCity'];
    stdSpecialization = json['std_Specialization'];
    depWorkTime = json['depWorkTime'];
    requestId = json['request_id'];
    requestType = json['request_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emp_ID'] = empID;
    data['row_ID'] = rowID;
    data['cmp_ID'] = cmpID;
    data['name'] = name;
    data['gender'] = gender;
    data['date_Of_Birth'] = dateOfBirth;
    data['c_age'] = cAge;
    data['relationship'] = relationship;
    data['is_Resi'] = isResi;
    data['is_Dependant'] = isDependant;
    data['image_Path'] = imagePath;
    data['pan_Card_No'] = panCardNo;
    data['adhar_Card_No'] = adharCardNo;
    data['height'] = height;
    data['weight'] = weight;
    data['occupationID'] = occupationID;
    data['hobbyID'] = hobbyID;
    data['hobbyName'] = hobbyName;
    data['depCompanyName'] = depCompanyName;
    data['standard_ID'] = standardID;
    data['shcool_College'] = shcoolCollege;
    data['extraActivity'] = extraActivity;
    data['city'] = city;
    data['cdtm'] = cdtm;
    data['cmpCity'] = cmpCity;
    data['std_Specialization'] = stdSpecialization;
    data['depWorkTime'] = depWorkTime;
    data['request_id'] = requestId;
    data['request_type'] = requestType;
    return data;
  }
}
