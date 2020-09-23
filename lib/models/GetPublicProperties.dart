class GetPublicProperties {
  int count;
  List<PropLandingData> data;
  String responseMessage;
  String responseCode;

  GetPublicProperties(
      {this.count, this.data, this.responseMessage, this.responseCode});

  GetPublicProperties.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = new List<PropLandingData>();
      json['data'].forEach((v) {
        data.add(new PropLandingData.fromJson(v));
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

class PropLandingData {
  bool iSSAVED;
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
  Property property;
  List<SavedItems> savedItems;

  PropLandingData(
      {this.iSSAVED,
      this.iD,
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
      this.propertyID,
      this.property,
      this.savedItems});

  PropLandingData.fromJson(Map<String, dynamic> json) {
    iSSAVED = json['IS_SAVED'];
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
    property = json['property'] != null
        ? new Property.fromJson(json['property'])
        : null;
    if (json['SavedItems'] != null) {
      savedItems = new List<SavedItems>();
      json['SavedItems'].forEach((v) {
        savedItems.add(new SavedItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IS_SAVED'] = this.iSSAVED;
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
    if (this.property != null) {
      data['property'] = this.property.toJson();
    }
    if (this.savedItems != null) {
      data['SavedItems'] = this.savedItems.map((v) => v.toJson()).toList();
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
  var mortgagePlan;
  int addedBy;
  String iSAVAILABLE;
  bool iSPUBLISHED;
  String addedDate;
  bool iSDELETED;
  String createdAt;
  String updatedAt;
  List<Photos> photos;

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
      this.mortgagePlan,
      this.addedBy,
      this.iSAVAILABLE,
      this.iSPUBLISHED,
      this.addedDate,
      this.iSDELETED,
      this.createdAt,
      this.updatedAt,
      this.photos});

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
    mortgagePlan = json['MortgagePlan'];
    addedBy = json['AddedBy'];
    iSAVAILABLE = json['IS_AVAILABLE'];
    iSPUBLISHED = json['IS_PUBLISHED'];
    addedDate = json['AddedDate'];
    iSDELETED = json['IS_DELETED'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['Photos'] != null) {
      photos = new List<Photos>();
      json['Photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
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
    data['MortgagePlan'] = this.mortgagePlan;
    data['AddedBy'] = this.addedBy;
    data['IS_AVAILABLE'] = this.iSAVAILABLE;
    data['IS_PUBLISHED'] = this.iSPUBLISHED;
    data['AddedDate'] = this.addedDate;
    data['IS_DELETED'] = this.iSDELETED;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.photos != null) {
      data['Photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Specifications {
  var nOOFFLOORS;
  var nOOFBEDROOMS;
  var nOOFBATHROOMS;
  bool hASSWIMMINGPOOL;
  var nOOFLIVINGROOMS;

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
  int refID;
  String type;
  String name;
  String path;
  String description;
  String isValid;
  String dateAdded;
  String createdAt;
  String updatedAt;

  Photos(
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

  Photos.fromJson(Map<String, dynamic> json) {
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

class SavedItems {
  int id;

  SavedItems({this.id});

  SavedItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
