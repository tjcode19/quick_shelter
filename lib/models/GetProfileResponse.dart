class GetProfileResponse {
  final int id;
  final String firstName;
  final String surName;
  final String middleName;
  final String phoneNumber;
  final String email;
  final String password;
  final String DOB;
  final String USER_TYPE;
  final String NationalID;
  final String isEmailVerified;  
  final String isProfileReviewed;  

  GetProfileResponse({this.firstName, this.surName, this.middleName, this.phoneNumber, this.email, this.password, this.DOB, this.USER_TYPE, this.NationalID, this.isEmailVerified, this.isProfileReviewed, this.id});

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      id: json['ID'],
      firstName: json['FirstName'],
      surName: json['SurName'],
      middleName: json['MiddleName'],
      phoneNumber: json['PhoneNumber'],
      email: json['Email'],
      password: json['Password'],

    );
  }

  
}