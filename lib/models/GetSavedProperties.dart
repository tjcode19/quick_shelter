class GetSavedProperties {
  int iD;
  String listingType;
  var availableFrom;
  int minPeriod;
  String periodUnits;
  var specifications;
  String listingDate;
  int price;
  bool iSAVAILABLE;
  String createdAt;
  String updatedAt;
  int propertyID;
  Property property;

  GetSavedProperties(
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
      this.propertyID,
      this.property});

  GetSavedProperties.fromJson(Map<String, dynamic> json) {
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
    if (this.property != null) {
      data['property'] = this.property.toJson();
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
  String iSPUBLISHED;
  String addedDate;
  String createdAt;
  String updatedAt;
  List<SavedPropPhotos> photos;

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
      this.iSPUBLISHED,
      this.addedDate,
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
    addedBy = json['AddedBy'];
    iSPUBLISHED = json['IS_PUBLISHED'];
    addedDate = json['AddedDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['Photos'] != null) {
      photos = new List<SavedPropPhotos>();
      json['Photos'].forEach((v) {
        photos.add(new SavedPropPhotos.fromJson(v));
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
    data['AddedBy'] = this.addedBy;
    data['IS_PUBLISHED'] = this.iSPUBLISHED;
    data['AddedDate'] = this.addedDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.photos != null) {
      data['Photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Specifications {
  int nOOFROOMS;
  int nOOFFLOORS;
  bool hASSWIMMINGPOOL;
  int nOOFLIVINGROOMS;

  Specifications(
      {this.nOOFROOMS,
      this.nOOFFLOORS,
      this.hASSWIMMINGPOOL,
      this.nOOFLIVINGROOMS});

  Specifications.fromJson(Map<String, dynamic> json) {
    nOOFROOMS = json['NO_OF_ROOMS'];
    nOOFFLOORS = json['NO_OF_FLOORS'];
    hASSWIMMINGPOOL = json['HAS_SWIMMING_POOL'];
    nOOFLIVINGROOMS = json['NO_OF_LIVINGROOMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NO_OF_ROOMS'] = this.nOOFROOMS;
    data['NO_OF_FLOORS'] = this.nOOFFLOORS;
    data['HAS_SWIMMING_POOL'] = this.hASSWIMMINGPOOL;
    data['NO_OF_LIVINGROOMS'] = this.nOOFLIVINGROOMS;
    return data;
  }
}

class SavedPropPhotos {
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

  SavedPropPhotos(
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

  SavedPropPhotos.fromJson(Map<String, dynamic> json) {
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

class GetSavedPropertiesList{
  final List<GetSavedProperties> getSavedProps;

  GetSavedPropertiesList({this.getSavedProps});

  factory GetSavedPropertiesList.fromJson(List<dynamic> parsedJson) {

    List<GetSavedProperties> getSavedProps = new List<GetSavedProperties>();
    getSavedProps = parsedJson.map((i)=>GetSavedProperties.fromJson(i)).toList();

    return new GetSavedPropertiesList(
       getSavedProps: getSavedProps,
    );
  }
}