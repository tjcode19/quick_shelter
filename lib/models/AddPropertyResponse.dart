class AddPropertyResponse {
  String responseMessage;
  String responseCode;
  Data data;

  AddPropertyResponse({this.responseMessage, this.responseCode, this.data});

  AddPropertyResponse.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseMessage'] = this.responseMessage;
    data['responseCode'] = this.responseCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String code;
  String message;
  int propertyID;

  Data({this.code, this.message, this.propertyID});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    propertyID = json['propertyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['propertyID'] = this.propertyID;
    return data;
  }
}
