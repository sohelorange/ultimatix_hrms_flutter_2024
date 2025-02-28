import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../utility/preference_utils.dart';
import 'app_exceptions.dart';

class DioClient {
  static const int timeOutDuration = 20;

  //TODO : API CALL GET API
  Future<dynamic> get(String baseUrl) async {
    var uri = Uri.parse(baseUrl);
    try {
      var response = await Dio()
          .get(baseUrl,
              options: Options(headers: {
                'Content-Type': 'application/json',
                'accept': '*/*',
                'Authorization': PreferenceUtils.getAuthToken()
              }))
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    } on DioException catch (error) {
      throw handleError(error);
    }
  }

  //TODO : API CALL GET QUERY API
  Future<dynamic> getQueryParam(String baseUrl,
      {Map<String, dynamic>? queryParams}) async {
    var uri = Uri.parse(baseUrl);

    // Append query parameters if they are not null or empty
    if (queryParams != null && queryParams.isNotEmpty) {
      uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    }

    log("API is:$baseUrl");
    log("API Param is:$queryParams");
    log("API Token is:${PreferenceUtils.getAuthToken()}");

    try {
      var response = await Dio()
          .get(uri.toString(),
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': PreferenceUtils.getAuthToken()
                  //'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJMb2dpbl9JRCI6IjIxNzc2IiwiQ21wX0lEIjoiMTg3IiwiRW1wX0lEIjoiMjgyMDEiLCJEZXB0X0lEIjoiNTA1IiwiQWxwaGFfRW1wX0NvZGUiOiIwMDYwIiwiRW1wX0Z1bGxfTmFtZSI6IjAwNjAgLSBNci4gQVAgVEwgUUExMjMiLCJEZXB0X05hbWUiOiJTb2Z0d2FyZSIsIkRlc2lnTmFtZSI6IlNyLiBRQSBUZXN0ZXIiLCJEZXZpY2VUb2tlbiI6InN0cmluZyIsIm5iZiI6MTczNDMzMDY5OCwiZXhwIjoxNzM2OTIyNjk4LCJpYXQiOjE3MzQzMzA2OTh9.0uSHMch3XEPW2x60voEaGdNR9nTgBcSIg5nhm-qGOow'
                },
              ))
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    } on DioException catch (error) {
      throw handleError(error);
    }
  }

  //TODO : API CALL FOR FormData POST API
  Future<dynamic> postFormData(String url, FormData payloadObj) async {
    var uri = Uri.parse(url);
    /*var payload = json.encode(payloadObj);*/
    log("API is:$url");
    log("API Param is:$payloadObj");
    log("API Token is:${PreferenceUtils.getAuthToken()}");
    try {
      var response = await Dio()
          .post(url,
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': PreferenceUtils.getAuthToken()
                  //'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJMb2dpbl9JRCI6IjIxNzc2IiwiQ21wX0lEIjoiMTg3IiwiRW1wX0lEIjoiMjgyMDEiLCJEZXB0X0lEIjoiNTA1IiwiQWxwaGFfRW1wX0NvZGUiOiIwMDYwIiwiRW1wX0Z1bGxfTmFtZSI6IjAwNjAgLSBNci4gQVAgVEwgUUExMjMiLCJEZXB0X05hbWUiOiJTb2Z0d2FyZSIsIkRlc2lnTmFtZSI6IlNyLiBRQSBUZXN0ZXIiLCJEZXZpY2VUb2tlbiI6InN0cmluZyIsIm5iZiI6MTczNDMzMDY5OCwiZXhwIjoxNzM2OTIyNjk4LCJpYXQiOjE3MzQzMzA2OTh9.0uSHMch3XEPW2x60voEaGdNR9nTgBcSIg5nhm-qGOow'
                },
              ),
              data: payloadObj)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    } on DioException catch (error) {
      throw handleError(error);
    }
  }

  //TODO : API CALL FOR POST API
  Future<dynamic> post(String url, Map<String, dynamic> requestParam) async {
    var uri = Uri.parse(url);
    log("API is:$url");
    log("API Param is:$requestParam");
    log("API Token is:${PreferenceUtils.getAuthToken()}");
    /*var payload = json.encode(requestParam);*/
    try {
      var response = await Dio()
          .post(url,
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                  'accept': '*/*',
                  'Authorization': PreferenceUtils.getAuthToken()
                  //'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJMb2dpbl9JRCI6IjIxNzc0IiwiQ21wX0lEIjoiMTg3IiwiRW1wX0lEIjoiMjgxOTkiLCJEZXB0X0lEIjoiNTA1IiwiQWxwaGFfRW1wX0NvZGUiOiIwMDU4IiwiRW1wX0Z1bGxfTmFtZSI6IjAwNTggLSBNci4gQVAgQk0iLCJEZXB0X05hbWUiOiJTb2Z0d2FyZSIsIkRlc2lnTmFtZSI6Ik1BTkFHRVIiLCJEZXZpY2VUb2tlbiI6IjZkM2E1YzNlY2UwNGFlNWEiLCJuYmYiOjE3MzUyMTEwMTEsImV4cCI6MTczNzgwMzAxMSwiaWF0IjoxNzM1MjExMDExfQ.zLvbLxT_ly1Qu6nb5S0gimGy1mOmOJdw8m3Hx5plwVk'
                },
              ),
              data: requestParam)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    } on DioException catch (error) {
      throw handleError(error);
    }
  }

  Future<dynamic> postQuery(String url, {Map<String, dynamic>? queryParams}) async {
    var uri = Uri.parse(url);
    log("API is:$url");
    log("API Param is:$queryParams");
    log("API Token is:${PreferenceUtils.getAuthToken()}");

    try {
      var response = await Dio()
          .post(
        uri.toString(), // Use the URI string directly
        queryParameters: queryParams, // Pass query parameters
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'accept': '*/*',
            'Authorization': PreferenceUtils.getAuthToken(),
          },
        ),
      ).timeout(const Duration(seconds: timeOutDuration));

      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    } on DioException catch (error) {
      throw handleError(error);
    }
  }

  //OTHER
  dynamic _processResponse(response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        //case 404:
        //PreferenceUtils.clearAllPreferences();
        //PreferenceUtils.setIsLogin(false);
        //Get.offAll(() =>const LoginViewNewScreen());
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }

  dynamic handleError(DioException error) {
    if (error.response != null) {
      switch (error.response!.statusCode) {
        case 400:
          throw BadRequestException(error.response!.data.toString(),
              error.requestOptions.uri.toString());
        case 401:
        case 403:
          //case 404:
          //PreferenceUtils.clearAllPreferences();
          //PreferenceUtils.setIsLogin(false);
          //Get.offAll(() =>const LoginViewNewScreen());
          throw UnAuthorizedException(error.response!.data.toString(),
              error.requestOptions.uri.toString());
        case 500:
        default:
          throw FetchDataException(
              'Error occurred with code : ${error.response!.statusCode}',
              error.requestOptions.uri.toString());
      }
    } else {
      throw FetchDataException('Error occurred with message : ${error.message}',
          error.requestOptions.uri.toString());
    }
  }
}
