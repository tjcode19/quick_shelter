class AddPropertyResponse {
  final String message;
  final String code;

  AddPropertyResponse({this.message, this.code});

  factory AddPropertyResponse.fromJson(Map<String, dynamic> json) {
    return AddPropertyResponse(message: json['message'], code: json['code']);
  }
}
