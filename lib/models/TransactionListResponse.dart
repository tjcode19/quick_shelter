class TransactionListResponse {
  int count;
  List<Data> data;
  String responseMessage;
  String responseCode;

  TransactionListResponse(
      {this.count, this.data, this.responseMessage, this.responseCode});

  TransactionListResponse.fromJson(Map<String, dynamic> json) {
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
  bool iSPAID;
  String tRANSACTIONSTATUS;
  int iD;
  int listingID;
  Listing listing;
  int userID;
  int sellerID;
  Seller seller;
  String startDate;
  String endDate;
  int paid;
  int payable;
  var transactionID;
  String createdAt;
  String updatedAt;
  List<Transaction> transaction;

  Data(
      {this.iSPAID,
      this.tRANSACTIONSTATUS,
      this.iD,
      this.listingID,
      this.listing,
      this.userID,
      this.sellerID,
      this.seller,
      this.startDate,
      this.endDate,
      this.paid,
      this.payable,
      this.transactionID,
      this.createdAt,
      this.updatedAt,
      this.transaction});

  Data.fromJson(Map<String, dynamic> json) {
    iSPAID = json['IS_PAID'];
    tRANSACTIONSTATUS = json['TRANSACTION_STATUS'];
    iD = json['ID'];
    listingID = json['ListingID'];
    listing =
        json['Listing'] != null ? new Listing.fromJson(json['Listing']) : null;
    userID = json['UserID'];
    sellerID = json['SellerID'];
    seller =
        json['Seller'] != null ? new Seller.fromJson(json['Seller']) : null;
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    paid = json['Paid'];
    payable = json['Payable'];
    transactionID = json['TransactionID'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['Transaction'] != null) {
      transaction = new List<Transaction>();
      json['Transaction'].forEach((v) {
        transaction.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IS_PAID'] = this.iSPAID;
    data['TRANSACTION_STATUS'] = this.tRANSACTIONSTATUS;
    data['ID'] = this.iD;
    data['ListingID'] = this.listingID;
    if (this.listing != null) {
      data['Listing'] = this.listing.toJson();
    }
    data['UserID'] = this.userID;
    data['SellerID'] = this.sellerID;
    if (this.seller != null) {
      data['Seller'] = this.seller.toJson();
    }
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['Paid'] = this.paid;
    data['Payable'] = this.payable;
    data['TransactionID'] = this.transactionID;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.transaction != null) {
      data['Transaction'] = this.transaction.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listing {
  int iD;
  int price;
  Property property;
  int minPeriod;
  String createdAt;
  String updatedAt;
  int propertyID;
  String listingDate;
  String listingType;
  var periodUnits;
  bool iSAVAILABLE;
  String availableFrom;
  String specifications;

  Listing(
      {this.iD,
      this.price,
      this.property,
      this.minPeriod,
      this.createdAt,
      this.updatedAt,
      this.propertyID,
      this.listingDate,
      this.listingType,
      this.periodUnits,
      this.iSAVAILABLE,
      this.availableFrom,
      this.specifications});

  Listing.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    price = json['Price'];
    property = json['property'] != null
        ? new Property.fromJson(json['property'])
        : null;
    minPeriod = json['MinPeriod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    propertyID = json['PropertyID'];
    listingDate = json['ListingDate'];
    listingType = json['ListingType'];
    periodUnits = json['PeriodUnits'];
    iSAVAILABLE = json['IS_AVAILABLE'];
    availableFrom = json['AvailableFrom'];
    specifications = json['Specifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Price'] = this.price;
    if (this.property != null) {
      data['property'] = this.property.toJson();
    }
    data['MinPeriod'] = this.minPeriod;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['PropertyID'] = this.propertyID;
    data['ListingDate'] = this.listingDate;
    data['ListingType'] = this.listingType;
    data['PeriodUnits'] = this.periodUnits;
    data['IS_AVAILABLE'] = this.iSAVAILABLE;
    data['AvailableFrom'] = this.availableFrom;
    data['Specifications'] = this.specifications;
    return data;
  }
}

class Property {
  int iD;
  String type;
  String state;
  String title;
  var units;
  List<Photos> photos;
  Seller seller;
  int addedBy;
  String address;
  String country;
  String landArea;
  String location;
  String addedDate;
  String createdAt;
  String updatedAt;
  bool iSDELETED;
  String description;
  bool iSAVAILABLE;
  bool iSPUBLISHED;
  Specifications specifications;

  Property(
      {this.iD,
      this.type,
      this.state,
      this.title,
      this.units,
      this.photos,
      this.seller,
      this.addedBy,
      this.address,
      this.country,
      this.landArea,
      this.location,
      this.addedDate,
      this.createdAt,
      this.updatedAt,
      this.iSDELETED,
      this.description,
      this.iSAVAILABLE,
      this.iSPUBLISHED,
      this.specifications});

  Property.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    type = json['Type'];
    state = json['State'];
    title = json['Title'];
    units = json['Units'];
    if (json['Photos'] != null) {
      photos = new List<Photos>();
      json['Photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    seller =
        json['Seller'] != null ? new Seller.fromJson(json['Seller']) : null;
    addedBy = json['AddedBy'];
    address = json['Address'];
    country = json['Country'];
    landArea = json['LandArea'];
    location = json['Location'];
    addedDate = json['AddedDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iSDELETED = json['IS_DELETED'];
    description = json['Description'];
    iSAVAILABLE = json['IS_AVAILABLE'];
    iSPUBLISHED = json['IS_PUBLISHED'];
    specifications = json['Specifications'] != null
        ? new Specifications.fromJson(json['Specifications'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Type'] = this.type;
    data['State'] = this.state;
    data['Title'] = this.title;
    data['Units'] = this.units;
    if (this.photos != null) {
      data['Photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    if (this.seller != null) {
      data['Seller'] = this.seller.toJson();
    }
    data['AddedBy'] = this.addedBy;
    data['Address'] = this.address;
    data['Country'] = this.country;
    data['LandArea'] = this.landArea;
    data['Location'] = this.location;
    data['AddedDate'] = this.addedDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['IS_DELETED'] = this.iSDELETED;
    data['Description'] = this.description;
    data['IS_AVAILABLE'] = this.iSAVAILABLE;
    data['IS_PUBLISHED'] = this.iSPUBLISHED;
    if (this.specifications != null) {
      data['Specifications'] = this.specifications.toJson();
    }
    return data;
  }
}

class Photos {
  int iD;
  String name;
  String path;
  String type;
  int refID;
  bool isValid;
  String dateAdded;
  String createdAt;
  String updatedAt;
  String description;

  Photos(
      {this.iD,
      this.name,
      this.path,
      this.type,
      this.refID,
      this.isValid,
      this.dateAdded,
      this.createdAt,
      this.updatedAt,
      this.description});

  Photos.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    path = json['Path'];
    type = json['Type'];
    refID = json['RefID'];
    isValid = json['IsValid'];
    dateAdded = json['DateAdded'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['Path'] = this.path;
    data['Type'] = this.type;
    data['RefID'] = this.refID;
    data['IsValid'] = this.isValid;
    data['DateAdded'] = this.dateAdded;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['Description'] = this.description;
    return data;
  }
}

class Seller {
  int iD;
  String dOB;
  String email;
  String surName;
  String firstName;
  String createdAt;
  String updatedAt;
  String middleName;
  var nationalID;
  String phoneNumber;
  String profilePhoto;
  bool isEmailVerified;
  bool isProfileReviewed;

  Seller(
      {this.iD,
      this.dOB,
      this.email,
      this.surName,
      this.firstName,
      this.createdAt,
      this.updatedAt,
      this.middleName,
      this.nationalID,
      this.phoneNumber,
      this.profilePhoto,
      this.isEmailVerified,
      this.isProfileReviewed});

  Seller.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    dOB = json['DOB'];
    email = json['Email'];
    surName = json['SurName'];
    firstName = json['FirstName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    middleName = json['MiddleName'];
    nationalID = json['NationalID'];
    phoneNumber = json['PhoneNumber'];
    profilePhoto = json['ProfilePhoto'];
    isEmailVerified = json['isEmailVerified'];
    isProfileReviewed = json['isProfileReviewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['DOB'] = this.dOB;
    data['Email'] = this.email;
    data['SurName'] = this.surName;
    data['FirstName'] = this.firstName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['MiddleName'] = this.middleName;
    data['NationalID'] = this.nationalID;
    data['PhoneNumber'] = this.phoneNumber;
    data['ProfilePhoto'] = this.profilePhoto;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isProfileReviewed'] = this.isProfileReviewed;
    return data;
  }
}

class Specifications {
  String nOOFFLOORS;
  String nOOFBEDROOMS;
  String nOOFBATHROOMS;
  bool hASSWIMMINGPOOL;
  String nOOFLIVINGROOMS;

  Specifications(
      {this.nOOFFLOORS,
      this.nOOFBEDROOMS,
      this.nOOFBATHROOMS,
      this.hASSWIMMINGPOOL,
      this.nOOFLIVINGROOMS});

  Specifications.fromJson(Map<String, dynamic> json) {
    nOOFFLOORS = json['NO_OF_FLOORS'];
    nOOFBEDROOMS = json['NO_OF_BEDROOMS'];
    nOOFBATHROOMS = json['NO_OF_BATHROOMS'];
    hASSWIMMINGPOOL = json['HAS_SWIMMING_POOL'];
    nOOFLIVINGROOMS = json['NO_OF_LIVINGROOMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NO_OF_FLOORS'] = this.nOOFFLOORS;
    data['NO_OF_BEDROOMS'] = this.nOOFBEDROOMS;
    data['NO_OF_BATHROOMS'] = this.nOOFBATHROOMS;
    data['HAS_SWIMMING_POOL'] = this.hASSWIMMINGPOOL;
    data['NO_OF_LIVINGROOMS'] = this.nOOFLIVINGROOMS;
    return data;
  }
}

class Transaction {
  int iD;
  String status;
  String createdAt;
  String updatedAt;

  Transaction({this.iD, this.status, this.createdAt, this.updatedAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    status = json['Status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
