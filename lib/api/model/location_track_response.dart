class LocationTrackResponse {
  LocationTrackResponse({
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

  LocationTrackResponse.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data?.fromJson(v));
      });
    }
  }

  bool? _status;
  num? _code;
  String? _message;
  List<Data>? _data;

  LocationTrackResponse copyWith({
    bool? status,
    num? code,
    String? message,
    List<Data>? data,
  }) =>
      LocationTrackResponse(
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

/// empId : 28201
/// cmpId : 187
/// latitude : 21.7254685
/// longitude : 73.0237397
/// trackingDate : "2024-08-01T11:12:09"
/// address : "P2GF+48J, GNFC Twp, Bharuch, Gujarat 392012, India"
/// city : "Bharuch"
/// area : " GNFC Twp"

class Data {
  Data({
    num? empId,
    num? cmpId,
    num? latitude,
    num? longitude,
    String? trackingDate,
    String? address,
    String? city,
    String? area,
  }) {
    _empId = empId;
    _cmpId = cmpId;
    _latitude = latitude;
    _longitude = longitude;
    _trackingDate = trackingDate;
    _address = address;
    _city = city;
    _area = area;
  }

  Data.fromJson(dynamic json) {
    _empId = json['empId'];
    _cmpId = json['cmpId'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _trackingDate = json['trackingDate'];
    _address = json['address'];
    _city = json['city'];
    _area = json['area'];
  }

  num? _empId;
  num? _cmpId;
  num? _latitude;
  num? _longitude;
  String? _trackingDate;
  String? _address;
  String? _city;
  String? _area;

  Data copyWith({
    num? empId,
    num? cmpId,
    num? latitude,
    num? longitude,
    String? trackingDate,
    String? address,
    String? city,
    String? area,
  }) =>
      Data(
        empId: empId ?? _empId,
        cmpId: cmpId ?? _cmpId,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        trackingDate: trackingDate ?? _trackingDate,
        address: address ?? _address,
        city: city ?? _city,
        area: area ?? _area,
      );

  num? get empId => _empId;

  num? get cmpId => _cmpId;

  num? get latitude => _latitude;

  num? get longitude => _longitude;

  String? get trackingDate => _trackingDate;

  String? get address => _address;

  String? get city => _city;

  String? get area => _area;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['empId'] = _empId;
    map['cmpId'] = _cmpId;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['trackingDate'] = _trackingDate;
    map['address'] = _address;
    map['city'] = _city;
    map['area'] = _area;
    return map;
  }
}
