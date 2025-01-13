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
  num? cAge; // Changed from int? to num?
  String? relationship;
  int? isResi;
  int? isDependant;
  String? imagePath;
  String? panCardNo;
  String? adharCardNo;
  String? height; // Changed from String? to num? to accept both int and double
  String? weight; // Changed from String? to num? to accept both int and double
  int? occupationID;
  String? hobbyID;
  String? hobbyName;
  String? depCompanyName;
  int? standardID;
  String? shcoolCollege;
  String? extraActivity;
  String? city;
  String? cDTM;
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
      this.cDTM,
      this.cmpCity,
      this.stdSpecialization,
      this.depWorkTime,
      this.requestId,
      this.requestType});

  Data.fromJson(Map<String, dynamic> json) {
    empID = json['Emp_ID'];
    rowID = json['Row_ID'];
    cmpID = json['Cmp_ID'];
    name = json['Name'];
    gender = json['Gender'];
    dateOfBirth = json['Date_Of_Birth'];
    cAge = json['C_age']; // This can be a double or int, hence num
    relationship = json['Relationship'];
    isResi = json['Is_Resi'];
    isDependant = json['Is_Dependant'];
    imagePath = json['Image_Path'];
    panCardNo = json['Pan_Card_No'];
    adharCardNo = json['Adhar_Card_No'];
    height = json['Height']; // This can be a double or int, hence num
    weight = json['Weight']; // This can be a double or int, hence num
    occupationID = json['OccupationID'];
    hobbyID = json['HobbyID'];
    hobbyName = json['HobbyName'];
    depCompanyName = json['DepCompanyName'];
    standardID = json['Standard_ID'];
    shcoolCollege = json['Shcool_College'];
    extraActivity = json['ExtraActivity'];
    city = json['City'];
    cDTM = json['CDTM'];
    cmpCity = json['CmpCity'];
    stdSpecialization = json['Std_Specialization'];
    depWorkTime = json['DepWorkTime'];
    requestId = json['Request_id'];
    requestType = json['Request_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Emp_ID'] = empID;
    data['Row_ID'] = rowID;
    data['Cmp_ID'] = cmpID;
    data['Name'] = name;
    data['Gender'] = gender;
    data['Date_Of_Birth'] = dateOfBirth;
    data['C_age'] = cAge; // This can be an int or double, hence num
    data['Relationship'] = relationship;
    data['Is_Resi'] = isResi;
    data['Is_Dependant'] = isDependant;
    data['Image_Path'] = imagePath;
    data['Pan_Card_No'] = panCardNo;
    data['Adhar_Card_No'] = adharCardNo;
    data['Height'] = height; // This can be an int or double, hence num
    data['Weight'] = weight; // This can be an int or double, hence num
    data['OccupationID'] = occupationID;
    data['HobbyID'] = hobbyID;
    data['HobbyName'] = hobbyName;
    data['DepCompanyName'] = depCompanyName;
    data['Standard_ID'] = standardID;
    data['Shcool_College'] = shcoolCollege;
    data['ExtraActivity'] = extraActivity;
    data['City'] = city;
    data['CDTM'] = cDTM;
    data['CmpCity'] = cmpCity;
    data['Std_Specialization'] = stdSpecialization;
    data['DepWorkTime'] = depWorkTime;
    data['Request_id'] = requestId;
    data['Request_type'] = requestType;
    return data;
  }
}
