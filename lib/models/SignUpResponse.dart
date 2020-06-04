class SignUpResponse {
  final String accessToken;
  final String message;

  SignUpResponse({ this.accessToken, this.message});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      accessToken: json['accessToken'],
      message: json['message'],
    );
  }

  
}