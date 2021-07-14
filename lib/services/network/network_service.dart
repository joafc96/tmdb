// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import '../../utils/tmdb_configs.dart';
import 'custom_exceptions.dart';

class ApiService {
  static Future<http.Response> get({@required String uri}) async {
    http.Response responseJson;
    try {
      final Uri url = Uri.parse(uri);

      final response =
          await http.get(url).timeout(const Duration(seconds: timeOutDuration));
      responseJson = _response(response);
    } on SocketException {
      throw InternetConnectionException("No Internet Connection");
    } on TimeoutException {
      throw InternetConnectionException("No Internet Connection");
    } on FormatException{
      throw BadFormatException("Bad Format From Response");
    }
    return responseJson;
  }

  static Future<http.Response> post(
      {@required String uri,
      Map<String, dynamic> body,
      String stringBody,
      Map<String, String> headers}) async {
    http.Response responseJson;
    try {
      final Uri url = Uri.parse(uri);

      http.Response response;
      if (headers != null) {
        response = response = await http
            .post(url, headers: headers, body: stringBody ?? body)
            .timeout(const Duration(seconds: timeOutDuration));
      } else if (body != null) {
        response = await http
            .post(url, body: stringBody ?? body)
            .timeout(const Duration(seconds: timeOutDuration));
      } else {
        response = await http
            .post(url)
            .timeout(const Duration(seconds: timeOutDuration));
      }
      responseJson = _response(response);
    } on SocketException {
      throw InternetConnectionException("No Internet Connection");
    } on TimeoutException {
      throw InternetConnectionException("No Internet Connection");
    }
    return responseJson;
  }

  static Future<http.Response> delete(
      {@required String uri, @required Map<String, String> headers}) async {
    http.Response responseJson;
    try {
      final Uri url = Uri.parse(uri);

      final response = await http
          .delete(url, headers: headers)
          .timeout(const Duration(seconds: timeOutDuration));
      responseJson = _response(response);
    } on SocketException {
      throw InternetConnectionException("No Internet Connection");
    } on TimeoutException {
      throw InternetConnectionException("No Internet Connection");
    }
    return responseJson;
  }

  static http.Response _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
