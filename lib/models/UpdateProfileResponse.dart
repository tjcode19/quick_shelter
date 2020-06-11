class UpdateProfileResponse {
  final String message;
  final String code;

  UpdateProfileResponse({this.message, this.code});

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      message: json['message'],
      code: json['code'],
    );
  }

  
}