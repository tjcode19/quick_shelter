class LoginResponse {
  final bool auth;
  final String accessToken;

  LoginResponse({this.auth, this.accessToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      auth: json['auth'],
      accessToken: json['accessToken'],
    );
  }

  
}