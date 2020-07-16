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
  int iD;
  int listingID;
  Listing listing;
  int userID;
  int sellerID;
  Seller seller;
  String startDate;
  String endDate;
  int paid;
  int outstanding;
  String createdAt;
  String updatedAt;

  Data(
      {this.iD,
      this.listingID,
      this.listing,
      this.userID,
      this.sellerID,
      this.seller,
      this.startDate,
      this.endDate,
      this.paid,
      this.outstanding,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
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
    outstanding = json['Outstanding'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['Outstanding'] = this.outstanding;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
  String periodUnits;
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
  String units;
  List<Photos> photos;
  int addedBy;
  String address;
  String country;
  String landArea;
  String location;
  String addedDate;
  String createdAt;
  String updatedAt;
  String description;
  bool iSPUBLISHED;
  Specifications specifications;

  Property(
      {this.iD,
      this.type,
      this.state,
      this.title,
      this.units,
      this.photos,
      this.addedBy,
      this.address,
      this.country,
      this.landArea,
      this.location,
      this.addedDate,
      this.createdAt,
      this.updatedAt,
      this.description,
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
    addedBy = json['AddedBy'];
    address = json['Address'];
    country = json['Country'];
    landArea = json['LandArea'];
    location = json['Location'];
    addedDate = json['AddedDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    description = json['Description'];
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
    data['AddedBy'] = this.addedBy;
    data['Address'] = this.address;
    data['Country'] = this.country;
    data['LandArea'] = this.landArea;
    data['Location'] = this.location;
    data['AddedDate'] = this.addedDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['Description'] = this.description;
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

class Specifications {
  int nOOFFLOORS;
  int nOOFBEDROOMS;
  bool hASSWIMMINGPOOL;
  int nOOFLIVINGROOMS;

  Specifications(
      {this.nOOFFLOORS,
      this.nOOFBEDROOMS,
      this.hASSWIMMINGPOOL,
      this.nOOFLIVINGROOMS});

  Specifications.fromJson(Map<String, dynamic> json) {
    nOOFFLOORS = json['NO_OF_FLOORS'];
    nOOFBEDROOMS = json['NO_OF_BEDROOMS'];
    hASSWIMMINGPOOL = json['HAS_SWIMMING_POOL'];
    nOOFLIVINGROOMS = json['NO_OF_LIVINGROOMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NO_OF_FLOORS'] = this.nOOFFLOORS;
    data['NO_OF_BEDROOMS'] = this.nOOFBEDROOMS;
    data['HAS_SWIMMING_POOL'] = this.hASSWIMMINGPOOL;
    data['NO_OF_LIVINGROOMS'] = this.nOOFLIVINGROOMS;
    return data;
  }
}

class Seller {
  int iD;
  String dOB;
  OTP oTP;
  String email;
  String surName;
  String password;
  String firstName;
  String uSERTYPE;
  String createdAt;
  String updatedAt;
  String middleName;
  String nationalID;
  String phoneNumber;
  String profilePhoto;
  bool isEmailVerified;
  bool isProfileReviewed;

  Seller(
      {this.iD,
      this.dOB,
      this.oTP,
      this.email,
      this.surName,
      this.password,
      this.firstName,
      this.uSERTYPE,
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
    oTP = json['OTP'] != null ? new OTP.fromJson(json['OTP']) : null;
    email = json['Email'];
    surName = json['SurName'];
    password = json['Password'];
    firstName = json['FirstName'];
    uSERTYPE = json['USER_TYPE'];
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
    if (this.oTP != null) {
      data['OTP'] = this.oTP.toJson();
    }
    data['Email'] = this.email;
    data['SurName'] = this.surName;
    data['Password'] = this.password;
    data['FirstName'] = this.firstName;
    data['USER_TYPE'] = this.uSERTYPE;
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

class OTP {
  String email;
  String phone;

  OTP({this.email, this.phone});

  OTP.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    phone = json['Phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.email;
    data['Phone'] = this.phone;
    return data;
  }
}
