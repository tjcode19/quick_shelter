class AddSavedProperty {
  final bool auth;
  final String accessToken;
  final String message;
  final String code;

  AddSavedProperty({this.auth, this.accessToken, this.message, this.code});

  factory AddSavedProperty.fromJson(Map<String, dynamic> json) {
    return AddSavedProperty(
      auth: json['auth'],
      accessToken: json['accessToken'],
      message: json['message'],
      code: json['code']
    );
  }

  
}