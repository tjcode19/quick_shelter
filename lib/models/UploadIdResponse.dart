class UploadIdResponse {
  final String message;

  UploadIdResponse({this.message});

  factory UploadIdResponse.fromJson(Map<String, dynamic> json) {
    return UploadIdResponse(
      message: json['message'],
    );
  }

  
}