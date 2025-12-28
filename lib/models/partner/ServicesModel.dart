class ServicesModel {
  ServicesModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final int? statusCode;
  final String? message;
  final List<Datum> data;

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    final dataField = json["data"];

    List<Datum> parsedData = [];

    if (dataField == null) {
      parsedData = [];
    } else if (dataField is List) {
      parsedData = dataField.map((e) => Datum.fromJson(e)).toList();
    } else {
      parsedData = [];
    }

    return ServicesModel(
      statusCode: json["statusCode"],
      message: json["message"],
      data: parsedData,
    );
  }
}

class Datum {
  Datum({
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
    required this.about,
    required this.serviceImageUrl,
    required this.website,
    required this.officialPhone,
    required this.language,
    required this.reviews,
    required this.rate,
    required this.reviewrsCount,
    required this.additionalDate,
    required this.amenityName,
    required this.specialName,
    required this.status,
    required this.id,
    required this.recomondedPercentage,
    required this.rejectionReason,
    required this.activationStatus,
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
  final String? about;
  final List<String> serviceImageUrl;
  final String? website;
  final String? officialPhone;
  final String? language;
  final List<Review> reviews;
  var rate;
  var reviewrsCount;
  final dynamic additionalDate;
  final List<String> amenityName;
  final List<String> specialName;
  final String? status;
  var recomondedPercentage;
  final String? id;
  final String? rejectionReason;
  var activationStatus;

  factory Datum.empty() {
    return Datum(
      accomodationType: '',
      apartmentArea: '',
      reservationPrice: '',
      coverPhotoUrl: '',
      beds: '',
      bathrooms: '',
      serviceName: '',
      address: '',
      city: '',
      government: '',
      addressLink: '',
      room: const [],
      about: '',
      serviceImageUrl: const [],
      website: '',
      officialPhone: '',
      language: '',
      reviews: const [],
      rate: '',
      reviewrsCount: '',
      additionalDate: '',
      amenityName: const [],
      specialName: const [],
      status: '',
      recomondedPercentage: '',
      id: '',
      rejectionReason: '',
      activationStatus: 0,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      accomodationType: json["accomodationType"],
      apartmentArea: json["apartmentArea"],
      reservationPrice: json["reservationPrice"],
      // ✅ الحل هنا - استخدم coverPhotoUrl مباشرة
      coverPhotoUrl: json["coverPhotoUrl"],
      beds: json["beds"],
      bathrooms: json["bathrooms"],
      serviceName: json["serviceName"],
      address: json["address"],
      city: json["city"],
      government: json["government"],
      addressLink: json["addressLink"],
      room: json["roomsType"] == null
          ? []
          : List<Room>.from(json["roomsType"]!.map((x) => Room.fromJson(x))),
      about: json["serviceDesc"], // ✅ الـ API بيبعت serviceDesc مش about
      serviceImageUrl: json["serviceImageUrl"] == null
          ? []
          : List<String>.from(json["serviceImageUrl"]!.map((x) => x)),
      website: json["website"],
      officialPhone: json["officialPhone"],
      language: json["language"],
      reviews: json["reviews"] == null
          ? []
          : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
      rate: json["rate"],
      reviewrsCount: json["reviewrsCount"],
      additionalDate: json["additionalDate"],
      amenityName: json["amenityName"] == null
          ? []
          : List<String>.from(json["amenityName"]!.map((x) => x)),
      specialName: json["specialName"] == null
          ? []
          : List<String>.from(json["specialName"]!.map((x) => x)),
      status: json["status"],
      recomondedPercentage: json['recomondedPercentage'],
      id: json["id"],
      rejectionReason: json["rejectionReason"],
      activationStatus: json["activationStatus"],
    );
  }

  Map<String, dynamic> toJson() => {
        "accomodationType": accomodationType,
        "apartmentArea": apartmentArea,
        "reservationPrice": reservationPrice,
        "coverPhotoUrl": coverPhotoUrl,
        "beds": beds,
        "bathrooms": bathrooms,
        "serviceName": serviceName,
        "address": address,
        "city": city,
        "government": government,
        "addressLink": addressLink,
        "roomsType": room.map((x) => x.toJson()).toList(),
        "serviceDesc": about,
        "serviceImageUrl": serviceImageUrl.map((x) => x).toList(),
        "website": website,
        "officialPhone": officialPhone,
        "language": language,
        "reviews": reviews.map((x) => x.toJson()).toList(),
        "rate": rate,
        "reviewrsCount": reviewrsCount,
        "additionalDate": additionalDate,
        "amenityName": amenityName.map((x) => x).toList(),
        "specialName": specialName.map((x) => x).toList(),
        "status": status,
        "recomondedPercentage": recomondedPercentage,
        "id": id,
        "rejectionReason": rejectionReason,
        "activationStatus": activationStatus,
      };
}

class Review {
  Review({
    required this.id,
    required this.comment,
    required this.rating,
    required this.accomodationId,
    required this.userName,
    required this.gender,
    required this.date,
    required this.time,
  });

  final String? id;
  final String? comment;
  var rating;
  final String? accomodationId;
  final String? userName;
  final String? gender;
  final String? date;
  final String? time;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json["id"],
      comment: json["comment"],
      rating: json["rating"],
      accomodationId: json["accomodationId"],
      userName: json["userName"],
      gender: json["gender"],
      date: json["date"],
      time: json["time"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "rating": rating,
        "accomodationId": accomodationId,
        "userName": userName,
        "gender": gender,
        "date": date,
        "time": time,
      };
}

class Room {
  Room({
    required this.roomType,
    required this.count,
    required this.totalNights,
    required this.guestNum,
    required this.roomImage,
    required this.includeBreakFast,
    required this.price,
    required this.id,
  });

  final String? roomType;
  final int count;
  final int? totalNights;
  bool? includeBreakFast;
  final int? guestNum;
  final List<String> roomImage;
  final String id;
  double price;

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json["id"] ?? '',
      roomType: json["roomType"],
      count: json["count"] ?? 0,
      price: (json["price"] ?? 0).toDouble(),
      includeBreakFast: json["includeBreakFast"],
      roomImage: json["roomImage"] == null
          ? []
          : json["roomImage"] is List
              ? List<String>.from(json["roomImage"].map((x) => x))
              : [json["roomImage"].toString()],
      guestNum: json["guestNum"], // ✅ الـ API بيبعت guestNum مش guestsNum
      totalNights: json["totalNights"],
    );
  }

  Map<String, dynamic> toJson() => {
        "roomType": roomType,
        "count": count,
        "totalNights": totalNights,
        "includeBreakFast": includeBreakFast,
        "guestNum": guestNum,
        "roomImage": roomImage.map((x) => x).toList(),
        "price": price,
        "id": id
      };
}

class ServiceDetailModel {
  ServiceDetailModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final int? statusCode;
  final String? message;
  final Datum data;

  factory ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    return ServiceDetailModel(
      statusCode: json["statusCode"],
      message: json["message"],
      data: (json["data"] != null && json["data"]["serviceDetails"] != null)
          ? Datum.fromJson(json["data"]["serviceDetails"])
          : Datum.empty(),
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}
