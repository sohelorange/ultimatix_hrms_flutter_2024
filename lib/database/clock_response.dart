class ClockResponse {
  ClockResponse({
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

  ClockResponse.fromJson(dynamic json) {
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

  ClockResponse copyWith({
    bool? status,
    num? code,
    String? message,
    List<Data>? data,
  }) =>
      ClockResponse(
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

/// Duration : "04:53"
/// For_Date : "2024-07-16T00:00:00"
/// First_In_Time : "2024-07-16T11:31:00"
/// Last_Out_Time : "2024-07-16T16:24:00"

class Data {
  Data({
    String? duration,
    String? forDate,
    String? firstInTime,
    String? lastOutTime,
  }) {
    _duration = duration;
    _forDate = forDate;
    _firstInTime = firstInTime;
    _lastOutTime = lastOutTime;
  }

  Data.fromJson(dynamic json) {
    _duration = json['Duration'];
    _forDate = json['For_Date'];
    _firstInTime = json['First_In_Time'];
    _lastOutTime = json['Last_Out_Time'];
  }

  String? _duration;
  String? _forDate;
  String? _firstInTime;
  String? _lastOutTime;

  Data copyWith({
    String? duration,
    String? forDate,
    String? firstInTime,
    String? lastOutTime,
  }) =>
      Data(
        duration: duration ?? _duration,
        forDate: forDate ?? _forDate,
        firstInTime: firstInTime ?? _firstInTime,
        lastOutTime: lastOutTime ?? _lastOutTime,
      );

  String? get duration => _duration;

  String? get forDate => _forDate;

  String? get firstInTime => _firstInTime;

  String? get lastOutTime => _lastOutTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Duration'] = _duration;
    map['For_Date'] = _forDate;
    map['First_In_Time'] = _firstInTime;
    map['Last_Out_Time'] = _lastOutTime;
    return map;
  }
}
