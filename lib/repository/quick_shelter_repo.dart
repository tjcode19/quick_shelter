import 'dart:async';
import 'dart:io';
//import 'package:http/http.dart' as http;

import 'package:quick_shelter/models/AddPropertyResponse.dart';
import 'package:quick_shelter/models/GetAllProperties.dart';
import 'package:quick_shelter/models/GetProfileResponse.dart';
import 'package:quick_shelter/models/GetPropertyListingReq.dart';
import 'package:quick_shelter/models/GetSingleProperty.dart';
import 'package:quick_shelter/models/GetSinglePropertyListing.dart';
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

  Future<LoginResponse> addSavedProperty(int prodID) async {
    final response = await _provider.post(
      "save-properties",
      <String, dynamic>{
        'propertyID': prodID,
      },
    );
    return LoginResponse.fromJson(response);
  }

  Future<AddPropertyResponse> addProperty(Map data) async {
    final response = await _provider.post(
      "add-property",
     // {}
      <String, Object>{
        'Type': data['Type'],
        'Location': data['Location'],
        'Adddress': data['Adddress'],
        'Description': data['Description'],
        'State': data['State'],
        'Country': data['Country'],
        'LandArea': data['LandArea'],
        "Specifications": {
          "NO_OF_LIVINGROOMS":2,
          "NO_OF_ROOMS": 3,
          "NO_OF_FLOORS": 3,
          "HAS_SWIMMING_POOL": true
        },
        "addListing": data['addListing'],
        "Listing": {
          "ListingType": data['addListing'],
          "IS_AVAILABLE": data['IS_AVAILABLE'],
          "MinPeriod": data['addListing'],
          "PeriodUnits": data['addListing']
        }
      },
    );
    return AddPropertyResponse.fromJson(response);
  }
  
  Future<AddPropertyResponse> addPropertyListing(String lType, String availableFrom, String minP, String pUnits) async {
    final response = await _provider.post(
      "add-listing",
      <String, Object>{
        'PropertyID': 0,
        'ListingType': lType,
        'AvailableFrom': availableFrom,
        'MinPeriod': minP,
        'PeriodUnits': pUnits,
      },
    );
    return AddPropertyResponse.fromJson(response);
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

  Future<GetProfileResponse> getSavedProperties() async {
    final response = await _provider.get(
      "saved-properties",
    );
    return GetProfileResponse.fromJson(response);
  }

  Future<GetProfileResponse> getUserProperties() async {
    final response = await _provider.get(
      "user-properties",
    );
    return GetProfileResponse.fromJson(response);
  }

  Future<GetAllProperties> getAllProperties() async {
    final response = await _provider.post(
      "search-listing",
      <String, String>{
        'ListingType': 'FOR RENT',
      },
    );
    print(response);
    return GetAllProperties.fromJson(response);
  }

  Future<GetSingleProperty> getSingleProperty(String propID) async {
    final response = await _provider.get(
      "get-property/$propID",
    );
    return GetSingleProperty.fromJson(response);
  }

  Future<GetSinglePropertyListing> getSinglePropertyListing(String listingID) async {
    final response = await _provider.get(
      "get-listing/$listingID",
    );
    return GetSinglePropertyListing.fromJson(response);
  }

  Future<GetPropertyListingReq> getPropertyListingReq(String type) async {
    final response = await _provider.get(
      "get-listing-requirements/$type",
    );
    return GetPropertyListingReq.fromJson(response);
  }

  Future<UploadIdResponse> uploadId(File file, String fileType) async {
    print('Maind');
    final response =
        await _provider.uploadFile(file, "user/update/national-id", fileType, 'uploadfile', 'POST');
    return UploadIdResponse.fromJson(response);
  }

  Future<UploadIdResponse> uploadPropDocs(File file, String fileType, String docName, int propertyId) async {
    print('Main2$propertyId');
    final response =
        await _provider.uploadFile(file, "property/documents/$propertyId", fileType, docName, 'PUT');
    return UploadIdResponse.fromJson(response);
  }

  Future<UploadIdResponse> uploadPropPictures(File file, String fileType, String docName, int propertyId) async {
    print('Main$propertyId');
    final response =
        await _provider.uploadFile(file, "property/photos/$propertyId", fileType, docName, 'PUT');
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
