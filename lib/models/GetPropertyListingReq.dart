class GetPropertyListingReq {
  final List<GetPropertyListingReqM> getPropertyReqs;

  GetPropertyListingReq({
    this.getPropertyReqs,
  });

  factory GetPropertyListingReq.fromJson(List<dynamic> parsedJson) {
    List<GetPropertyListingReqM> getPropertyReqs =
        new List<GetPropertyListingReqM>();
    getPropertyReqs =
        parsedJson.map((i) => GetPropertyListingReqM.fromJson(i)).toList();

    return new GetPropertyListingReq(getPropertyReqs: getPropertyReqs);
  }
}

class GetPropertyListingReqM {
  final int id;
  final String name;
  final String description;
  final String type;
  final String value;
  final String dateAdded;
  final String isActive;
  final String createdAt;
  final String updatedAt;
   bool status;

  GetPropertyListingReqM(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.value,
      this.dateAdded,
      this.isActive,
      this.createdAt,
      this.updatedAt, this.status});

  factory GetPropertyListingReqM.fromJson(Map<String, dynamic> json) {
    return GetPropertyListingReqM(
      id: json['ID'],
      name: json['Name'],
      description: json['Description'],
      type: json['Type'],
      value: json['Value'],
      dateAdded: json['DateAdded'],
      isActive: json['IsActvie'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: false,
    );
  }
}
