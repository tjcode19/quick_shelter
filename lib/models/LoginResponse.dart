class LoginResponse {
  final bool auth;
  final String accessToken;
  final String reason;

  LoginResponse({this.auth, this.accessToken, this.reason});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      auth: json['auth'],
      accessToken: json['accessToken'],
      reason: json['reason'],
    );
  }

  
}