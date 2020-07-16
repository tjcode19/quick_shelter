class GetPropertyListingReq {
  int count;
  List<Data> data;
  String responseMessage;
  String responseCode;

  GetPropertyListingReq(
      {this.count, this.data, this.responseMessage, this.responseCode});

  GetPropertyListingReq.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['responseMessage'] = this.responseMessage;
    data['responseCode'] = this.responseCode;
    return data;
  }
}

class Data {
  int iD;
  String name;
  String description;
  String type;
  String value;
  String dateAdded;
  bool isActvie;
  String createdAt;
  String updatedAt;
  bool status;

  Data(
      {this.iD,
      this.name,
      this.description,
      this.type,
      this.value,
      this.dateAdded,
      this.isActvie,
      this.createdAt,
      this.updatedAt, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    description = json['Description'];
    type = json['Type'];
    value = json['Value'];
    dateAdded = json['DateAdded'];
    isActvie = json['IsActvie'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status =  false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Type'] = this.type;
    data['Value'] = this.value;
    data['DateAdded'] = this.dateAdded;
    data['IsActvie'] = this.isActvie;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
