class LoginResponse {
  String responseMessage;
  String responseCode;
  Data data;

  LoginResponse({this.responseMessage, this.responseCode, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseMessage'] = this.responseMessage;
    data['responseCode'] = this.responseCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String code;
  bool auth;
  String accessToken;
  User user;

  Data({this.code, this.auth, this.accessToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    auth = json['auth'];
    accessToken = json['accessToken'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['auth'] = this.auth;
    data['accessToken'] = this.accessToken;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int iD;
  String firstName;
  String surName;
  String middleName;
  String phoneNumber;
  String email;
  String password;
  String dOB;
  String profilePhoto;
  String uSERTYPE;
  String oTP;
  String nationalID;
  bool isEmailVerified;
  bool isProfileReviewed;
  String createdAt;
  String updatedAt;

  User(
      {this.iD,
      this.firstName,
      this.surName,
      this.middleName,
      this.phoneNumber,
      this.email,
      this.password,
      this.dOB,
      this.profilePhoto,
      this.uSERTYPE,
      this.oTP,
      this.nationalID,
      this.isEmailVerified,
      this.isProfileReviewed,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    firstName = json['FirstName'];
    surName = json['SurName'];
    middleName = json['MiddleName'];
    phoneNumber = json['PhoneNumber'];
    email = json['Email'];
    password = json['Password'];
    dOB = json['DOB'];
    profilePhoto = json['ProfilePhoto'];
    uSERTYPE = json['USER_TYPE'];
    oTP = json['OTP'];
    nationalID = json['NationalID'];
    isEmailVerified = json['isEmailVerified'];
    isProfileReviewed = json['isProfileReviewed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['FirstName'] = this.firstName;
    data['SurName'] = this.surName;
    data['MiddleName'] = this.middleName;
    data['PhoneNumber'] = this.phoneNumber;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['DOB'] = this.dOB;
    data['ProfilePhoto'] = this.profilePhoto;
    data['USER_TYPE'] = this.uSERTYPE;
    data['OTP'] = this.oTP;
    data['NationalID'] = this.nationalID;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isProfileReviewed'] = this.isProfileReviewed;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
