import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:github_flutter_redux/domain/exceptions.dart';
import 'package:http/http.dart' as http;

class AppClient {
  final _baseUrl = 'https://api.github.com/';
  final _headers = <String, String>{'Accept': 'application/vnd.github.v3+json'};

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + url), headers: _headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        debugPrint(responseJson.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
