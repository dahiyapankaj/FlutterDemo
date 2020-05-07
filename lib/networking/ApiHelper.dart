import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'AppException.dart';

class ApiHelper {
  final String _baseUrl = "https://jsonplaceholder.typicode.com";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);

      print("myflutter.....url was " + _baseUrl + url);
      print("myflutter.....response is " + response.body.length.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    print("myflutter.....response code is " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
//        var responseJson = json.decode(response.body.toString());
//        print("printing "+responseJson);
//        print(responseJson);
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
