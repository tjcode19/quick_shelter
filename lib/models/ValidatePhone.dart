class ValidatePhone {
  final String message;

  ValidatePhone({this.message});

  factory ValidatePhone.fromJson(Map<String, dynamic> json) {
    return ValidatePhone(
      message: json['message'],
    );
  }

  
}