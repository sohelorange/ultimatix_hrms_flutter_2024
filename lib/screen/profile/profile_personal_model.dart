class ProfilePersonalModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  ProfilePersonalModel({this.status, this.code, this.message, this.data});

  ProfilePersonalModel.fromJson(Map<String, dynamic> json) {
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
  EmployeeDetails? employeeDetails;
  List<AllowanceDatas>? allowanceDatas;
  List<Assets>? assets;

  Data({this.employeeDetails, this.allowanceDatas, this.assets});

  Data.fromJson(Map<String, dynamic> json) {
    employeeDetails = json['employeeDetails'] != null
        ? EmployeeDetails.fromJson(json['employeeDetails'])
        : null;
    if (json['allowanceDatas'] != null) {
      allowanceDatas = <AllowanceDatas>[];
      json['allowanceDatas'].forEach((v) {
        allowanceDatas!.add(AllowanceDatas.fromJson(v));
      });
    }
    if (json['assets'] != null) {
      assets = <Assets>[];
      json['assets'].forEach((v) {
        assets!.add(Assets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employeeDetails != null) {
      data['employeeDetails'] = employeeDetails!.toJson();
    }
    if (allowanceDatas != null) {
      data['allowanceDatas'] = allowanceDatas!.map((v) => v.toJson()).toList();
    }
    if (assets != null) {
      data['assets'] = assets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeDetails {
  int? empID;
  int? cmpID;
  String? empCode;
  String? empAnnivarsaryDate;
  String? empFullNameNew;
  String? dateOfJoin;
  String? gender;
  int? deptID;
  String? deptName;
  int? grdID;
  String? grdName;
  int? desigId;
  String? desigName;
  int? branchID;
  String? branchName;
  String? workTelNo;
  String? mobileNo;
  String? empFullNameSuperior;
  String? workEmail;
  String? street1;
  String? city;
  String? state;
  String? zipCode;
  String? homeTelNo;
  String? mobileNo1;
  String? otherEmail;
  String? imageName;
  String? imagePath;
  String? locName;
  String? bankName;
  String? bankBranchName;
  String? fatherName;
  String? dob;
  String? incBankACNo;
  String? ifscCode;
  String? panNo;
  String? aadharCardNo;
  String? uaNNo;
  String? bloodGroup;
  String? esiCNo;
  int? empSuperior;
  int? passwordEnableValidation;
  int? minChar;
  int? upperChar;
  int? lowerChar;
  int? isDigit;
  int? specialChar;
  int? passExpireDays;
  String? passExpireDate;
  int? reminderDays;
  String? passwordFormat;
  String? mailserver;
  int? mailserveRPORT;
  String? mailserveRUSERNAME;
  String? mailserveRPASSWORD;
  String? ssl;
  String? mailserveRDISPLAYNAME;
  String? froMEMAIL;
  String? recipient;
  int? feedbackDays;
  String? maritalStatus;
  String? empFullName;
  int? empPT;
  String? city1;
  String? state1;
  String? zipCode1;
  String? mobileNo2;
  String? workTelNo1;
  String? supMobileNo;
  String? workEmail1;
  String? otherEmail1;

  EmployeeDetails(
      {this.empID,
      this.cmpID,
      this.empCode,
      this.empAnnivarsaryDate,
      this.empFullNameNew,
      this.dateOfJoin,
      this.gender,
      this.deptID,
      this.deptName,
      this.grdID,
      this.grdName,
      this.desigId,
      this.desigName,
      this.branchID,
      this.branchName,
      this.workTelNo,
      this.mobileNo,
      this.empFullNameSuperior,
      this.workEmail,
      this.street1,
      this.city,
      this.state,
      this.zipCode,
      this.homeTelNo,
      this.mobileNo1,
      this.otherEmail,
      this.imageName,
      this.imagePath,
      this.locName,
      this.bankName,
      this.bankBranchName,
      this.fatherName,
      this.dob,
      this.incBankACNo,
      this.ifscCode,
      this.panNo,
      this.aadharCardNo,
      this.uaNNo,
      this.bloodGroup,
      this.esiCNo,
      this.empSuperior,
      this.passwordEnableValidation,
      this.minChar,
      this.upperChar,
      this.lowerChar,
      this.isDigit,
      this.specialChar,
      this.passExpireDays,
      this.passExpireDate,
      this.reminderDays,
      this.passwordFormat,
      this.mailserver,
      this.mailserveRPORT,
      this.mailserveRUSERNAME,
      this.mailserveRPASSWORD,
      this.ssl,
      this.mailserveRDISPLAYNAME,
      this.froMEMAIL,
      this.recipient,
      this.feedbackDays,
      this.maritalStatus,
      this.empFullName,
      this.empPT,
      this.city1,
      this.state1,
      this.zipCode1,
      this.mobileNo2,
      this.workTelNo1,
      this.supMobileNo,
      this.workEmail1,
      this.otherEmail1});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    empID = json['emp_ID'];
    cmpID = json['cmp_ID'];
    empCode = json['emp_code'];
    empAnnivarsaryDate = json['emp_Annivarsary_Date'];
    empFullNameNew = json['emp_Full_Name_new'];
    dateOfJoin = json['date_Of_Join'];
    gender = json['gender'];
    deptID = json['dept_ID'];
    deptName = json['dept_Name'];
    grdID = json['grd_ID'];
    grdName = json['grd_Name'];
    desigId = json['desig_Id'];
    desigName = json['desig_Name'];
    branchID = json['branch_ID'];
    branchName = json['branch_Name'];
    workTelNo = json['work_Tel_No'];
    mobileNo = json['mobile_No'];
    empFullNameSuperior = json['emp_Full_Name_Superior'];
    workEmail = json['work_Email'];
    street1 = json['street_1'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    homeTelNo = json['home_Tel_no'];
    mobileNo1 = json['mobile_No1'];
    otherEmail = json['other_Email'];
    imageName = json['image_Name'];
    imagePath = json['image_Path'];
    locName = json['loc_name'];
    bankName = json['bank_Name'];
    bankBranchName = json['bank_Branch_Name'];
    fatherName = json['father_name'];
    dob = json['dob'];
    incBankACNo = json['inc_Bank_AC_No'];
    ifscCode = json['ifsc_Code'];
    panNo = json['pan_No'];
    aadharCardNo = json['aadhar_Card_No'];
    uaNNo = json['uaN_No'];
    bloodGroup = json['blood_Group'];
    esiCNo = json['esiC_No'];
    empSuperior = json['emp_Superior'];
    passwordEnableValidation = json['passwordEnableValidation'];
    minChar = json['minChar'];
    upperChar = json['upperChar'];
    lowerChar = json['lowerChar'];
    isDigit = json['isDigit'];
    specialChar = json['specialChar'];
    passExpireDays = json['passExpireDays'];
    passExpireDate = json['passExpireDate'];
    reminderDays = json['reminderDays'];
    passwordFormat = json['passwordFormat'];
    mailserver = json['mailserver'];
    mailserveRPORT = json['mailserveR_PORT'];
    mailserveRUSERNAME = json['mailserveR_USERNAME'];
    mailserveRPASSWORD = json['mailserveR_PASSWORD'];
    ssl = json['ssl'];
    mailserveRDISPLAYNAME = json['mailserveR_DISPLAYNAME'];
    froMEMAIL = json['froM_EMAIL'];
    recipient = json['recipient'];
    feedbackDays = json['feedbackDays'];
    maritalStatus = json['marital_Status'];
    empFullName = json['emp_Full_Name'];
    empPT = json['emp_PT'];
    city1 = json['city1'];
    state1 = json['state1'];
    zipCode1 = json['zip_code1'];
    mobileNo2 = json['mobile_No2'];
    workTelNo1 = json['work_Tel_No1'];
    supMobileNo = json['sup_Mobile_No'];
    workEmail1 = json['work_Email1'];
    otherEmail1 = json['other_Email1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emp_ID'] = empID;
    data['cmp_ID'] = cmpID;
    data['emp_code'] = empCode;
    data['emp_Annivarsary_Date'] = empAnnivarsaryDate;
    data['emp_Full_Name_new'] = empFullNameNew;
    data['date_Of_Join'] = dateOfJoin;
    data['gender'] = gender;
    data['dept_ID'] = deptID;
    data['dept_Name'] = deptName;
    data['grd_ID'] = grdID;
    data['grd_Name'] = grdName;
    data['desig_Id'] = desigId;
    data['desig_Name'] = desigName;
    data['branch_ID'] = branchID;
    data['branch_Name'] = branchName;
    data['work_Tel_No'] = workTelNo;
    data['mobile_No'] = mobileNo;
    data['emp_Full_Name_Superior'] = empFullNameSuperior;
    data['work_Email'] = workEmail;
    data['street_1'] = street1;
    data['city'] = city;
    data['state'] = state;
    data['zip_code'] = zipCode;
    data['home_Tel_no'] = homeTelNo;
    data['mobile_No1'] = mobileNo1;
    data['other_Email'] = otherEmail;
    data['image_Name'] = imageName;
    data['image_Path'] = imagePath;
    data['loc_name'] = locName;
    data['bank_Name'] = bankName;
    data['bank_Branch_Name'] = bankBranchName;
    data['father_name'] = fatherName;
    data['dob'] = dob;
    data['inc_Bank_AC_No'] = incBankACNo;
    data['ifsc_Code'] = ifscCode;
    data['pan_No'] = panNo;
    data['aadhar_Card_No'] = aadharCardNo;
    data['uaN_No'] = uaNNo;
    data['blood_Group'] = bloodGroup;
    data['esiC_No'] = esiCNo;
    data['emp_Superior'] = empSuperior;
    data['passwordEnableValidation'] = passwordEnableValidation;
    data['minChar'] = minChar;
    data['upperChar'] = upperChar;
    data['lowerChar'] = lowerChar;
    data['isDigit'] = isDigit;
    data['specialChar'] = specialChar;
    data['passExpireDays'] = passExpireDays;
    data['passExpireDate'] = passExpireDate;
    data['reminderDays'] = reminderDays;
    data['passwordFormat'] = passwordFormat;
    data['mailserver'] = mailserver;
    data['mailserveR_PORT'] = mailserveRPORT;
    data['mailserveR_USERNAME'] = mailserveRUSERNAME;
    data['mailserveR_PASSWORD'] = mailserveRPASSWORD;
    data['ssl'] = ssl;
    data['mailserveR_DISPLAYNAME'] = mailserveRDISPLAYNAME;
    data['froM_EMAIL'] = froMEMAIL;
    data['recipient'] = recipient;
    data['feedbackDays'] = feedbackDays;
    data['marital_Status'] = maritalStatus;
    data['emp_Full_Name'] = empFullName;
    data['emp_PT'] = empPT;
    data['city1'] = city1;
    data['state1'] = state1;
    data['zip_code1'] = zipCode1;
    data['mobile_No2'] = mobileNo2;
    data['work_Tel_No1'] = workTelNo1;
    data['sup_Mobile_No'] = supMobileNo;
    data['work_Email1'] = workEmail1;
    data['other_Email1'] = otherEmail1;
    return data;
  }
}

class AllowanceDatas {
  String? aDNAME;
  String? eADFLAG;
  String? eADMODE;
  double? eADPERCENTAGE;
  double? eADAMOUNT;

  AllowanceDatas(
      {this.aDNAME,
      this.eADFLAG,
      this.eADMODE,
      this.eADPERCENTAGE,
      this.eADAMOUNT});

  AllowanceDatas.fromJson(Map<String, dynamic> json) {
    aDNAME = json['aD_NAME'];
    eADFLAG = json['e_AD_FLAG'];
    eADMODE = json['e_AD_MODE'];
    eADPERCENTAGE = json['e_AD_PERCENTAGE'];
    eADAMOUNT = json['e_AD_AMOUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aD_NAME'] = aDNAME;
    data['e_AD_FLAG'] = eADFLAG;
    data['e_AD_MODE'] = eADMODE;
    data['e_AD_PERCENTAGE'] = eADPERCENTAGE;
    data['e_AD_AMOUNT'] = eADAMOUNT;
    return data;
  }
}

class Assets {
  String? assetName;
  String? brandName;
  String? vendor;
  String? typeOfAsset;
  String? modelName;
  String? serialNo;
  String? assetCode;
  int? empID;
  int? cmpID;
  String? returnDate;
  String? type;
  String? allocationDate;

  Assets(
      {this.assetName,
      this.brandName,
      this.vendor,
      this.typeOfAsset,
      this.modelName,
      this.serialNo,
      this.assetCode,
      this.empID,
      this.cmpID,
      this.returnDate,
      this.type,
      this.allocationDate});

  Assets.fromJson(Map<String, dynamic> json) {
    assetName = json['asset_Name'];
    brandName = json['brand_Name'];
    vendor = json['vendor'];
    typeOfAsset = json['type_Of_Asset'];
    modelName = json['model_Name'];
    serialNo = json['serial_No'];
    assetCode = json['asset_Code'];
    empID = json['emp_ID'];
    cmpID = json['cmp_ID'];
    returnDate = json['return_Date'];
    type = json['type'];
    allocationDate = json['allocation_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asset_Name'] = assetName;
    data['brand_Name'] = brandName;
    data['vendor'] = vendor;
    data['type_Of_Asset'] = typeOfAsset;
    data['model_Name'] = modelName;
    data['serial_No'] = serialNo;
    data['asset_Code'] = assetCode;
    data['emp_ID'] = empID;
    data['cmp_ID'] = cmpID;
    data['return_Date'] = returnDate;
    data['type'] = type;
    data['allocation_Date'] = allocationDate;
    return data;
  }
}
