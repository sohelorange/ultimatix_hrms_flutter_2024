class AttendanceRegularizeDetails {
  AttendanceRegularizeDetails({
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

  AttendanceRegularizeDetails.fromJson(dynamic json) {
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

  AttendanceRegularizeDetails copyWith({
    bool? status,
    num? code,
    String? message,
    List<Data>? data,
  }) =>
      AttendanceRegularizeDetails(
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

/// emp_Id : 28199
/// cmp_ID : 187
/// branch_ID : 1109
/// for_Date : "11/01/2024 00:00:00"
/// status : null
/// leave_code : "-"
/// leave_Count : null
/// od : "-"
/// oD_Count : null
/// wO_HO : null
/// status_2 : null
/// row_ID : 1
/// in_Date : null
/// out_Date : null
/// shift_ID : 388
/// shift_Name : "General Shift"
/// sh_In_Time : "09:00"
/// sh_Out_Time : "17:00"
/// holiday : null
/// late_Limit : "00:00"
/// reason : null
/// half_Full_Day : null
/// chk_By_Superior : null
/// sup_Comment : null
/// is_Cancel_Late_In : 0
/// is_Cancel_Early_Out : 0
/// early_Limit : "00:00"
/// main_Status : "A"
/// detail_Status : null
/// is_Late_Calc_On_HO_WO : 0
/// is_Early_Calc_On_HO_WO : 0
/// late_Minute : 0
/// early_Minute : 0
/// is_Leave_App : 0
/// other_Reason : null
/// r_Emp_ID : 23921
/// att_Approval_Days : 0
/// att_App_ID : 0
/// att_Apr_Status : " "
/// shift_Duration : "08:00"
/// oT_Apr_ID : 0
/// comp_Off_App : 0
/// comp_Off_Apr : 0
/// oT_Applicable : 1
/// display_Birth : "F"
/// display_Marriage_Date : "F"
/// date_of_Join : "11/30/2021 00:00:00"
/// left_Date : null
/// exFlag : "NA"
/// late_Time : 0
/// early_Time : 0
/// late_Minutes : 0
/// early_Out : 0
/// alpha_Emp_Code : "0058"
/// emp_Full_Name : "Mr. AP BM"
/// branch_Name : "AP Branch"
/// dept_Name : "Software"
/// grd_Name : "A"
/// desig_Name : "MANAGER"
/// branch_Address : ""
/// comp_Name : null
/// dbrD_Code : ""
/// p_Days : 0
/// emp_Late_Mark : 0
/// emp_Early_Mark : 0
/// disable_Comment : "disabled"
/// grd_ID : 611
/// r_Emp_ID1 : 0
/// working_Hour : "00.00"
/// working_Sec : 0
/// req_For_App : 28800
/// slab_Shift_Hours : "04.00"
/// week_Off_OT : 0
/// exFlag1 : null
/// rowStatus : false
/// rowColor : "Absent:#ebcccc"

class Data {
  Data({
    num? empId,
    num? cmpID,
    num? branchID,
    String? forDate,
    dynamic status,
    String? leaveCode,
    dynamic leaveCount,
    String? od,
    dynamic oDCount,
    dynamic wOHO,
    dynamic status2,
    num? rowID,
    dynamic inDate,
    dynamic outDate,
    num? shiftID,
    String? shiftName,
    String? shInTime,
    String? shOutTime,
    dynamic holiday,
    String? lateLimit,
    dynamic reason,
    dynamic halfFullDay,
    dynamic chkBySuperior,
    dynamic supComment,
    num? isCancelLateIn,
    num? isCancelEarlyOut,
    String? earlyLimit,
    String? mainStatus,
    dynamic detailStatus,
    num? isLateCalcOnHOWO,
    num? isEarlyCalcOnHOWO,
    num? lateMinute,
    num? earlyMinute,
    num? isLeaveApp,
    dynamic otherReason,
    num? rEmpID,
    num? attApprovalDays,
    num? attAppID,
    String? attAprStatus,
    String? shiftDuration,
    num? oTAprID,
    num? compOffApp,
    num? compOffApr,
    num? oTApplicable,
    String? displayBirth,
    String? displayMarriageDate,
    String? dateOfJoin,
    dynamic leftDate,
    String? exFlag,
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
    dynamic compName,
    String? dbrDCode,
    num? pDays,
    num? empLateMark,
    num? empEarlyMark,
    String? disableComment,
    num? grdID,
    num? rEmpID1,
    String? workingHour,
    num? workingSec,
    num? reqForApp,
    String? slabShiftHours,
    num? weekOffOT,
    dynamic exFlag1,
    bool? rowStatus,
    String? rowColor,
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
    _shiftID = shiftID;
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
    _rEmpID = rEmpID;
    _attApprovalDays = attApprovalDays;
    _attAppID = attAppID;
    _attAprStatus = attAprStatus;
    _shiftDuration = shiftDuration;
    _oTAprID = oTAprID;
    _compOffApp = compOffApp;
    _compOffApr = compOffApr;
    _oTApplicable = oTApplicable;
    _displayBirth = displayBirth;
    _displayMarriageDate = displayMarriageDate;
    _dateOfJoin = dateOfJoin;
    _leftDate = leftDate;
    _exFlag = exFlag;
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
    _rEmpID1 = rEmpID1;
    _workingHour = workingHour;
    _workingSec = workingSec;
    _reqForApp = reqForApp;
    _slabShiftHours = slabShiftHours;
    _weekOffOT = weekOffOT;
    _exFlag1 = exFlag1;
    _rowStatus = rowStatus;
    _rowColor = rowColor;
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
    _shiftID = json['shift_ID'];
    _shiftName = json['shift_Name'];
    _shInTime = json['sh_In_Time'];
    _shOutTime = json['sh_Out_Time'];
    _holiday = json['holiday'];
    _lateLimit = json['late_Limit'];
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
    _lateMinute = json['late_Minute'];
    _earlyMinute = json['early_Minute'];
    _isLeaveApp = json['is_Leave_App'];
    _otherReason = json['other_Reason'];
    _rEmpID = json['r_Emp_ID'];
    _attApprovalDays = json['att_Approval_Days'];
    _attAppID = json['att_App_ID'];
    _attAprStatus = json['att_Apr_Status'];
    _shiftDuration = json['shift_Duration'];
    _oTAprID = json['oT_Apr_ID'];
    _compOffApp = json['comp_Off_App'];
    _compOffApr = json['comp_Off_Apr'];
    _oTApplicable = json['oT_Applicable'];
    _displayBirth = json['display_Birth'];
    _displayMarriageDate = json['display_Marriage_Date'];
    _dateOfJoin = json['date_of_Join'];
    _leftDate = json['left_Date'];
    _exFlag = json['exFlag'];
    _lateTime = json['late_Time'];
    _earlyTime = json['early_Time'];
    _lateMinutes = json['late_Minutes'];
    _earlyOut = json['early_Out'];
    _alphaEmpCode = json['alpha_Emp_Code'];
    _empFullName = json['emp_Full_Name'];
    _branchName = json['branch_Name'];
    _deptName = json['dept_Name'];
    _grdName = json['grd_Name'];
    _desigName = json['desig_Name'];
    _branchAddress = json['branch_Address'];
    _compName = json['comp_Name'];
    _dbrDCode = json['dbrD_Code'];
    _pDays = json['p_Days'];
    _empLateMark = json['emp_Late_Mark'];
    _empEarlyMark = json['emp_Early_Mark'];
    _disableComment = json['disable_Comment'];
    _grdID = json['grd_ID'];
    _rEmpID1 = json['r_Emp_ID1'];
    _workingHour = json['working_Hour'];
    _workingSec = json['working_Sec'];
    _reqForApp = json['req_For_App'];
    _slabShiftHours = json['slab_Shift_Hours'];
    _weekOffOT = json['week_Off_OT'];
    _exFlag1 = json['exFlag1'];
    _rowStatus = json['rowStatus'];
    _rowColor = json['rowColor'];
  }

  num? _empId;
  num? _cmpID;
  num? _branchID;
  String? _forDate;
  dynamic _status;
  String? _leaveCode;
  dynamic _leaveCount;
  String? _od;
  dynamic _oDCount;
  dynamic _wOHO;
  dynamic _status2;
  num? _rowID;
  dynamic _inDate;
  dynamic _outDate;
  num? _shiftID;
  String? _shiftName;
  String? _shInTime;
  String? _shOutTime;
  dynamic _holiday;
  String? _lateLimit;
  dynamic _reason;
  dynamic _halfFullDay;
  dynamic _chkBySuperior;
  dynamic _supComment;
  num? _isCancelLateIn;
  num? _isCancelEarlyOut;
  String? _earlyLimit;
  String? _mainStatus;
  dynamic _detailStatus;
  num? _isLateCalcOnHOWO;
  num? _isEarlyCalcOnHOWO;
  num? _lateMinute;
  num? _earlyMinute;
  num? _isLeaveApp;
  dynamic _otherReason;
  num? _rEmpID;
  num? _attApprovalDays;
  num? _attAppID;
  String? _attAprStatus;
  String? _shiftDuration;
  num? _oTAprID;
  num? _compOffApp;
  num? _compOffApr;
  num? _oTApplicable;
  String? _displayBirth;
  String? _displayMarriageDate;
  String? _dateOfJoin;
  dynamic _leftDate;
  String? _exFlag;
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
  dynamic _compName;
  String? _dbrDCode;
  num? _pDays;
  num? _empLateMark;
  num? _empEarlyMark;
  String? _disableComment;
  num? _grdID;
  num? _rEmpID1;
  String? _workingHour;
  num? _workingSec;
  num? _reqForApp;
  String? _slabShiftHours;
  num? _weekOffOT;
  dynamic _exFlag1;
  bool? _rowStatus;
  String? _rowColor;

  Data copyWith({
    num? empId,
    num? cmpID,
    num? branchID,
    String? forDate,
    dynamic status,
    String? leaveCode,
    dynamic leaveCount,
    String? od,
    dynamic oDCount,
    dynamic wOHO,
    dynamic status2,
    num? rowID,
    dynamic inDate,
    dynamic outDate,
    num? shiftID,
    String? shiftName,
    String? shInTime,
    String? shOutTime,
    dynamic holiday,
    String? lateLimit,
    dynamic reason,
    dynamic halfFullDay,
    dynamic chkBySuperior,
    dynamic supComment,
    num? isCancelLateIn,
    num? isCancelEarlyOut,
    String? earlyLimit,
    String? mainStatus,
    dynamic detailStatus,
    num? isLateCalcOnHOWO,
    num? isEarlyCalcOnHOWO,
    num? lateMinute,
    num? earlyMinute,
    num? isLeaveApp,
    dynamic otherReason,
    num? rEmpID,
    num? attApprovalDays,
    num? attAppID,
    String? attAprStatus,
    String? shiftDuration,
    num? oTAprID,
    num? compOffApp,
    num? compOffApr,
    num? oTApplicable,
    String? displayBirth,
    String? displayMarriageDate,
    String? dateOfJoin,
    dynamic leftDate,
    String? exFlag,
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
    dynamic compName,
    String? dbrDCode,
    num? pDays,
    num? empLateMark,
    num? empEarlyMark,
    String? disableComment,
    num? grdID,
    num? rEmpID1,
    String? workingHour,
    num? workingSec,
    num? reqForApp,
    String? slabShiftHours,
    num? weekOffOT,
    dynamic exFlag1,
    bool? rowStatus,
    String? rowColor,
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
        shiftID: shiftID ?? _shiftID,
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
        rEmpID: rEmpID ?? _rEmpID,
        attApprovalDays: attApprovalDays ?? _attApprovalDays,
        attAppID: attAppID ?? _attAppID,
        attAprStatus: attAprStatus ?? _attAprStatus,
        shiftDuration: shiftDuration ?? _shiftDuration,
        oTAprID: oTAprID ?? _oTAprID,
        compOffApp: compOffApp ?? _compOffApp,
        compOffApr: compOffApr ?? _compOffApr,
        oTApplicable: oTApplicable ?? _oTApplicable,
        displayBirth: displayBirth ?? _displayBirth,
        displayMarriageDate: displayMarriageDate ?? _displayMarriageDate,
        dateOfJoin: dateOfJoin ?? _dateOfJoin,
        leftDate: leftDate ?? _leftDate,
        exFlag: exFlag ?? _exFlag,
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
        rEmpID1: rEmpID1 ?? _rEmpID1,
        workingHour: workingHour ?? _workingHour,
        workingSec: workingSec ?? _workingSec,
        reqForApp: reqForApp ?? _reqForApp,
        slabShiftHours: slabShiftHours ?? _slabShiftHours,
        weekOffOT: weekOffOT ?? _weekOffOT,
        exFlag1: exFlag1 ?? _exFlag1,
        rowStatus: rowStatus ?? _rowStatus,
        rowColor: rowColor ?? _rowColor,
      );

  num? get empId => _empId;

  num? get cmpID => _cmpID;

  num? get branchID => _branchID;

  String? get forDate => _forDate;

  dynamic get status => _status;

  String? get leaveCode => _leaveCode;

  dynamic get leaveCount => _leaveCount;

  String? get od => _od;

  dynamic get oDCount => _oDCount;

  dynamic get wOHO => _wOHO;

  dynamic get status2 => _status2;

  num? get rowID => _rowID;

  dynamic get inDate => _inDate;

  dynamic get outDate => _outDate;

  num? get shiftID => _shiftID;

  String? get shiftName => _shiftName;

  String? get shInTime => _shInTime;

  String? get shOutTime => _shOutTime;

  dynamic get holiday => _holiday;

  String? get lateLimit => _lateLimit;

  dynamic get reason => _reason;

  dynamic get halfFullDay => _halfFullDay;

  dynamic get chkBySuperior => _chkBySuperior;

  dynamic get supComment => _supComment;

  num? get isCancelLateIn => _isCancelLateIn;

  num? get isCancelEarlyOut => _isCancelEarlyOut;

  String? get earlyLimit => _earlyLimit;

  String? get mainStatus => _mainStatus;

  dynamic get detailStatus => _detailStatus;

  num? get isLateCalcOnHOWO => _isLateCalcOnHOWO;

  num? get isEarlyCalcOnHOWO => _isEarlyCalcOnHOWO;

  num? get lateMinute => _lateMinute;

  num? get earlyMinute => _earlyMinute;

  num? get isLeaveApp => _isLeaveApp;

  dynamic get otherReason => _otherReason;

  num? get rEmpID => _rEmpID;

  num? get attApprovalDays => _attApprovalDays;

  num? get attAppID => _attAppID;

  String? get attAprStatus => _attAprStatus;

  String? get shiftDuration => _shiftDuration;

  num? get oTAprID => _oTAprID;

  num? get compOffApp => _compOffApp;

  num? get compOffApr => _compOffApr;

  num? get oTApplicable => _oTApplicable;

  String? get displayBirth => _displayBirth;

  String? get displayMarriageDate => _displayMarriageDate;

  String? get dateOfJoin => _dateOfJoin;

  dynamic get leftDate => _leftDate;

  String? get exFlag => _exFlag;

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

  dynamic get compName => _compName;

  String? get dbrDCode => _dbrDCode;

  num? get pDays => _pDays;

  num? get empLateMark => _empLateMark;

  num? get empEarlyMark => _empEarlyMark;

  String? get disableComment => _disableComment;

  num? get grdID => _grdID;

  num? get rEmpID1 => _rEmpID1;

  String? get workingHour => _workingHour;

  num? get workingSec => _workingSec;

  num? get reqForApp => _reqForApp;

  String? get slabShiftHours => _slabShiftHours;

  num? get weekOffOT => _weekOffOT;

  dynamic get exFlag1 => _exFlag1;

  bool? get rowStatus => _rowStatus;

  String? get rowColor => _rowColor;

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
    map['shift_ID'] = _shiftID;
    map['shift_Name'] = _shiftName;
    map['sh_In_Time'] = _shInTime;
    map['sh_Out_Time'] = _shOutTime;
    map['holiday'] = _holiday;
    map['late_Limit'] = _lateLimit;
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
    map['late_Minute'] = _lateMinute;
    map['early_Minute'] = _earlyMinute;
    map['is_Leave_App'] = _isLeaveApp;
    map['other_Reason'] = _otherReason;
    map['r_Emp_ID'] = _rEmpID;
    map['att_Approval_Days'] = _attApprovalDays;
    map['att_App_ID'] = _attAppID;
    map['att_Apr_Status'] = _attAprStatus;
    map['shift_Duration'] = _shiftDuration;
    map['oT_Apr_ID'] = _oTAprID;
    map['comp_Off_App'] = _compOffApp;
    map['comp_Off_Apr'] = _compOffApr;
    map['oT_Applicable'] = _oTApplicable;
    map['display_Birth'] = _displayBirth;
    map['display_Marriage_Date'] = _displayMarriageDate;
    map['date_of_Join'] = _dateOfJoin;
    map['left_Date'] = _leftDate;
    map['exFlag'] = _exFlag;
    map['late_Time'] = _lateTime;
    map['early_Time'] = _earlyTime;
    map['late_Minutes'] = _lateMinutes;
    map['early_Out'] = _earlyOut;
    map['alpha_Emp_Code'] = _alphaEmpCode;
    map['emp_Full_Name'] = _empFullName;
    map['branch_Name'] = _branchName;
    map['dept_Name'] = _deptName;
    map['grd_Name'] = _grdName;
    map['desig_Name'] = _desigName;
    map['branch_Address'] = _branchAddress;
    map['comp_Name'] = _compName;
    map['dbrD_Code'] = _dbrDCode;
    map['p_Days'] = _pDays;
    map['emp_Late_Mark'] = _empLateMark;
    map['emp_Early_Mark'] = _empEarlyMark;
    map['disable_Comment'] = _disableComment;
    map['grd_ID'] = _grdID;
    map['r_Emp_ID1'] = _rEmpID1;
    map['working_Hour'] = _workingHour;
    map['working_Sec'] = _workingSec;
    map['req_For_App'] = _reqForApp;
    map['slab_Shift_Hours'] = _slabShiftHours;
    map['week_Off_OT'] = _weekOffOT;
    map['exFlag1'] = _exFlag1;
    map['rowStatus'] = _rowStatus;
    map['rowColor'] = _rowColor;
    return map;
  }
}
