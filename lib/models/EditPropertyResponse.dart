class EditPropertyResponse {
  final String message;
  final String code;

  EditPropertyResponse({
    this.message,
    this.code,
  });

  factory EditPropertyResponse.fromJson(Map<String, dynamic> json) {
    return EditPropertyResponse(
      message: json['message'],
      code: json['code'],
    );
  }
}
