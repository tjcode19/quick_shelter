class SignUpResponse {
  final String accessToken;
  final String message;
  final String code;

  SignUpResponse({ this.accessToken, this.message, this.code});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      accessToken: json['accessToken'],
      message: json['message'],
      code: json['code']
    );
  }

  
}