import 'dart:async';
import 'dart:io';
//import 'package:http/http.dart' as http;

import 'package:quick_shelter/models/GetProfileResponse.dart';
import 'package:quick_shelter/models/LoginResponse.dart';
import 'package:quick_shelter/models/SignUpResponse.dart';
import 'package:quick_shelter/models/UpdateProfileResponse.dart';
import 'package:quick_shelter/models/UploadIdResponse.dart';
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
      <String, String>{
        'Email': email,
        'Password': password,
      },
    );
    return LoginResponse.fromJson(response);
  }

  Future<SignUpResponse> signUpData(String firstname, String surName,
      String phoneNum, String email, String password) async {
    final response = await _provider.post(
      "auth/signup",
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

  Future<SignUpResponse> addProperty(String firstname, String surName,
      String phoneNum, String email, String password) async {
    final response = await _provider.post(
      "auth/signup",
      <String, Object>{
        'Type': firstname,
        'Location': surName,
        'Adddress': phoneNum,
        'Description': email,
        'State': password,
        'Country': password,
        'LandArea': password,
        "Specifications": {
          "NO_OF_ROOMS": 3,
          "NO_OF_FLOORS": 3,
          "HAS_SWIMMING_POOL": true
        },
        "addListing": phoneNum,
        "Listing": {
          "ListingType": "FOR RENT",
          "AvailableFrom": "01-12-2020",
          "MinPeriod": "3",
          "PeriodUnits": "YEAR"
        }
      },
    );
    return SignUpResponse.fromJson(response);
  }

  Future<UpdateProfileResponse> updateProfile(
      String firstname, String surName, String phoneNum, String email) async {
    final response = await _provider.put(
      "user/profile",
      <String, String>{
        'FirstName': firstname,
        'SurName': surName,
        'PhoneNumber': phoneNum,
        'Email': email,
      },
    );
    return UpdateProfileResponse.fromJson(response);
  }

  Future<ValidatePhone> validatePhone(String phoneNum, String code) async {
    final response = await _provider.get("validate-phone/$phoneNum/$code");
    return ValidatePhone.fromJson(response);
  }

  Future<GetProfileResponse> getProfile() async {
    final response = await _provider.get(
      "user/profile",
    );
    return GetProfileResponse.fromJson(response);
  }

  Future<UploadIdResponse> uploadId(File file, String fileType) async {
    final response =
        await _provider.uploadFile(file, "user/update/national-id", fileType);
    return UploadIdResponse.fromJson(response);
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
