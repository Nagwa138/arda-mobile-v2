class AccomandtionByIdModelone {
  int? statusCode;
  String? message;
  Data? data;

  AccomandtionByIdModelone({this.statusCode, this.message, this.data});

  AccomandtionByIdModelone.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? accomodationType;
  var apartmentArea;
  var reservationPrice;
  String? coverPhotoUrl;
  var beds;
  var bathrooms;
  String? serviceName;
  String? address;
  String? city;
  String? government;
  String? addressLink;
  List<Room>? room;
  String? serviceDesc;
  List<String>? serviceImageUrl;
  String? website;
  String? officialPhone;
  String? language;
  List<Reviews>? reviews;
  var rate;
  var reviewrsCount;
  bool? isFav;
  var recomondedPercentage;
  List<String>? amenityName;
  List<String>? specialName;
  String? status;
  String? rejectionReason; // إضافة
  String? activationStatus; // إضافة
  var rooms; // إضافة
  String? id;

  Data({
    this.accomodationType,
    this.apartmentArea,
    this.recomondedPercentage,
    this.reservationPrice,
    this.coverPhotoUrl,
    this.beds,
    this.bathrooms,
    this.serviceName,
    this.address,
    this.city,
    this.government,
    this.addressLink,
    this.room,
    this.serviceDesc,
    this.serviceImageUrl,
    this.website,
    this.officialPhone,
    this.language,
    this.reviews,
    this.rate,
    this.reviewrsCount,
    this.isFav,
    this.amenityName,
    this.specialName,
    this.status,
    this.rejectionReason,
    this.activationStatus,
    this.rooms,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    accomodationType = json['accomodationType'];
    apartmentArea = json['apartmentArea'];
    reservationPrice = json['reservationPrice'];
    coverPhotoUrl = json['coverPhotoUrl'];
    beds = json['beds'];
    bathrooms = json['bathrooms'];
    serviceName = json['serviceName'];
    address = json['address'];
    city = json['city'];
    government = json['government'];
    addressLink = json['addressLink'];
    if (json['roomsType'] != null) {
      room = <Room>[];
      json['roomsType'].forEach((v) {
        room!.add(Room.fromJson(v));
      });
    }
    serviceDesc = json['serviceDesc'];
    if (json['serviceImageUrl'] != null) {
      serviceImageUrl = json['serviceImageUrl'].cast<String>();
    }
    website = json['website'];
    officialPhone = json['officialPhone'];
    language = json['language'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    rate = json['rate'];
    reviewrsCount = json['reviewrsCount'];
    isFav = json['isFav'];
    recomondedPercentage = json['recomondedPercentage'];
    if (json['amenityName'] != null) {
      amenityName = json['amenityName'].cast<String>();
    }
    if (json['specialName'] != null) {
      specialName = json['specialName'].cast<String>();
    }
    status = json['status'];
    rejectionReason = json['rejectionReason']; // إضافة
    activationStatus = json['activationStatus']; // إضافة
    rooms = json['rooms']; // إضافة
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['accomodationType'] = accomodationType;
    data['apartmentArea'] = apartmentArea;
    data['reservationPrice'] = reservationPrice;
    data['coverPhotoUrl'] = coverPhotoUrl;
    data['beds'] = beds;
    data['bathrooms'] = bathrooms;
    data['serviceName'] = serviceName;
    data['address'] = address;
    data['city'] = city;
    data['government'] = government;
    data['addressLink'] = addressLink;
    if (room != null) {
      data['roomsType'] = room!.map((v) => v.toJson()).toList();
    }
    data['serviceDesc'] = serviceDesc;
    data['serviceImageUrl'] = serviceImageUrl;
    data['website'] = website;
    data['officialPhone'] = officialPhone;
    data['language'] = language;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['rate'] = rate;
    data['reviewrsCount'] = reviewrsCount;
    data['isFav'] = isFav;
    data['recomondedPercentage'] = recomondedPercentage;
    data['amenityName'] = amenityName;
    data['specialName'] = specialName;
    data['status'] = status;
    data['rejectionReason'] = rejectionReason; // إضافة
    data['activationStatus'] = activationStatus; // إضافة
    data['rooms'] = rooms; // إضافة
    data['id'] = id;
    return data;
  }
}

class Room {
  String? roomType;
  var count;
  var totalNights;
  var guestNum;
  List<String>? roomImage;
  var price;
  bool? includeBreakFast; // إضافة
  String? id;

  Room({
    this.roomType,
    this.count,
    this.totalNights,
    this.guestNum,
    this.roomImage,
    this.price,
    this.includeBreakFast,
    this.id,
  });

  Room.fromJson(Map<String, dynamic> json) {
    roomType = json['roomType'];
    count = json['count'];
    totalNights = json['totalNights'];
    guestNum = json['guestNum'];

    if (json['roomImage'] != null) {
      if (json['roomImage'] is String) {
        roomImage = [json['roomImage'] as String];
      } else if (json['roomImage'] is List) {
        roomImage = (json['roomImage'] as List).cast<String>();
      }
    }

    price = json['price'];
    includeBreakFast = json['includeBreakFast']; // إضافة
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['roomType'] = roomType;
    data['count'] = count;
    data['totalNights'] = totalNights;
    data['guestNum'] = guestNum;
    data['roomImage'] = roomImage;
    data['price'] = price;
    data['includeBreakFast'] = includeBreakFast; // إضافة
    data['id'] = id;
    return data;
  }
}

class Reviews {
  String? id;
  String? comment;
  var rating;
  String? accomodationId;
  String? userName;
  String? gender;
  String? date;
  String? time;

  Reviews({
    this.id,
    this.comment,
    this.rating,
    this.accomodationId,
    this.userName,
    this.gender,
    this.date,
    this.time,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    accomodationId = json['accomodationId'];
    userName = json['userName'];
    gender = json['gender'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['comment'] = comment;
    data['rating'] = rating;
    data['accomodationId'] = accomodationId;
    data['userName'] = userName;
    data['gender'] = gender;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}
