class LeaveApprovalStatusModel {
  LeaveApprovalStatusModel({
    bool? status,
    num? code,
    String? message,
    Data? data,
  }) {
    _status = status;
    _code = code;
    _message = message;
    _data = data;
  }

  LeaveApprovalStatusModel.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _status;
  num? _code;
  String? _message;
  Data? _data;

  LeaveApprovalStatusModel copyWith({
    bool? status,
    num? code,
    String? message,
    Data? data,
  }) =>
      LeaveApprovalStatusModel(
        status: status ?? _status,
        code: code ?? _code,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  num? get code => _code;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// data : {"cmp_Id1":187,"cmp_Name":"MOBILE AUTOMATION TESTING","cmp_Address":"ORANGE TECHNOLAB PVT LTD - AN ISO 9001 CERTIFIED SOFTWARE COMPANYOFFICE:+91-(79)49068968 7TH FLOOR - 703  KATARIA ARCADE , B/S ADANI SCHOOL, MAKARBA - PRAHLADNAGAR CORPORATE ROAD,MAKARBA, S G ROAD,AHMEDABAD 380051.","emp_Id1":28201,"branch_Id":1109,"alpha_Emp_Code":"0060","emp_Full_Name":"Mr. AP TL QA123","scheme_Id":793,"leave":null,"scheme_Type":"Leave","scheme_Name":"AP Leave","effective_Date":"2024-06-01T00:00:00","rpt_Level":null,"rpt_Mgr_1":"0058-Mr. AP BM","rpt_Mgr_2":"0041-Mr. Ravi Dhote","rpt_Mgr_3":"0042-Mr. Amit Gupta","rpt_Mgr_4":"","rpt_Mgr_5":"","rpt_Mgr_6":"","rpt_Mgr_7":"","rpt_Mgr_8":"","emp_First_Name":null,"max_Level":3}
/// data1 : [{"application_Date":"01/08/2024","application_Status":"P","rpt_Level":0,"application_Date1":null,"name":"0060-Mr. AP TL QA123"}]

class Data {
  Data({
    DataResponse? dataResponse,
    List<Data1>? data1,
  }) {
    _dataResponse = dataResponse;
    _data1 = data1;
  }

  Data.fromJson(dynamic json) {
    _dataResponse =
        json['data'] != null ? DataResponse.fromJson(json['data']) : null;
    if (json['data1'] != null) {
      _data1 = [];
      json['data1'].forEach((v) {
        _data1?.add(Data1.fromJson(v));
      });
    }
  }

  DataResponse? _dataResponse;
  List<Data1>? _data1;

  Data copyWith({
    DataResponse? dataResponse,
    List<Data1>? data1,
  }) =>
      Data(
        dataResponse: dataResponse ?? _dataResponse,
        data1: data1 ?? _data1,
      );

  DataResponse? get dataResponse => _dataResponse;

  List<Data1>? get data1 => _data1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_dataResponse != null) {
      map['data'] = _dataResponse?.toJson();
    }
    if (_data1 != null) {
      map['data1'] = _data1?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// application_Date : "01/08/2024"
/// application_Status : "P"
/// rpt_Level : 0
/// application_Date1 : null
/// name : "0060-Mr. AP TL QA123"

class Data1 {
  Data1({
    String? applicationDate,
    String? applicationStatus,
    num? rptLevel,
    dynamic applicationDate1,
    String? name,
  }) {
    _applicationDate = applicationDate;
    _applicationStatus = applicationStatus;
    _rptLevel = rptLevel;
    _applicationDate1 = applicationDate1;
    _name = name;
  }

  Data1.fromJson(dynamic json) {
    _applicationDate = json['application_Date'];
    _applicationStatus = json['application_Status'];
    _rptLevel = json['rpt_Level'];
    _applicationDate1 = json['application_Date1'];
    _name = json['name'];
  }

  String? _applicationDate;
  String? _applicationStatus;
  num? _rptLevel;
  dynamic _applicationDate1;
  String? _name;

  Data1 copyWith({
    String? applicationDate,
    String? applicationStatus,
    num? rptLevel,
    dynamic applicationDate1,
    String? name,
  }) =>
      Data1(
        applicationDate: applicationDate ?? _applicationDate,
        applicationStatus: applicationStatus ?? _applicationStatus,
        rptLevel: rptLevel ?? _rptLevel,
        applicationDate1: applicationDate1 ?? _applicationDate1,
        name: name ?? _name,
      );

  String? get applicationDate => _applicationDate;

  String? get applicationStatus => _applicationStatus;

  num? get rptLevel => _rptLevel;

  dynamic get applicationDate1 => _applicationDate1;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['application_Date'] = _applicationDate;
    map['application_Status'] = _applicationStatus;
    map['rpt_Level'] = _rptLevel;
    map['application_Date1'] = _applicationDate1;
    map['name'] = _name;
    return map;
  }
}

/// cmp_Id1 : 187
/// cmp_Name : "MOBILE AUTOMATION TESTING"
/// cmp_Address : "ORANGE TECHNOLAB PVT LTD - AN ISO 9001 CERTIFIED SOFTWARE COMPANYOFFICE:+91-(79)49068968 7TH FLOOR - 703  KATARIA ARCADE , B/S ADANI SCHOOL, MAKARBA - PRAHLADNAGAR CORPORATE ROAD,MAKARBA, S G ROAD,AHMEDABAD 380051."
/// emp_Id1 : 28201
/// branch_Id : 1109
/// alpha_Emp_Code : "0060"
/// emp_Full_Name : "Mr. AP TL QA123"
/// scheme_Id : 793
/// leave : null
/// scheme_Type : "Leave"
/// scheme_Name : "AP Leave"
/// effective_Date : "2024-06-01T00:00:00"
/// rpt_Level : null
/// rpt_Mgr_1 : "0058-Mr. AP BM"
/// rpt_Mgr_2 : "0041-Mr. Ravi Dhote"
/// rpt_Mgr_3 : "0042-Mr. Amit Gupta"
/// rpt_Mgr_4 : ""
/// rpt_Mgr_5 : ""
/// rpt_Mgr_6 : ""
/// rpt_Mgr_7 : ""
/// rpt_Mgr_8 : ""
/// emp_First_Name : null
/// max_Level : 3

class DataResponse {
  DataResponse({
    num? cmpId1,
    String? cmpName,
    String? cmpAddress,
    num? empId1,
    num? branchId,
    String? alphaEmpCode,
    String? empFullName,
    num? schemeId,
    dynamic leave,
    String? schemeType,
    String? schemeName,
    String? effectiveDate,
    dynamic rptLevel,
    String? rptMgr1,
    String? rptMgr2,
    String? rptMgr3,
    String? rptMgr4,
    String? rptMgr5,
    String? rptMgr6,
    String? rptMgr7,
    String? rptMgr8,
    dynamic empFirstName,
    num? maxLevel,
  }) {
    _cmpId1 = cmpId1;
    _cmpName = cmpName;
    _cmpAddress = cmpAddress;
    _empId1 = empId1;
    _branchId = branchId;
    _alphaEmpCode = alphaEmpCode;
    _empFullName = empFullName;
    _schemeId = schemeId;
    _leave = leave;
    _schemeType = schemeType;
    _schemeName = schemeName;
    _effectiveDate = effectiveDate;
    _rptLevel = rptLevel;
    _rptMgr1 = rptMgr1;
    _rptMgr2 = rptMgr2;
    _rptMgr3 = rptMgr3;
    _rptMgr4 = rptMgr4;
    _rptMgr5 = rptMgr5;
    _rptMgr6 = rptMgr6;
    _rptMgr7 = rptMgr7;
    _rptMgr8 = rptMgr8;
    _empFirstName = empFirstName;
    _maxLevel = maxLevel;
  }

  DataResponse.fromJson(dynamic json) {
    _cmpId1 = json['cmp_Id1'];
    _cmpName = json['cmp_Name'];
    _cmpAddress = json['cmp_Address'];
    _empId1 = json['emp_Id1'];
    _branchId = json['branch_Id'];
    _alphaEmpCode = json['alpha_Emp_Code'];
    _empFullName = json['emp_Full_Name'];
    _schemeId = json['scheme_Id'];
    _leave = json['leave'];
    _schemeType = json['scheme_Type'];
    _schemeName = json['scheme_Name'];
    _effectiveDate = json['effective_Date'];
    _rptLevel = json['rpt_Level'];
    _rptMgr1 = json['rpt_Mgr_1'];
    _rptMgr2 = json['rpt_Mgr_2'];
    _rptMgr3 = json['rpt_Mgr_3'];
    _rptMgr4 = json['rpt_Mgr_4'];
    _rptMgr5 = json['rpt_Mgr_5'];
    _rptMgr6 = json['rpt_Mgr_6'];
    _rptMgr7 = json['rpt_Mgr_7'];
    _rptMgr8 = json['rpt_Mgr_8'];
    _empFirstName = json['emp_First_Name'];
    _maxLevel = json['max_Level'];
  }

  num? _cmpId1;
  String? _cmpName;
  String? _cmpAddress;
  num? _empId1;
  num? _branchId;
  String? _alphaEmpCode;
  String? _empFullName;
  num? _schemeId;
  dynamic _leave;
  String? _schemeType;
  String? _schemeName;
  String? _effectiveDate;
  dynamic _rptLevel;
  String? _rptMgr1;
  String? _rptMgr2;
  String? _rptMgr3;
  String? _rptMgr4;
  String? _rptMgr5;
  String? _rptMgr6;
  String? _rptMgr7;
  String? _rptMgr8;
  dynamic _empFirstName;
  num? _maxLevel;

  DataResponse copyWith({
    num? cmpId1,
    String? cmpName,
    String? cmpAddress,
    num? empId1,
    num? branchId,
    String? alphaEmpCode,
    String? empFullName,
    num? schemeId,
    dynamic leave,
    String? schemeType,
    String? schemeName,
    String? effectiveDate,
    dynamic rptLevel,
    String? rptMgr1,
    String? rptMgr2,
    String? rptMgr3,
    String? rptMgr4,
    String? rptMgr5,
    String? rptMgr6,
    String? rptMgr7,
    String? rptMgr8,
    dynamic empFirstName,
    num? maxLevel,
  }) =>
      DataResponse(
        cmpId1: cmpId1 ?? _cmpId1,
        cmpName: cmpName ?? _cmpName,
        cmpAddress: cmpAddress ?? _cmpAddress,
        empId1: empId1 ?? _empId1,
        branchId: branchId ?? _branchId,
        alphaEmpCode: alphaEmpCode ?? _alphaEmpCode,
        empFullName: empFullName ?? _empFullName,
        schemeId: schemeId ?? _schemeId,
        leave: leave ?? _leave,
        schemeType: schemeType ?? _schemeType,
        schemeName: schemeName ?? _schemeName,
        effectiveDate: effectiveDate ?? _effectiveDate,
        rptLevel: rptLevel ?? _rptLevel,
        rptMgr1: rptMgr1 ?? _rptMgr1,
        rptMgr2: rptMgr2 ?? _rptMgr2,
        rptMgr3: rptMgr3 ?? _rptMgr3,
        rptMgr4: rptMgr4 ?? _rptMgr4,
        rptMgr5: rptMgr5 ?? _rptMgr5,
        rptMgr6: rptMgr6 ?? _rptMgr6,
        rptMgr7: rptMgr7 ?? _rptMgr7,
        rptMgr8: rptMgr8 ?? _rptMgr8,
        empFirstName: empFirstName ?? _empFirstName,
        maxLevel: maxLevel ?? _maxLevel,
      );

  num? get cmpId1 => _cmpId1;

  String? get cmpName => _cmpName;

  String? get cmpAddress => _cmpAddress;

  num? get empId1 => _empId1;

  num? get branchId => _branchId;

  String? get alphaEmpCode => _alphaEmpCode;

  String? get empFullName => _empFullName;

  num? get schemeId => _schemeId;

  dynamic get leave => _leave;

  String? get schemeType => _schemeType;

  String? get schemeName => _schemeName;

  String? get effectiveDate => _effectiveDate;

  dynamic get rptLevel => _rptLevel;

  String? get rptMgr1 => _rptMgr1;

  String? get rptMgr2 => _rptMgr2;

  String? get rptMgr3 => _rptMgr3;

  String? get rptMgr4 => _rptMgr4;

  String? get rptMgr5 => _rptMgr5;

  String? get rptMgr6 => _rptMgr6;

  String? get rptMgr7 => _rptMgr7;

  String? get rptMgr8 => _rptMgr8;

  dynamic get empFirstName => _empFirstName;

  num? get maxLevel => _maxLevel;

  Map<String, dynamic>? toJson() {
    final map = <String, dynamic>{};
    map['cmp_Id1'] = _cmpId1;
    map['cmp_Name'] = _cmpName;
    map['cmp_Address'] = _cmpAddress;
    map['emp_Id1'] = _empId1;
    map['branch_Id'] = _branchId;
    map['alpha_Emp_Code'] = _alphaEmpCode;
    map['emp_Full_Name'] = _empFullName;
    map['scheme_Id'] = _schemeId;
    map['leave'] = _leave;
    map['scheme_Type'] = _schemeType;
    map['scheme_Name'] = _schemeName;
    map['effective_Date'] = _effectiveDate;
    map['rpt_Level'] = _rptLevel;
    map['rpt_Mgr_1'] = _rptMgr1;
    map['rpt_Mgr_2'] = _rptMgr2;
    map['rpt_Mgr_3'] = _rptMgr3;
    map['rpt_Mgr_4'] = _rptMgr4;
    map['rpt_Mgr_5'] = _rptMgr5;
    map['rpt_Mgr_6'] = _rptMgr6;
    map['rpt_Mgr_7'] = _rptMgr7;
    map['rpt_Mgr_8'] = _rptMgr8;
    map['emp_First_Name'] = _empFirstName;
    map['max_Level'] = _maxLevel;
    return map;
  }
}
