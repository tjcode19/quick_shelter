class GetPropertyDoc {
  int count;
  List< PropDocData> data;
  String responseMessage;
  String responseCode;

  GetPropertyDoc(
      {this.count, this.data, this.responseMessage, this.responseCode});

  GetPropertyDoc.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = new List< PropDocData>();
      json['data'].forEach((v) {
        data.add(new  PropDocData.fromJson(v));
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

class PropDocData {
  int iD;
  int refID;
  String type;
  String name;
  String path;
  String description;
  bool isValid;
  String dateAdded;
  String createdAt;
  String updatedAt;

   PropDocData(
      {this.iD,
      this.refID,
      this.type,
      this.name,
      this.path,
      this.description,
      this.isValid,
      this.dateAdded,
      this.createdAt,
      this.updatedAt});

   PropDocData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    refID = json['RefID'];
    type = json['Type'];
    name = json['Name'];
    path = json['Path'];
    description = json['Description'];
    isValid = json['IsValid'];
    dateAdded = json['DateAdded'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['RefID'] = this.refID;
    data['Type'] = this.type;
    data['Name'] = this.name;
    data['Path'] = this.path;
    data['Description'] = this.description;
    data['IsValid'] = this.isValid;
    data['DateAdded'] = this.dateAdded;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
