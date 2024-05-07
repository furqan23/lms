// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/data/app_exceptions.dart';
import 'package:splashapp/data/network/base_api_service.dart';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/data/app_exceptions.dart';
import 'package:splashapp/data/network/base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future<dynamic> getApi(String url, {Map<String, String>? headers}) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responsJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers, // Include headers if provided
      ).timeout(const Duration(seconds: 20));
      responsJson = returnResponse(response);
    } on SocketException {
      throw InternetExpception('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }

    return responsJson;
  }

  @override
  Future<dynamic> postApi(var data, String url, {Map<String, String>? headers}) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }
    dynamic responsJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers, // Include headers if provided
        body: data,
      ).timeout(const Duration(seconds: 20));
      responsJson = returnResponse(response);
    } on SocketException {
      throw InternetExpception('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responsJson);
    }
    return responsJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responsJson = jsonDecode(response.body);
        return responsJson;
      case 400:
        dynamic responsJson = jsonDecode(response.body);
        throw InvalidUrlExpection;
      case 404:
        dynamic responsJson = jsonDecode(response.body);
        throw EmailExpection("Email is Already register");
      default:
        throw FetchDataExpection(
            'Error occur communicating with server${response.statusCode}');
    }
  }
}
