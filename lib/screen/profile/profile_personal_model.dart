class ProfilePersonalModel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  ProfilePersonalModel({this.status, this.code, this.message, this.data});

  ProfilePersonalModel.fromJson(Map<String, dynamic> json) {
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
  String? otherEmail;
  String? imageName;
  String? imagePath;
  String? locName;

  String? bankName;
  String? bankBranchName;
  String? fatherName;
  String? dOB;

  String? incBankACNo;
  String? ifscCode;
  String? panNo;
  String? aadharCardNo;
  String? uANNo;
  String? bloodGroup;
  String? eSICNo;
  int? empSuperior;
  int? passwordEnableValidation;
  int? minChar;
  int? upperChar;
  int? lowerChar;
  int? iSDigit;
  int? specialChar;
  int? passExpireDays;
  String? passExpireDate;
  int? reminderDays;
  String? passwordFormat;
  String? mAILSERVER;
  int? mAILSERVERPORT;
  String? mAILSERVERUSERNAME;
  String? mAILSERVERPASSWORD;
  String? sSL;
  String? mAILSERVERDISPLAYNAME;
  String? fROMEMAIL;
  String? rECIPIENT;
  int? feedbackDays;
  String? maritalStatus;
  String? empFullName;
  int? empPT;
  String? supMobileNo;

  Data(
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
      this.otherEmail,
      this.imageName,
      this.imagePath,
      this.locName,
      this.bankName,
      this.bankBranchName,
      this.fatherName,
      this.dOB,
      this.incBankACNo,
      this.ifscCode,
      this.panNo,
      this.aadharCardNo,
      this.uANNo,
      this.bloodGroup,
      this.eSICNo,
      this.empSuperior,
      this.passwordEnableValidation,
      this.minChar,
      this.upperChar,
      this.lowerChar,
      this.iSDigit,
      this.specialChar,
      this.passExpireDays,
      this.passExpireDate,
      this.reminderDays,
      this.passwordFormat,
      this.mAILSERVER,
      this.mAILSERVERPORT,
      this.mAILSERVERUSERNAME,
      this.mAILSERVERPASSWORD,
      this.sSL,
      this.mAILSERVERDISPLAYNAME,
      this.fROMEMAIL,
      this.rECIPIENT,
      this.feedbackDays,
      this.maritalStatus,
      this.empFullName,
      this.empPT,
      this.supMobileNo});

  Data.fromJson(Map<String, dynamic> json) {
    empID = json['Emp_ID'];
    cmpID = json['Cmp_ID'];
    empCode = json['Emp_code'];
    empAnnivarsaryDate = json['Emp_Annivarsary_Date'];
    empFullNameNew = json['Emp_Full_Name_new'];
    dateOfJoin = json['Date_Of_Join'];
    gender = json['Gender'];
    deptID = json['Dept_ID'];
    deptName = json['Dept_Name'];
    grdID = json['Grd_ID'];
    grdName = json['Grd_Name'];
    desigId = json['Desig_Id'];
    desigName = json['Desig_Name'];
    branchID = json['Branch_ID'];
    branchName = json['Branch_Name'];
    workTelNo = json['Work_Tel_No'];
    mobileNo = json['Mobile_No'];
    empFullNameSuperior = json['Emp_Full_Name_Superior'];
    workEmail = json['Work_Email'];
    street1 = json['Street_1'];
    city = json['City'];
    state = json['State'];
    zipCode = json['Zip_code'];
    homeTelNo = json['Home_Tel_no'];
    otherEmail = json['Other_Email'];
    imageName = json['Image_Name'];
    imagePath = json['Image_Path'];
    locName = json['Loc_name'];
    bankName = json['Bank_Name'];
    bankBranchName = json['Bank_Branch_Name'];
    fatherName = json['Father_name'];
    dOB = json['DOB'];
    incBankACNo = json['Inc_Bank_AC_No'];
    ifscCode = json['Ifsc_Code'];
    panNo = json['Pan_No'];
    aadharCardNo = json['Aadhar_Card_No'];
    uANNo = json['UAN_No'];
    bloodGroup = json['Blood_Group'];
    eSICNo = json['ESIC_No'];
    empSuperior = json['Emp_Superior'];
    passwordEnableValidation = json['PasswordEnableValidation'];
    minChar = json['MinChar'];
    upperChar = json['UpperChar'];
    lowerChar = json['LowerChar'];
    iSDigit = json['ISDigit'];
    specialChar = json['SpecialChar'];
    passExpireDays = json['PassExpireDays'];
    passExpireDate = json['PassExpireDate'];
    reminderDays = json['ReminderDays'];
    passwordFormat = json['PasswordFormat'];
    mAILSERVER = json['MAILSERVER'];
    mAILSERVERPORT = json['MAILSERVER_PORT'];
    mAILSERVERUSERNAME = json['MAILSERVER_USERNAME'];
    mAILSERVERPASSWORD = json['MAILSERVER_PASSWORD'];
    sSL = json['SSL'];
    mAILSERVERDISPLAYNAME = json['MAILSERVER_DISPLAYNAME'];
    fROMEMAIL = json['FROM_EMAIL'];
    rECIPIENT = json['RECIPIENT'];
    feedbackDays = json['FeedbackDays'];
    maritalStatus = json['Marital_Status'];
    empFullName = json['Emp_Full_Name'];
    empPT = json['Emp_PT'];
    supMobileNo = json['Sup_Mobile_No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Emp_ID'] = empID;
    data['Cmp_ID'] = cmpID;
    data['Emp_code'] = empCode;
    data['Emp_Annivarsary_Date'] = empAnnivarsaryDate;
    data['Emp_Full_Name_new'] = empFullNameNew;
    data['Date_Of_Join'] = dateOfJoin;
    data['Gender'] = gender;
    data['Dept_ID'] = deptID;
    data['Dept_Name'] = deptName;
    data['Grd_ID'] = grdID;
    data['Grd_Name'] = grdName;
    data['Desig_Id'] = desigId;
    data['Desig_Name'] = desigName;
    data['Branch_ID'] = branchID;
    data['Branch_Name'] = branchName;
    data['Work_Tel_No'] = workTelNo;
    data['Mobile_No'] = mobileNo;
    data['Emp_Full_Name_Superior'] = empFullNameSuperior;
    data['Work_Email'] = workEmail;
    data['Street_1'] = street1;
    data['City'] = city;
    data['State'] = state;
    data['Zip_code'] = zipCode;
    data['Home_Tel_no'] = homeTelNo;
    data['Other_Email'] = otherEmail;
    data['Image_Name'] = imageName;
    data['Image_Path'] = imagePath;
    data['Loc_name'] = locName;
    data['Bank_Name'] = bankName;
    data['Bank_Branch_Name'] = bankBranchName;
    data['Father_name'] = fatherName;
    data['DOB'] = dOB;
    data['Inc_Bank_AC_No'] = incBankACNo;
    data['Ifsc_Code'] = ifscCode;
    data['Pan_No'] = panNo;
    data['Aadhar_Card_No'] = aadharCardNo;
    data['UAN_No'] = uANNo;
    data['Blood_Group'] = bloodGroup;
    data['ESIC_No'] = eSICNo;
    data['Emp_Superior'] = empSuperior;
    data['PasswordEnableValidation'] = passwordEnableValidation;
    data['MinChar'] = minChar;
    data['UpperChar'] = upperChar;
    data['LowerChar'] = lowerChar;
    data['ISDigit'] = iSDigit;
    data['SpecialChar'] = specialChar;
    data['PassExpireDays'] = passExpireDays;
    data['PassExpireDate'] = passExpireDate;
    data['ReminderDays'] = reminderDays;
    data['PasswordFormat'] = passwordFormat;
    data['MAILSERVER'] = mAILSERVER;
    data['MAILSERVER_PORT'] = mAILSERVERPORT;
    data['MAILSERVER_USERNAME'] = mAILSERVERUSERNAME;
    data['MAILSERVER_PASSWORD'] = mAILSERVERPASSWORD;
    data['SSL'] = sSL;
    data['MAILSERVER_DISPLAYNAME'] = mAILSERVERDISPLAYNAME;
    data['FROM_EMAIL'] = fROMEMAIL;
    data['RECIPIENT'] = rECIPIENT;
    data['FeedbackDays'] = feedbackDays;
    data['Marital_Status'] = maritalStatus;
    data['Emp_Full_Name'] = empFullName;
    data['Emp_PT'] = empPT;
    data['Sup_Mobile_No'] = supMobileNo;
    return data;
  }
}
