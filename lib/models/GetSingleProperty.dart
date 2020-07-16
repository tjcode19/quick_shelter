class GetSingleProperty {
  String responseMessage;
  String responseCode;
  Data data;

  GetSingleProperty({this.responseMessage, this.responseCode, this.data});

  GetSingleProperty.fromJson(Map<String, dynamic> json) {
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
  Property property;
  List<Photos> photos;
  List<Listings> listings;

  Data({this.property, this.photos, this.listings});

  Data.fromJson(Map<String, dynamic> json) {
    property = json['property'] != null
        ? new Property.fromJson(json['property'])
        : null;
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    if (json['listings'] != null) {
      listings = new List<Listings>();
      json['listings'].forEach((v) {
        listings.add(new Listings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.property != null) {
      data['property'] = this.property.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    if (this.listings != null) {
      data['listings'] = this.listings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Property {
  int iD;
  String title;
  String description;
  String type;
  String location;
  String address;
  String state;
  String country;
  String landArea;
  String units;
  Specifications specifications;
  int addedBy;
  bool iSAVAILABLE;
  bool iSPUBLISHED;
  String addedDate;
  String createdAt;
  String updatedAt;

  Property(
      {this.iD,
      this.title,
      this.description,
      this.type,
      this.location,
      this.address,
      this.state,
      this.country,
      this.landArea,
      this.units,
      this.specifications,
      this.addedBy,
      this.iSAVAILABLE,
      this.iSPUBLISHED,
      this.addedDate,
      this.createdAt,
      this.updatedAt});

  Property.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['Title'];
    description = json['Description'];
    type = json['Type'];
    location = json['Location'];
    address = json['Address'];
    state = json['State'];
    country = json['Country'];
    landArea = json['LandArea'];
    units = json['Units'];
    specifications = json['Specifications'] != null
        ? new Specifications.fromJson(json['Specifications'])
        : null;
    addedBy = json['AddedBy'];
    iSAVAILABLE = json['IS_AVAILABLE'];
    iSPUBLISHED = json['IS_PUBLISHED'];
    addedDate = json['AddedDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Type'] = this.type;
    data['Location'] = this.location;
    data['Address'] = this.address;
    data['State'] = this.state;
    data['Country'] = this.country;
    data['LandArea'] = this.landArea;
    data['Units'] = this.units;
    if (this.specifications != null) {
      data['Specifications'] = this.specifications.toJson();
    }
    data['AddedBy'] = this.addedBy;
    data['IS_AVAILABLE'] = this.iSAVAILABLE;
    data['IS_PUBLISHED'] = this.iSPUBLISHED;
    data['AddedDate'] = this.addedDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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

class Photos {
  int iD;
  String path;
  String description;

  Photos({this.iD, this.path, this.description});

  Photos.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    path = json['Path'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Path'] = this.path;
    data['Description'] = this.description;
    return data;
  }
}

class Listings {
  int iD;
  String listingType;
  String availableFrom;
  int minPeriod;
  String periodUnits;
  String specifications;
  String listingDate;
  int price;
  bool iSAVAILABLE;
  String createdAt;
  String updatedAt;
  int propertyID;

  Listings(
      {this.iD,
      this.listingType,
      this.availableFrom,
      this.minPeriod,
      this.periodUnits,
      this.specifications,
      this.listingDate,
      this.price,
      this.iSAVAILABLE,
      this.createdAt,
      this.updatedAt,
      this.propertyID});

  Listings.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    listingType = json['ListingType'];
    availableFrom = json['AvailableFrom'];
    minPeriod = json['MinPeriod'];
    periodUnits = json['PeriodUnits'];
    specifications = json['Specifications'];
    listingDate = json['ListingDate'];
    price = json['Price'];
    iSAVAILABLE = json['IS_AVAILABLE'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    propertyID = json['PropertyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ListingType'] = this.listingType;
    data['AvailableFrom'] = this.availableFrom;
    data['MinPeriod'] = this.minPeriod;
    data['PeriodUnits'] = this.periodUnits;
    data['Specifications'] = this.specifications;
    data['ListingDate'] = this.listingDate;
    data['Price'] = this.price;
    data['IS_AVAILABLE'] = this.iSAVAILABLE;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['PropertyID'] = this.propertyID;
    return data;
  }
}
