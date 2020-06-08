import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomException.dart';

class ApiProvider {
  final String _baseUrl = "https://quick-shelter.herokuapp.com/api/";
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();

  

  String token;

  getTokenPref() async {
    token = await _sharedPreferenceQS.getSharedPrefs(String, 'accessToken');
  }



  Future<dynamic> get(String url) async {
    var responseJson;
    await getTokenPref();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    try {
      final response = await http.get(_baseUrl + url, headers: headers);
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

  Future<Map<String, dynamic>> uploadFile(
      File image, String url, String fileType) async {   

    await getTokenPref();
//    var uri = Uri.parse(_baseUrl + url);
//    var request = http.MultipartRequest('POST', uri)
//      ..fields['uploadfile'] = image.path
//      ..fields['type'] = 'NationalID'
//      ..files.add(await http.MultipartFile.fromPath('image', image.path,
//          contentType: MediaType('image', 'jpeg')));
//    request.headers.addAll(headers);
//    //var response = await request.send();
//    final streamedResponse = await request.send();
//    final response = await http.Response.fromStream(streamedResponse);
//    print(response);
    // if (response.statusCode == 200) print('Uploaded!');

    // Find the mime type of the selected file by looking at the header bytes of the file
     final mimeTypeData =
         lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
     // Intilize the multipart request
     final imageUploadRequest =
         http.MultipartRequest('POST', Uri.parse(_baseUrl + url));
     // Attach the file in the request
     final file = await http.MultipartFile.fromPath('uploadfile', image.path,
         contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
     // Explicitly pass the extension of the image with request body
     // Since image_picker has some bugs due which it mixes up
     // image extension with file name like this filenamejpge
     // Which creates some problem at the server side to manage
     // or verify the file extension
    // imageUploadRequest.fields['uploadfile'] = image.path;
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
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
