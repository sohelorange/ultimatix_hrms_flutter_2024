class GetReasonResponse {
  GetReasonResponse({
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

  GetReasonResponse.fromJson(dynamic json) {
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

  GetReasonResponse copyWith({
    bool? status,
    num? code,
    String? message,
    List<Data>? data,
  }) =>
      GetReasonResponse(
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

/// Res_Id : 66
/// Reason_Name : "Others1"

class Data {
  Data({
    num? resId,
    String? reasonName,
  }) {
    _resId = resId;
    _reasonName = reasonName;
  }

  Data.fromJson(dynamic json) {
    _resId = json['Res_Id'];
    _reasonName = json['Reason_Name'];
  }

  num? _resId;
  String? _reasonName;

  Data copyWith({
    num? resId,
    String? reasonName,
  }) =>
      Data(
        resId: resId ?? _resId,
        reasonName: reasonName ?? _reasonName,
      );

  num? get resId => _resId;

  String? get reasonName => _reasonName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Res_Id'] = _resId;
    map['Reason_Name'] = _reasonName;
    return map;
  }
}
