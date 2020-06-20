class GetProfileResponse {
  final int id;
  final String firstName;
  final String surName;
  final String middleName;
  final String phoneNumber;
  final String email;
  final String password;
  final String dob;
  final String userType;
  final String nationalID;
  final String isEmailVerified;  
  final String isProfileReviewed;  
  final String code;

  GetProfileResponse({this.firstName, this.surName, this.middleName, this.phoneNumber, this.email, this.password, this.dob, this.userType, this.nationalID, this.isEmailVerified, this.isProfileReviewed, this.id, this.code});

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      id: json['ID'],
      firstName: json['FirstName'],
      surName: json['SurName'],
      middleName: json['MiddleName'],
      phoneNumber: json['PhoneNumber'],
      email: json['Email'],
      password: json['Password'],
      code: json['code'],
      dob: json['DOB'],
      userType: json['USER_TYPE'],
      nationalID: json['NationalID'],

    );
  }

  
}