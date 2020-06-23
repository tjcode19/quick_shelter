import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';

import 'CustomException.dart';

class ApiProvider {
  final String _baseUrl = "https://quick-shelter.herokuapp.com/api/";
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();

  

  String token;
  Map<String, String> headers;

  getTokenPref() async {
    token = await _sharedPreferenceQS.getSharedPrefs(String, 'accessToken');

    headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
  }



  Future<dynamic> get(String url) async {
    var responseJson;
    await getTokenPref();
    try {
      final response = await http.get(_baseUrl + url, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> post(String url,Map body) async {
    var responseJson;
    await getTokenPref();
    try {
      final response = await http.post(
        _baseUrl + url,
          headers: headers,
        body: jsonEncode(body),
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, Map body) async {
    var responseJson;
    await getTokenPref();
    try {
      final response = await http.put(
        _baseUrl + url,
        headers: headers,
        body: jsonEncode(body),
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> uploadFile(
      File image, String url, String fileType, String docName, String actionType) async {

    print(url);

    await getTokenPref();
    // Find the mime type of the selected file by looking at the header bytes of the file
     final mimeTypeData =
         lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
     // Intilize the multipart request
     final imageUploadRequest =
         http.MultipartRequest(actionType, Uri.parse(_baseUrl + url));
     // Attach the file in the request
     final file = await http.MultipartFile.fromPath(docName, image.path,
         contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
     imageUploadRequest.fields['type'] = fileType;
     //imageUploadRequest.headers.addAll(headers);
     imageUploadRequest.files.add(file);

     imageUploadRequest.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
     try {
       final streamedResponse = await imageUploadRequest.send();
       final response = await http.Response.fromStream(streamedResponse);
       var responseData = _response(response);
       // if (response.statusCode != 200) {
       //   return null;
       // }
       //final Map<String, dynamic> responseData = json.decode(response.body);
       //_resetState();
       return responseData;
     } catch (e) {
       print(e);
       return null;
     }
  }


  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;     

      default:
         var responseJson = json.decode(response.body.toString());
        print(response);
        return responseJson;
    }
  }
}
