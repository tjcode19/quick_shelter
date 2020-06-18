class GetAllProperties {
  final Data data;

  GetAllProperties({this.data});

  factory GetAllProperties.fromJson(Map<String, dynamic> json) {
    return GetAllProperties(data: Data.fromJson(json['data']));
  }
}

class Data {
  final List<ListingM> listing;
  Data({this.listing});
  factory Data.fromJson(Map<String, dynamic> json) {

    var list = json['Listing'] as List;
    print(list.runtimeType);
    List<ListingM> listingObj = list.map((i) => ListingM.fromJson(i)).toList();     
    return Data(
        listing: listingObj,);
  }
}

class ListingM {
  final String listingType;
  final bool availableFrom;
  final String minPeriod;
  final String periodUnits;
  final String listingDate;
  final PropertyM property;
  final List<Photos> photos;

  ListingM(
      {this.listingType,
      this.availableFrom,
      this.minPeriod,
      this.periodUnits,
      this.listingDate,
      this.property, this.photos});

  factory ListingM.fromJson(Map<String, dynamic> json) {
     var list = json['Photos'] as List;
    print(list.runtimeType);
    List<Photos> photoObj = list.map((i) => Photos.fromJson(i)).toList();  

    return ListingM(
        listingType: json['ListingType'],
        availableFrom: json['AvailableFrom'],
        minPeriod: json['MinPeriod'],
        periodUnits: json['PeriodUnits'],
        listingDate: json['ListingDate'],
        property: PropertyM.fromJson(json['Property']),
        photos: photoObj );
  }
}

class PropertyM {
  final int id;
  final String type;
  final String location;
  final SpecificationsM specifications;

  PropertyM({this.id, this.type, this.location, this.specifications});

  factory PropertyM.fromJson(Map<String, dynamic> json) {
    return PropertyM(
      id: json['ListingType'],
      type: json['AvailableFrom'],
      location: json['Location'],
      specifications: SpecificationsM.fromJson(json['Specifications']),
    );
  }
}

class Photos {
  final String name;
  final String description;
  final String path;

  Photos({this.name, this.description, this.path});

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      name: json['Name'],
      description: json['Description'],
      path: json['Path']
    );
  }
}

class SpecificationsM {
  final int noOfRooms;
  final int noOfFloors;
  final bool hasSwimmingPool;

  SpecificationsM({this.noOfRooms, this.noOfFloors, this.hasSwimmingPool});

  factory SpecificationsM.fromJson(Map<String, dynamic> json) {
    return SpecificationsM(
      noOfRooms: json['NO_OF_ROOMS'],
      noOfFloors: json['NO_OF_FLOORS'],
      hasSwimmingPool: json['HAS_SWIMMING_POOL'],
    );
  }
}
