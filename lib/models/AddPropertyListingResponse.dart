class AddPropertyListingResponse {
  final String message;
  final String code;

  AddPropertyListingResponse({this.message, this.code});

  factory AddPropertyListingResponse.fromJson(Map<String, dynamic> json) {
    return AddPropertyListingResponse(message: json['message'], code: json['code']);
  }
}
