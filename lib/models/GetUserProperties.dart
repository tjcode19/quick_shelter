import 'dart:convert';

List<GetUserPropertiesM> modelUserFromJson(String str) =>
    List<GetUserPropertiesM>.from(
        json.decode(str).map((x) => GetUserPropertiesM.fromJson(x)));
String modelUserToJson(List<GetUserPropertiesM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUserProperties {
  final List<GetUserPropertiesM> getUserProp;

  GetUserProperties({
    this.getUserProp,
  });

  factory GetUserProperties.fromJson(Map<String, dynamic> json) {
    var list = json['GetUserProperties'] as List;
    print(list.runtimeType);
    List<GetUserPropertiesM> userPropObj =
        list.map((i) => GetUserPropertiesM.fromJson(i)).toList();

    return GetUserProperties(getUserProp: userPropObj);
  }
}

class GetUserPropertiesM {
  final int id;
  final String title;
  final String description;
  final String type;
  final String location;
  final String address;
  final String state;
  final String country;
  final String landArea;
  final String units;
  final SpecificationsM specifications;
  final List<Photos> photos;
  final List<ListingM> listing;

  GetUserPropertiesM(
      {this.id,
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
      this.photos,
      this.listing});

  factory GetUserPropertiesM.fromJson(Map<String, dynamic> json) {
    var list = json['Photos'] as List;
    print(list.runtimeType);
    List<Photos> photoObj = list.map((i) => Photos.fromJson(i)).toList();

    var listing = json['Listings'] as List;
    print(list.runtimeType);
    List<ListingM> listingObj =
        listing.map((i) => ListingM.fromJson(i)).toList();

    return GetUserPropertiesM(
        id: json['ID'],
        title: json['Title'],
        description: json['Description'],
        type: json['Title'],
        location: json['Title'],
        address: json['Title'],
        state: json['Title'],
        country: json['Title'],
        landArea: json['Title'],
        units: json['Title'],
        specifications: SpecificationsM.fromJson(json['Specifications']),
        photos: photoObj,
        listing: listingObj);


  }

  Map<String, dynamic> toJson() => {
    "ID": id,
    "name": title,
  };
}

class Data {
  final List<GetUserProperties> listing;
  Data({this.listing});
  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['Listing'] as List;
    print(list.runtimeType);
    List<GetUserProperties> listingObj =
        list.map((i) => GetUserProperties.fromJson(i)).toList();
    return Data(
      listing: listingObj,
    );
  }
}

class ListingM {
  final String listingType;
  final bool availableFrom;
  final String minPeriod;
  final String periodUnits;
  final String listingDate;
  final bool isAvailable;
  final bool isPublished;
  final int price;
  final PropertyM property;
  final List<Photos> photos;

  ListingM(
      {this.listingType,
      this.availableFrom,
      this.minPeriod,
      this.periodUnits,
      this.listingDate,
      this.property,
      this.isAvailable,
      this.price,
      this.isPublished,
      this.photos});

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
        isAvailable: json['IS_AVAILABLE'],
        isPublished: json['IS_PUBLISHED'],
        price: json['Price'],
        property: PropertyM.fromJson(json['Property']),
        photos: photoObj);
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
        path: json['Path']);
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

class Listing {
  final String listingType;
  final bool availableFrom;
  final String minPeriod;
  final String periodUnits;
  final String listingDate;
  final bool isAvailable;
  final bool isPublished;
  final int price;
  final PropertyM property;
  final List<Photos> photos;

  Listing(
      {this.listingType,
      this.availableFrom,
      this.minPeriod,
      this.periodUnits,
      this.listingDate,
      this.property,
      this.isAvailable,
      this.price,
      this.isPublished,
      this.photos});

  factory Listing.fromJson(Map<String, dynamic> json) {
    var list = json['Photos'] as List;
    print(list.runtimeType);
    List<Photos> photoObj = list.map((i) => Photos.fromJson(i)).toList();

    return Listing(
        listingType: json['ListingType'],
        availableFrom: json['AvailableFrom'],
        minPeriod: json['MinPeriod'],
        periodUnits: json['PeriodUnits'],
        listingDate: json['ListingDate'],
        isAvailable: json['IS_AVAILABLE'],
        isPublished: json['IS_PUBLISHED'],
        price: json['Price'],
        property: PropertyM.fromJson(json['Property']),
        photos: photoObj);
  }
}
