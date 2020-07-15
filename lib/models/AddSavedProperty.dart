class AddSavedProperty {
  final String message;

  AddSavedProperty({this.message, });

  factory AddSavedProperty.fromJson(Map<String, dynamic> json) {
    return AddSavedProperty(
      message: json['message'],
    );
  }

  
}