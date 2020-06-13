class LoginResponse {
  final bool auth;
  final String accessToken;
  final String message;
  final String code;

  LoginResponse({this.auth, this.accessToken, this.message, this.code});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      auth: json['auth'],
      accessToken: json['accessToken'],
      message: json['message'],
      code: json['code']
    );
  }

  
}