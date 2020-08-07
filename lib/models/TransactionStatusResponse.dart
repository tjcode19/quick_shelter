class TransactionStatusResponse {
  String responseMessage;
  String responseCode;
  Data data;

  TransactionStatusResponse(
      {this.responseMessage, this.responseCode, this.data});

  TransactionStatusResponse.fromJson(Map<String, dynamic> json) {
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
  int iD;
  String transactionID;
  String status;
  String gatewayResponse;
  String createdAt;

  Data(
      {this.iD,
      this.transactionID,
      this.status,
      this.gatewayResponse,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    transactionID = json['TransactionID'];
    status = json['Status'];
    gatewayResponse = json['GatewayResponse'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TransactionID'] = this.transactionID;
    data['Status'] = this.status;
    data['GatewayResponse'] = this.gatewayResponse;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
