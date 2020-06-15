class GetPropertyListingReq {
  final int id;

  GetPropertyListingReq({ this.id});

  factory GetPropertyListingReq.fromJson(Map<String, dynamic> json) {
    return GetPropertyListingReq(
      id: json['ID'],

    );
  }

  
}