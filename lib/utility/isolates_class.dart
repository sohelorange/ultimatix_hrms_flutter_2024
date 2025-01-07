import 'dart:isolate';
import 'dart:ui';
import 'package:dio/dio.dart' as dio;
import '../database/clock_in_out_entity.dart';
import '../database/ultimatix_dao.dart';

class IsolateApiFormData {
  final RootIsolateToken token;
  final dio.FormData formData;
  final SendPort answerPort;
  final String apiUrl;

  IsolateApiFormData({required this.token, required this.formData, required this.answerPort, required this.apiUrl});
}

class IsolateDb {
  final RootIsolateToken token;
  final UltimatixDao dao;
  String s;
  final SendPort answerPort;

  IsolateDb({required this.token, required this.dao, required this.s, required this.answerPort});
}

class IsolateDataStore {
  final RootIsolateToken token;
  final UltimatixDao dao;
  ClockInOutEntity entity;

  IsolateDataStore({required this.token, required this.dao, required this.entity});
}

class IsolateLocationData {
  final RootIsolateToken token;
  final SendPort answerPort;

  IsolateLocationData({required this.token, required this.answerPort,});
}

class IsolatePostApiData {
  final RootIsolateToken token;
  final Map<String, dynamic> requestData;
  final SendPort answerPort;
  final String apiUrl;

  IsolatePostApiData({required this.token, required this.requestData, required this.answerPort, required this.apiUrl});
}

class IsolateGetApiData {
  final RootIsolateToken token;
  final SendPort answerPort;
  final String apiUrl;

  IsolateGetApiData({required this.token, required this.answerPort, required this.apiUrl});
}