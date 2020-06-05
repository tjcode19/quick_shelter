import 'dart:async';
//import 'package:http/http.dart' as http;

import 'package:quick_shelter/models/LoginResponse.dart';
import 'package:quick_shelter/models/SignUpResponse.dart';
import 'package:quick_shelter/models/ValidatePhone.dart';
import 'package:quick_shelter/network/ApiProvider.dart';

class QuickShelterRepository {
  ApiProvider _provider = ApiProvider();

  var headerValue = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<LoginResponse> loginData(String email, String password) async {
    final response = await _provider.post(
      "auth/signin",
      headerValue,
      <String, String>{
        'Email': email,
        'Password': password,
      },
    );
    return LoginResponse.fromJson(response);
  }

  Future<SignUpResponse> signUpData(String firstname, String surName, String phoneNum, String email, String password) async {
    final response = await _provider.post(
      "auth/signup",
      headerValue,
      <String, String>{
        'FirstName': firstname,
        'SurName': surName,
        'PhoneNumber': phoneNum,
        'Email': email,
        'Password': password,
      },
    );
    return SignUpResponse.fromJson(response);
  }  

  Future<ValidatePhone> validatePhone(String phoneNum, String code) async {
    final response = await _provider.get(
      "validate-phone/$phoneNum/$code",
      headerValue,
    );
    return ValidatePhone.fromJson(response);
  }

//   Future<LoginResponse> createAlbum(String email, String password) async {
//   final http.Response response = await http.post(
//     'https://quick-shelter.herokuapp.com/api/auth/signin',
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'Email': email,
//       'Password':password
//     }),
//   );
//   if (response.statusCode == 200) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     print('DOne!');
//     return LoginResponse.fromJson(json.decode(response.body));

//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }


}
