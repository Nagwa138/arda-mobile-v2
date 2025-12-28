class GetServicesByIdPartner {
  GetServicesByIdPartner({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  var statusCode;
  final String? message;
  final Data? data;

  factory GetServicesByIdPartner.fromJson(Map<String, dynamic> json) {
    return GetServicesByIdPartner(
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.accomodationType,
    required this.apartmentArea,
    required this.reservationPrice,
    required this.coverPhotoUrl,
    required this.beds,
    required this.bathrooms,
    required this.serviceName,
    required this.address,
    required this.city,
    required this.government,
    required this.addressLink,
    required this.room,
    required this.serviceDesc,
    required this.serviceImageUrl,
    required this.website,
    required this.officialPhone,
    required this.language,
    required this.reviews,
    required this.rate,
    required this.reviewrsCount,
    required this.isFav,
    required this.recomondedPercentage,
    required this.amenityName,
    required this.specialName,
    required this.status,
    required this.id,
  });

  final String? accomodationType;
  var apartmentArea;
  var reservationPrice;
  final String? coverPhotoUrl;
  var beds;
  var bathrooms;
  final String? serviceName;
  final String? address;
  final String? city;
  final String? government;
  final String? addressLink;
  final List<Room> room;
  final String? serviceDesc;
  final List<String> serviceImageUrl;
  final String? website;
  final String? officialPhone;
  final String? language;
  final List<dynamic> reviews;
  var rate;
  var reviewrsCount;
  final bool? isFav;
  var recomondedPercentage;
  final List<String> amenityName;
  final List<String> specialName;
  final String? status;
  final String? id;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accomodationType: json["accomodationType"],
      apartmentArea: json["apartmentArea"],
      reservationPrice: json["reservationPrice"],
      coverPhotoUrl: json["coverPhotoUrl"],
      beds: json["beds"],
      bathrooms: json["bathrooms"],
      serviceName: json["serviceName"],
      address: json["address"],
      city: json["city"],
      government: json["government"],
      addressLink: json["addressLink"],
      room: json["room"] == null
          ? []
          : List<Room>.from(json["room"]!.map((x) => Room.fromJson(x))),
      serviceDesc: json["serviceDesc"],
      serviceImageUrl: json["serviceImageUrl"] == null
          ? []
          : List<String>.from(json["serviceImageUrl"]!.map((x) => x)),
      website: json["website"],
      officialPhone: json["officialPhone"],
      language: json["language"],
      reviews: json["reviews"] == null
          ? []
          : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      rate: json["rate"],
      reviewrsCount: json["reviewrsCount"],
      isFav: json["isFav"],
      recomondedPercentage: json["recomondedPercentage"],
      amenityName: json["amenityName"] == null
          ? []
          : List<String>.from(json["amenityName"]!.map((x) => x)),
      specialName: json["specialName"] == null
          ? []
          : List<String>.from(json["specialName"]!.map((x) => x)),
      status: json["status"],
      id: json["id"],
    );
  }
}

class Room {
  Room({
    required this.roomType,
    required this.count,
    required this.totalNights,
    required this.guestNum,
    required this.roomImage,
    required this.price,
  });

  final String? roomType;
  int count;
  final dynamic totalNights;
  var guestNum;
  final List<String> roomImage;
  var price;

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomType: json["roomType"],
      count: json["count"],
      totalNights: json["totalNights"],
      guestNum: json["guestNum"],
      roomImage: json["roomImage"] == null
          ? []
          : List<String>.from(json["roomImage"]!.map((x) => x)),
      price: json["price"],
    );
  }
}
