import 'dart:async';
import 'dart:io';
//import 'package:http/http.dart' as http;

import 'package:quick_shelter/models/AddPropertyResponse.dart';
import 'package:quick_shelter/models/AddSavedListing.dart';
import 'package:quick_shelter/models/EditPropertyResponse.dart';
import 'package:quick_shelter/models/GetAllProperties.dart';
import 'package:quick_shelter/models/GetProfileResponse.dart';
import 'package:quick_shelter/models/GetPropertyDocs.dart';
import 'package:quick_shelter/models/GetPropertyListingReq.dart';
import 'package:quick_shelter/models/GetPublicProperties.dart';
import 'package:quick_shelter/models/GetSavedProperties.dart';
import 'package:quick_shelter/models/GetSingleProperty.dart';
import 'package:quick_shelter/models/GetSinglePropertyListing.dart';
import 'package:quick_shelter/models/GetUserProperties.dart';
import 'package:quick_shelter/models/LoginResponse.dart';
import 'package:quick_shelter/models/PaymentResponse.dart';
import 'package:quick_shelter/models/SignUpResponse.dart';
import 'package:quick_shelter/models/TransactionListResponse.dart';
import 'package:quick_shelter/models/TransactionStatusResponse.dart';
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

  Future<LoginResponse> requestOtp(String email) async {
    final response = await _provider.get(
      "user/request-otp"
    );
    return LoginResponse.fromJson(response);
  }

  Future<TransactionStatusResponse> checkTransaction(String transactionID) async {
    final response = await _provider.get(
      "verify-transaction/$transactionID"
    );
    return TransactionStatusResponse.fromJson(response);
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
      "save-property",
      <String, dynamic>{
        'propertyID': prodID,
      },
    );
    return LoginResponse.fromJson(response);
  }

  Future<AddSavedListing> addSavedListing(int prodID) async {
    final response = await _provider.post(
      "save-listing",
      <String, dynamic>{
        'listingID': prodID,
      },
    );
    return AddSavedListing.fromJson(response);
  }

  Future<AddPropertyResponse> addProperty(Map data) async {
    final response = await _provider.post(
      "add-property",
      <String, Object>{
        'Type': data['Type'],
        "Title": data['Title'],
        'Location': data['Location'],
        'Adddress': data['Adddress'],
        'Description': data['Description'],
        'State': data['State'],
        'Country': data['Country'],
        'LandArea': data['LandArea'],
        "Specifications": {
          "NO_OF_LIVINGROOMS": data['Specifications']['NO_OF_LIVINGROOMS'],
          "NO_OF_BEDROOMS": data['Specifications']['NO_OF_BEDROOMS'],
          "NO_OF_FLOORS": data['Specifications']['NO_OF_FLOORS'],
          "NO_OF_BATHROOMS": data['Specifications']['NO_OF_BATHROOMS'],
          "HAS_SWIMMING_POOL": data['Specifications']['HAS_SWIMMING_POOL']
        }
        // "addListing": data['addListing'],
        // "Listing": {
        //   "ListingType": data['Listing']['ListingType'],
        //   "IS_AVAILABLE": data['Listing']['IS_AVAILABLE'],
        //   "MinPeriod": data['Listing']['MinPeriod'],
        //   "PeriodUnits": data['Listing']['PeriodUnits']
        // }
      },
    );
    return AddPropertyResponse.fromJson(response);
  }

  Future<EditPropertyResponse> editProperty(Map data, String propertyID) async {
    final response = await _provider.put(
      "edit-property/$propertyID",
      <String, Object>{
        'Type': data['Type'],
        "Title": data['Title'],
        'Location': data['Location'],
        'Address': data['Address'],
        'Description': data['Description'],
        'State': data['State'],
        'Country': data['Country'],
        'LandArea': data['LandArea'],
        "Units": data['Units'],
        "Specifications": {
          "NO_OF_LIVINGROOMS": data['Specifications']['NO_OF_LIVINGROOMS'],
          "NO_OF_BEDROOMS": data['Specifications']['NO_OF_BEDROOMS'],
          "NO_OF_FLOORS": data['Specifications']['NO_OF_FLOORS'],
          "NO_OF_BATHROOMS": data['Specifications']['NO_OF_BATHROOMS'],
          "HAS_SWIMMING_POOL": data['Specifications']['HAS_SWIMMING_POOL']
        },
        // "addListing": data['addListing'],
        // "Listing": {
        //   "ListingType": data['addListing'],
        //   "IS_AVAILABLE": data['IS_AVAILABLE'],
        //   "MinPeriod": data['addListing'],
        //   "PeriodUnits": data['addListing']
        // }
      },
    );
    return EditPropertyResponse.fromJson(response);
  }

  Future<AddPropertyResponse> addPropertyListing(
      Map data, String propertyID) async {
    final response = await _provider.post(
      "add-listing",
      <String, Object>{
        'PropertyID': propertyID,
        'ListingType': data['ListingType'],
        'AvailableFrom': data['AvailableFrom'],
        'MinPeriod': data['MinPeriod'],
        'PeriodUnits': data['PeriodUnits'],
        'Price': data['Price'],
        'IS_AVAILABLE': data['IS_AVAILABLE']
      },
    );
    return AddPropertyResponse.fromJson(response);
  }

  Future<AddPropertyResponse> editPropertyListing(
      Map data, String listingID) async {
    final response = await _provider.put(
      "edit-listing/$listingID",
      <String, Object>{
        'ListingType': data['ListingType'],
        'AvailableFrom': data['AvailableFrom'],
        'MinPeriod': data['MinPeriod'],
        'PeriodUnits': data['PeriodUnits'],
        'Price': data['Price'],
        'IS_AVAILABLE': data['IS_AVAILABLE']
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

  Future<UpdateProfileResponse> updatePassword(String password) async {
    final response = await _provider.post(
      "user/change-password",
      <String, String>{
        'Password': password,
      },
    );
    return UpdateProfileResponse.fromJson(response);
  }

  Future<ValidatePhone> validatePhone(String phoneNum, String code) async {
    final response = await _provider.get("validate-phone/$phoneNum/$code");
    return ValidatePhone.fromJson(response);
  }

  Future<ValidatePhone> validateEmail(String phoneNum, String code) async {
    final response = await _provider.get("validate-phone/$phoneNum/$code");
    return ValidatePhone.fromJson(response);
  }

  Future<AddPropertyResponse> deletePhoto(String propertyID) async {
    final response = await _provider.delete("property/photos/$propertyID");
    return AddPropertyResponse.fromJson(response);
  }

   Future<AddPropertyResponse> deletePropListing(String listingID) async {
    final response = await _provider.delete("listing/$listingID");
    return AddPropertyResponse.fromJson(response);
  }

  Future<GetProfileResponse> getProfile() async {
    final response = await _provider.get(
      "user/profile",
    );
    return GetProfileResponse.fromJson(response);
  }

  Future<GetSavedProperties> getSavedProperties(var page, var noPerPage) async {
    final response = await _provider.get(
      "saved-listings/$page/$noPerPage",
    );
    return GetSavedProperties.fromJson(response);
  }

  Future<GetUserProperties> getUserProperties() async {
    final response = await _provider.get(
      "user-properties",
    );
    return GetUserProperties.fromJson(response);
  }

  Future<GetAllProperties> getAllProperties(
      var page, var noPerPage, String startDate, String endDate) async {
    final response = await _provider.put(
      "search-listing/$page/$noPerPage",
      <String, dynamic>{
        "ListingDate": {"startDate": startDate, "endDate": endDate},
        "IS_AVAILABLE": true
      },
    );
    print(response);
    return GetAllProperties.fromJson(response);
  }

  Future<GetPublicProperties> getAllPropLanding(
      var page, var noPerPage, String startDate, String endDate) async {
    final response = await _provider.put(
      "public/search-listing/$page/$noPerPage",
      <String, dynamic>{
        "ListingDate": {"startDate": startDate, "endDate": endDate},
        "IS_AVAILABLE": true
      },
    );
    print(response);
    return GetPublicProperties.fromJson(response);
  }

  Future<GetAllProperties> searchProperty(
      var page,
      var noPerPage,
      String startDate,
      String endDate,
      String minPrice,
      String maxPrice,
      noOfRoom,
      apartmentType,
      listingType,
      state) async {
    var price;
    if (minPrice.isEmpty || maxPrice.isEmpty) {
      price = {};
    } else {
      price = {"min": minPrice, "max": maxPrice};
    }
    final response = await _provider.put(
      "search-listing/$page/$noPerPage",
      <String, dynamic>{
        "ListingDate": {"startDate": startDate, "endDate": endDate},
        "Price": price,
        "NO_OF_BEDROOMS": noOfRoom,
        "PropertyType": apartmentType,
        "ListingType": listingType,
        "IS_AVAILABLE": true,
        "State": state
      },
    );
    print(response);
    return GetAllProperties.fromJson(response);
  }

  Future<GetPublicProperties> searchPropertyPublic(
      var page,
      var noPerPage,
      String startDate,
      String endDate,
      String minPrice,
      String maxPrice,
      noOfRoom,
      apartmentType,
      listingType,
      state) async {
    var price;
    if (minPrice.isEmpty || maxPrice.isEmpty) {
      price = null;
    } else {
      price = {"min": minPrice, "max": maxPrice};
    }
    final response = await _provider.put(
      "public/search-listing/$page/$noPerPage",
      <String, dynamic>{
        "ListingDate": {"startDate": startDate, "endDate": endDate},
        "Price": price,
        // "NO_OF_BEDROOMS": noOfRoom,
        // "PropertyType": apartmentType,
        // "ListingType": listingType,
        // "IS_AVAILABLE": true,
        // "State": state
      },
    );
    return GetPublicProperties.fromJson(response);
  }

  Future<PaymentResponse> doPayment(int listingID) async {
    final response = await _provider.put(
      "pay-listing/$listingID",
      <String, dynamic>{},
    );
    print(response);
    return PaymentResponse.fromJson(response);
  }

  Future<GetSingleProperty> getSingleProperty(String propID) async {
    final response = await _provider.get(
      "get-property/$propID",
    );
    return GetSingleProperty.fromJson(response);
  }

  Future<GetPropertyDoc> getPropertyDocuments(String propID) async {
    final response = await _provider.get(
      "property-documents/$propID",
    );
    return GetPropertyDoc.fromJson(response);
  }

  Future<TransactionListResponse> getTransactionList(
      var page, var pageSize) async {
    final response = await _provider.get(
      "paid-listings/$page/$pageSize",
    );
    return TransactionListResponse.fromJson(response);
  }

  Future<GetSinglePropertyListing> getSinglePropertyListing(
      String listingID) async {
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
    final response = await _provider.uploadFile(
        file, "user/update/national-id", fileType, 'uploadfile', 'POST');
    return UploadIdResponse.fromJson(response);
  }

  Future<UploadIdResponse> uploadPropDocs(
      File file, String fileType, String docName, var propertyId) async {
    final response = await _provider.uploadFile(
        file, 'property/documents/$propertyId', fileType, docName, 'PUT');
    //  print('Inside Life: $docName');
    return UploadIdResponse.fromJson(response);
  }

  Future<UploadIdResponse> uploadPropPictures(
      File file, String fileType, String docName, int propertyId) async {
    print('Main$propertyId');
    final response = await _provider.uploadFile(
        file, "property/photos/$propertyId", fileType, docName, 'PUT');
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
