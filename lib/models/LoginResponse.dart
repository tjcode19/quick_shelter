import 'dart:convert';

class LoginResponse {
  final bool auth;
  final String accessToken;
  final String message;
  final String code;
  final User user;

  LoginResponse(
      {this.auth, this.accessToken, this.message, this.code, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        auth: json['auth'],
        accessToken: json['accessToken'],
        message: json['message'],
        code: json['code'],
        user: User.fromJson(json['user']));
  }
}

class User {
  final String firstName;

  User({this.firstName});
  factory User.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return User(firstName: json['FirstName']);
    } else {
      return null;
    }
  }
}
