import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'CustomException.dart';

class ApiProvider {
  final String _baseUrl = "https://quick-shelter.herokuapp.com/api/";

  Future<dynamic> get(String url, Map headerValue) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map headerValue, Map body) async {
    var responseJson;
    try {
      final response = await http.post(
        _baseUrl + url,
        headers: headerValue,
        body: jsonEncode(body),
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

//   Future<http.Response> createAlbum(String title) {
//   return http.post(
//     'https://jsonplaceholder.typicode.com/albums',
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );
// }

  dynamic _response(http.Response response) {
    
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      //throw BadRequestException(response.body.toString());
      case 401:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 403:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
        //throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
