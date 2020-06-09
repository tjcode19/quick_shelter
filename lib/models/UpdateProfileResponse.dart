class UpdateProfileResponse {
  final String message;

  UpdateProfileResponse({this.message});

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      message: json['message'],
    );
  }

  
}