class AddPropertyResponse {
  final String message;
  final String code;
  final int propertyID;

  AddPropertyResponse({this.message, this.code, this.propertyID});

  factory AddPropertyResponse.fromJson(Map<String, dynamic> json) {
    return AddPropertyResponse(message: json['message'], code: json['code'], propertyID:json['propertyID'] );
  }
}
