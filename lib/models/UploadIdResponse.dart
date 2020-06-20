import 'dart:convert';

class UploadIdResponse {
  final String message;
  final String code;

  UploadIdResponse({this.message, this.code});

  factory UploadIdResponse.fromJson(Map<String, dynamic> json) {
    return UploadIdResponse(
      message: json['message'],
      code:json['code']
    );
  }

  
}