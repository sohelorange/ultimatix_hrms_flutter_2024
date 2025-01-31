class ProfileFavoriteModel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  ProfileFavoriteModel({this.status, this.code, this.message, this.data});

  ProfileFavoriteModel.fromJson(Map<String, dynamic> json) {
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
  String? alphaEmpCode;
  String? empFavSportId;
  String? empFavSportName;
  String? empHobbyId;
  String? empHobbyName;
  String? empFavFood;
  String? empFavRestro;
  String? empFavTrvDestination;
  String? empFavFestival;
  String? empFavSportPerson;
  String? empFavSinger;

  Data(
      {this.empID,
      this.alphaEmpCode,
      this.empFavSportId,
      this.empFavSportName,
      this.empHobbyId,
      this.empHobbyName,
      this.empFavFood,
      this.empFavRestro,
      this.empFavTrvDestination,
      this.empFavFestival,
      this.empFavSportPerson,
      this.empFavSinger});

  Data.fromJson(Map<String, dynamic> json) {
    empID = json['Emp_ID'];
    alphaEmpCode = json['Alpha_Emp_Code'];
    empFavSportId = json['Emp_Fav_Sport_id'];
    empFavSportName = json['Emp_Fav_Sport_Name'];
    empHobbyId = json['Emp_Hobby_id'];
    empHobbyName = json['Emp_Hobby_Name'];
    empFavFood = json['Emp_Fav_Food'];
    empFavRestro = json['Emp_Fav_Restro'];
    empFavTrvDestination = json['Emp_Fav_Trv_Destination'];
    empFavFestival = json['Emp_Fav_Festival'];
    empFavSportPerson = json['Emp_Fav_SportPerson'];
    empFavSinger = json['Emp_Fav_Singer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Emp_ID'] = empID;
    data['Alpha_Emp_Code'] = alphaEmpCode;
    data['Emp_Fav_Sport_id'] = empFavSportId;
    data['Emp_Fav_Sport_Name'] = empFavSportName;
    data['Emp_Hobby_id'] = empHobbyId;
    data['Emp_Hobby_Name'] = empHobbyName;
    data['Emp_Fav_Food'] = empFavFood;
    data['Emp_Fav_Restro'] = empFavRestro;
    data['Emp_Fav_Trv_Destination'] = empFavTrvDestination;
    data['Emp_Fav_Festival'] = empFavFestival;
    data['Emp_Fav_SportPerson'] = empFavSportPerson;
    data['Emp_Fav_Singer'] = empFavSinger;
    return data;
  }
}
