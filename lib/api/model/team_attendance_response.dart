class TeamAttendanceResponse {
  TeamAttendanceResponse({
    bool? status,
    num? code,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _code = code;
    _message = message;
    _data = data;
  }

  TeamAttendanceResponse.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  bool? _status;
  num? _code;
  String? _message;
  List<Data>? _data;

  TeamAttendanceResponse copyWith({
    bool? status,
    num? code,
    String? message,
    List<Data>? data,
  }) =>
      TeamAttendanceResponse(
        status: status ?? _status,
        code: code ?? _code,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  num? get code => _code;

  String? get message => _message;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    num? empId,
    num? cmpID,
    num? branchID,
    String? forDate,
    String? status,
    String? leaveCode,
    num? leaveCount,
    String? od,
    num? oDCount,
    String? wOHO,
    String? status2,
    num? rowID,
    String? inDate,
    String? outDate,
    num? shiftId,
    String? shiftName,
    String? shInTime,
    String? shOutTime,
    String? holiday,
    String? lateLimit,
    String? reason,
    String? halfFullDay,
    String? chkBySuperior,
    String? supComment,
    num? isCancelLateIn,
    num? isCancelEarlyOut,
    String? earlyLimit,
    String? mainStatus,
    String? detailStatus,
    num? isLateCalcOnHOWO,
    num? isEarlyCalcOnHOWO,
    num? lateMinute,
    num? earlyMinute,
    num? isLeaveApp,
    String? otherReason,
    String? dateOfJoin,
    String? leftDate,
    num? lateTime,
    num? earlyTime,
    num? lateMinutes,
    num? earlyOut,
    String? alphaEmpCode,
    String? empFullName,
    String? branchName,
    String? deptName,
    String? grdName,
    String? desigName,
    String? branchAddress,
    String? compName,
    String? dbrDCode,
    num? pDays,
    num? empLateMark,
    num? empEarlyMark,
    String? disableComment,
    num? grdID,
    dynamic location,
    num? desigId,
    num? deptID,
    num? catID,
    String? catName,
    String? imagePath,
  }) {
    _empId = empId;
    _cmpID = cmpID;
    _branchID = branchID;
    _forDate = forDate;
    _status = status;
    _leaveCode = leaveCode;
    _leaveCount = leaveCount;
    _od = od;
    _oDCount = oDCount;
    _wOHO = wOHO;
    _status2 = status2;
    _rowID = rowID;
    _inDate = inDate;
    _outDate = outDate;
    _shiftId = shiftId;
    _shiftName = shiftName;
    _shInTime = shInTime;
    _shOutTime = shOutTime;
    _holiday = holiday;
    _lateLimit = lateLimit;
    _reason = reason;
    _halfFullDay = halfFullDay;
    _chkBySuperior = chkBySuperior;
    _supComment = supComment;
    _isCancelLateIn = isCancelLateIn;
    _isCancelEarlyOut = isCancelEarlyOut;
    _earlyLimit = earlyLimit;
    _mainStatus = mainStatus;
    _detailStatus = detailStatus;
    _isLateCalcOnHOWO = isLateCalcOnHOWO;
    _isEarlyCalcOnHOWO = isEarlyCalcOnHOWO;
    _lateMinute = lateMinute;
    _earlyMinute = earlyMinute;
    _isLeaveApp = isLeaveApp;
    _otherReason = otherReason;
    _dateOfJoin = dateOfJoin;
    _leftDate = leftDate;
    _lateTime = lateTime;
    _earlyTime = earlyTime;
    _lateMinutes = lateMinutes;
    _earlyOut = earlyOut;
    _alphaEmpCode = alphaEmpCode;
    _empFullName = empFullName;
    _branchName = branchName;
    _deptName = deptName;
    _grdName = grdName;
    _desigName = desigName;
    _branchAddress = branchAddress;
    _compName = compName;
    _dbrDCode = dbrDCode;
    _pDays = pDays;
    _empLateMark = empLateMark;
    _empEarlyMark = empEarlyMark;
    _disableComment = disableComment;
    _grdID = grdID;
    _location = location;
    _desigId = desigId;
    _deptID = deptID;
    _catID = catID;
    _catName = catName;
    _imagePath = imagePath;
  }

  Data.fromJson(dynamic json) {
    _empId = json['emp_Id'];
    _cmpID = json['cmp_ID'];
    _branchID = json['branch_ID'];
    _forDate = json['for_Date'];
    _status = json['status'];
    _leaveCode = json['leave_code'];
    _leaveCount = json['leave_Count'];
    _od = json['od'];
    _oDCount = json['oD_Count'];
    _wOHO = json['wO_HO'];
    _status2 = json['status_2'];
    _rowID = json['row_ID'];
    _inDate = json['in_Date'];
    _outDate = json['out_Date'];
    _shiftId = json['shift_id'];
    _shiftName = json['shift_name'];
    _shInTime = json['sh_in_time'];
    _shOutTime = json['sh_out_time'];
    _holiday = json['holiday'];
    _lateLimit = json['late_limit'];
    _reason = json['reason'];
    _halfFullDay = json['half_Full_Day'];
    _chkBySuperior = json['chk_By_Superior'];
    _supComment = json['sup_Comment'];
    _isCancelLateIn = json['is_Cancel_Late_In'];
    _isCancelEarlyOut = json['is_Cancel_Early_Out'];
    _earlyLimit = json['early_Limit'];
    _mainStatus = json['main_Status'];
    _detailStatus = json['detail_Status'];
    _isLateCalcOnHOWO = json['is_Late_Calc_On_HO_WO'];
    _isEarlyCalcOnHOWO = json['is_Early_Calc_On_HO_WO'];
    _lateMinute = json['late_minute'];
    _earlyMinute = json['early_minute'];
    _isLeaveApp = json['is_Leave_App'];
    _otherReason = json['other_Reason'];
    _dateOfJoin = json['date_of_join'];
    _leftDate = json['left_date'];
    _lateTime = json['late_time'];
    _earlyTime = json['early_time'];
    _lateMinutes = json['late_minutes'];
    _earlyOut = json['early_out'];
    _alphaEmpCode = json['alpha_Emp_Code'];
    _empFullName = json['emp_full_Name'];
    _branchName = json['branch_Name'];
    _deptName = json['dept_Name'];
    _grdName = json['grd_Name'];
    _desigName = json['desig_Name'];
    _branchAddress = json['branch_Address'];
    _compName = json['comp_Name'];
    _dbrDCode = json['dbrD_Code'];
    _pDays = json['p_days'];
    _empLateMark = json['emp_Late_mark'];
    _empEarlyMark = json['emp_Early_mark'];
    _disableComment = json['disable_Comment'];
    _grdID = json['grd_ID'];
    _location = json['location'];
    _desigId = json['desig_Id'];
    _deptID = json['dept_ID'];
    _catID = json['cat_ID'];
    _catName = json['cat_Name'];
    _imagePath = json['image_Path'];
  }

  num? _empId;
  num? _cmpID;
  num? _branchID;
  String? _forDate;
  String? _status;
  String? _leaveCode;
  num? _leaveCount;
  String? _od;
  num? _oDCount;
  String? _wOHO;
  String? _status2;
  num? _rowID;
  String? _inDate;
  String? _outDate;
  num? _shiftId;
  String? _shiftName;
  String? _shInTime;
  String? _shOutTime;
  String? _holiday;
  String? _lateLimit;
  String? _reason;
  String? _halfFullDay;
  String? _chkBySuperior;
  String? _supComment;
  num? _isCancelLateIn;
  num? _isCancelEarlyOut;
  String? _earlyLimit;
  String? _mainStatus;
  String? _detailStatus;
  num? _isLateCalcOnHOWO;
  num? _isEarlyCalcOnHOWO;
  num? _lateMinute;
  num? _earlyMinute;
  num? _isLeaveApp;
  String? _otherReason;
  String? _dateOfJoin;
  String? _leftDate;
  num? _lateTime;
  num? _earlyTime;
  num? _lateMinutes;
  num? _earlyOut;
  String? _alphaEmpCode;
  String? _empFullName;
  String? _branchName;
  String? _deptName;
  String? _grdName;
  String? _desigName;
  String? _branchAddress;
  String? _compName;
  String? _dbrDCode;
  num? _pDays;
  num? _empLateMark;
  num? _empEarlyMark;
  String? _disableComment;
  num? _grdID;
  dynamic _location;
  num? _desigId;
  num? _deptID;
  num? _catID;
  String? _catName;
  String? _imagePath;

  Data copyWith({
    num? empId,
    num? cmpID,
    num? branchID,
    String? forDate,
    String? status,
    String? leaveCode,
    num? leaveCount,
    String? od,
    num? oDCount,
    String? wOHO,
    String? status2,
    num? rowID,
    String? inDate,
    String? outDate,
    num? shiftId,
    String? shiftName,
    String? shInTime,
    String? shOutTime,
    String? holiday,
    String? lateLimit,
    String? reason,
    String? halfFullDay,
    String? chkBySuperior,
    String? supComment,
    num? isCancelLateIn,
    num? isCancelEarlyOut,
    String? earlyLimit,
    String? mainStatus,
    String? detailStatus,
    num? isLateCalcOnHOWO,
    num? isEarlyCalcOnHOWO,
    num? lateMinute,
    num? earlyMinute,
    num? isLeaveApp,
    String? otherReason,
    String? dateOfJoin,
    String? leftDate,
    num? lateTime,
    num? earlyTime,
    num? lateMinutes,
    num? earlyOut,
    String? alphaEmpCode,
    String? empFullName,
    String? branchName,
    String? deptName,
    String? grdName,
    String? desigName,
    String? branchAddress,
    String? compName,
    String? dbrDCode,
    num? pDays,
    num? empLateMark,
    num? empEarlyMark,
    String? disableComment,
    num? grdID,
    dynamic location,
    num? desigId,
    num? deptID,
    num? catID,
    String? catName,
    String? imagePath,
  }) =>
      Data(
        empId: empId ?? _empId,
        cmpID: cmpID ?? _cmpID,
        branchID: branchID ?? _branchID,
        forDate: forDate ?? _forDate,
        status: status ?? _status,
        leaveCode: leaveCode ?? _leaveCode,
        leaveCount: leaveCount ?? _leaveCount,
        od: od ?? _od,
        oDCount: oDCount ?? _oDCount,
        wOHO: wOHO ?? _wOHO,
        status2: status2 ?? _status2,
        rowID: rowID ?? _rowID,
        inDate: inDate ?? _inDate,
        outDate: outDate ?? _outDate,
        shiftId: shiftId ?? _shiftId,
        shiftName: shiftName ?? _shiftName,
        shInTime: shInTime ?? _shInTime,
        shOutTime: shOutTime ?? _shOutTime,
        holiday: holiday ?? _holiday,
        lateLimit: lateLimit ?? _lateLimit,
        reason: reason ?? _reason,
        halfFullDay: halfFullDay ?? _halfFullDay,
        chkBySuperior: chkBySuperior ?? _chkBySuperior,
        supComment: supComment ?? _supComment,
        isCancelLateIn: isCancelLateIn ?? _isCancelLateIn,
        isCancelEarlyOut: isCancelEarlyOut ?? _isCancelEarlyOut,
        earlyLimit: earlyLimit ?? _earlyLimit,
        mainStatus: mainStatus ?? _mainStatus,
        detailStatus: detailStatus ?? _detailStatus,
        isLateCalcOnHOWO: isLateCalcOnHOWO ?? _isLateCalcOnHOWO,
        isEarlyCalcOnHOWO: isEarlyCalcOnHOWO ?? _isEarlyCalcOnHOWO,
        lateMinute: lateMinute ?? _lateMinute,
        earlyMinute: earlyMinute ?? _earlyMinute,
        isLeaveApp: isLeaveApp ?? _isLeaveApp,
        otherReason: otherReason ?? _otherReason,
        dateOfJoin: dateOfJoin ?? _dateOfJoin,
        leftDate: leftDate ?? _leftDate,
        lateTime: lateTime ?? _lateTime,
        earlyTime: earlyTime ?? _earlyTime,
        lateMinutes: lateMinutes ?? _lateMinutes,
        earlyOut: earlyOut ?? _earlyOut,
        alphaEmpCode: alphaEmpCode ?? _alphaEmpCode,
        empFullName: empFullName ?? _empFullName,
        branchName: branchName ?? _branchName,
        deptName: deptName ?? _deptName,
        grdName: grdName ?? _grdName,
        desigName: desigName ?? _desigName,
        branchAddress: branchAddress ?? _branchAddress,
        compName: compName ?? _compName,
        dbrDCode: dbrDCode ?? _dbrDCode,
        pDays: pDays ?? _pDays,
        empLateMark: empLateMark ?? _empLateMark,
        empEarlyMark: empEarlyMark ?? _empEarlyMark,
        disableComment: disableComment ?? _disableComment,
        grdID: grdID ?? _grdID,
        location: location ?? _location,
        desigId: desigId ?? _desigId,
        deptID: deptID ?? _deptID,
        catID: catID ?? _catID,
        catName: catName ?? _catName,
        imagePath: imagePath ?? _imagePath,
      );

  num? get empId => _empId;

  num? get cmpID => _cmpID;

  num? get branchID => _branchID;

  String? get forDate => _forDate;

  String? get status => _status;

  String? get leaveCode => _leaveCode;

  num? get leaveCount => _leaveCount;

  String? get od => _od;

  num? get oDCount => _oDCount;

  String? get wOHO => _wOHO;

  String? get status2 => _status2;

  num? get rowID => _rowID;

  String? get inDate => _inDate;

  String? get outDate => _outDate;

  num? get shiftId => _shiftId;

  String? get shiftName => _shiftName;

  String? get shInTime => _shInTime;

  String? get shOutTime => _shOutTime;

  String? get holiday => _holiday;

  String? get lateLimit => _lateLimit;

  String? get reason => _reason;

  String? get halfFullDay => _halfFullDay;

  String? get chkBySuperior => _chkBySuperior;

  String? get supComment => _supComment;

  num? get isCancelLateIn => _isCancelLateIn;

  num? get isCancelEarlyOut => _isCancelEarlyOut;

  String? get earlyLimit => _earlyLimit;

  String? get mainStatus => _mainStatus;

  String? get detailStatus => _detailStatus;

  num? get isLateCalcOnHOWO => _isLateCalcOnHOWO;

  num? get isEarlyCalcOnHOWO => _isEarlyCalcOnHOWO;

  num? get lateMinute => _lateMinute;

  num? get earlyMinute => _earlyMinute;

  num? get isLeaveApp => _isLeaveApp;

  String? get otherReason => _otherReason;

  String? get dateOfJoin => _dateOfJoin;

  String? get leftDate => _leftDate;

  num? get lateTime => _lateTime;

  num? get earlyTime => _earlyTime;

  num? get lateMinutes => _lateMinutes;

  num? get earlyOut => _earlyOut;

  String? get alphaEmpCode => _alphaEmpCode;

  String? get empFullName => _empFullName;

  String? get branchName => _branchName;

  String? get deptName => _deptName;

  String? get grdName => _grdName;

  String? get desigName => _desigName;

  String? get branchAddress => _branchAddress;

  String? get compName => _compName;

  String? get dbrDCode => _dbrDCode;

  num? get pDays => _pDays;

  num? get empLateMark => _empLateMark;

  num? get empEarlyMark => _empEarlyMark;

  String? get disableComment => _disableComment;

  num? get grdID => _grdID;

  dynamic get location => _location;

  num? get desigId => _desigId;

  num? get deptID => _deptID;

  num? get catID => _catID;

  String? get catName => _catName;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emp_Id'] = _empId;
    map['cmp_ID'] = _cmpID;
    map['branch_ID'] = _branchID;
    map['for_Date'] = _forDate;
    map['status'] = _status;
    map['leave_code'] = _leaveCode;
    map['leave_Count'] = _leaveCount;
    map['od'] = _od;
    map['oD_Count'] = _oDCount;
    map['wO_HO'] = _wOHO;
    map['status_2'] = _status2;
    map['row_ID'] = _rowID;
    map['in_Date'] = _inDate;
    map['out_Date'] = _outDate;
    map['shift_id'] = _shiftId;
    map['shift_name'] = _shiftName;
    map['sh_in_time'] = _shInTime;
    map['sh_out_time'] = _shOutTime;
    map['holiday'] = _holiday;
    map['late_limit'] = _lateLimit;
    map['reason'] = _reason;
    map['half_Full_Day'] = _halfFullDay;
    map['chk_By_Superior'] = _chkBySuperior;
    map['sup_Comment'] = _supComment;
    map['is_Cancel_Late_In'] = _isCancelLateIn;
    map['is_Cancel_Early_Out'] = _isCancelEarlyOut;
    map['early_Limit'] = _earlyLimit;
    map['main_Status'] = _mainStatus;
    map['detail_Status'] = _detailStatus;
    map['is_Late_Calc_On_HO_WO'] = _isLateCalcOnHOWO;
    map['is_Early_Calc_On_HO_WO'] = _isEarlyCalcOnHOWO;
    map['late_minute'] = _lateMinute;
    map['early_minute'] = _earlyMinute;
    map['is_Leave_App'] = _isLeaveApp;
    map['other_Reason'] = _otherReason;
    map['date_of_join'] = _dateOfJoin;
    map['left_date'] = _leftDate;
    map['late_time'] = _lateTime;
    map['early_time'] = _earlyTime;
    map['late_minutes'] = _lateMinutes;
    map['early_out'] = _earlyOut;
    map['alpha_Emp_Code'] = _alphaEmpCode;
    map['emp_full_Name'] = _empFullName;
    map['branch_Name'] = _branchName;
    map['dept_Name'] = _deptName;
    map['grd_Name'] = _grdName;
    map['desig_Name'] = _desigName;
    map['branch_Address'] = _branchAddress;
    map['comp_Name'] = _compName;
    map['dbrD_Code'] = _dbrDCode;
    map['p_days'] = _pDays;
    map['emp_Late_mark'] = _empLateMark;
    map['emp_Early_mark'] = _empEarlyMark;
    map['disable_Comment'] = _disableComment;
    map['grd_ID'] = _grdID;
    map['location'] = _location;
    map['desig_Id'] = _desigId;
    map['dept_ID'] = _deptID;
    map['cat_ID'] = _catID;
    map['cat_Name'] = _catName;
    map['image_Path'] = _imagePath;
    return map;
  }
}
