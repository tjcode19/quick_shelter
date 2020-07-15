class AddSavedListing {
  final String message;

  AddSavedListing({this.message, });

  factory AddSavedListing.fromJson(Map<String, dynamic> json) {
    return AddSavedListing(
      message: json['message'],
    );
  }

  
}