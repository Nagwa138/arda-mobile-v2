class AccommodationModel {
  final int? statusCode;
  final String? message;
  final ServiceDetails? serviceDetails;
  final CompanyDetails? companyDetails;

  AccommodationModel({
    this.statusCode,
    this.message,
    this.serviceDetails,
    this.companyDetails,
  });

  factory AccommodationModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AccommodationModel(
      statusCode: json['statusCode'],
      message: json['message'],
      serviceDetails: data['serviceDetails'] != null
          ? ServiceDetails.fromJson(data['serviceDetails'])
          : null,
      companyDetails: data['companyDetails'] != null
          ? CompanyDetails.fromJson(data['companyDetails'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': {
        'serviceDetails': serviceDetails?.toJson(),
        'companyDetails': companyDetails?.toJson(),
      }
    };
  }
}

class ServiceDetails {
  final String? serviceId;
  final List<String>? images;
  final String? serviceName;
  final String? about;
  final String? accomodationType;
  final List<String>? amenityName;
  final List<String>? specialName;
  final String? language;
  final String? progressStatus;
  final String? rejectionReason;
  final String? activationStatus;
  final List<RoomType>? roomsType;
  final String? rulesAndCancellationPolicy; // ✅ جديد
  final String? importantInformation; // ✅ جديد

  ServiceDetails({
    this.serviceId,
    this.images,
    this.serviceName,
    this.about,
    this.accomodationType,
    this.amenityName,
    this.specialName,
    this.language,
    this.progressStatus,
    this.rejectionReason,
    this.activationStatus,
    this.roomsType,
    this.rulesAndCancellationPolicy,
    this.importantInformation,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
      serviceId: json['serviceId'],
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      serviceName: json['serviceName'],
      about: json['about'],
      accomodationType: json['accomodationType'],
      amenityName:
          (json['amenityName'] as List?)?.map((e) => e.toString()).toList(),
      specialName:
          (json['specialName'] as List?)?.map((e) => e.toString()).toList(),
      language: json['language'],
      progressStatus: json['progressStatus'],
      rejectionReason: json['rejectionReason'],
      activationStatus: json['activationStatus'],
      roomsType: (json['roomsType'] as List?)
          ?.map((e) => RoomType.fromJson(e))
          .toList(),
      rulesAndCancellationPolicy: json['rulesAndCancellationPolicy'],
      importantInformation: json['importantInformation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'images': images,
      'serviceName': serviceName,
      'about': about,
      'accomodationType': accomodationType,
      'amenityName': amenityName,
      'specialName': specialName,
      'language': language,
      'progressStatus': progressStatus,
      'rejectionReason': rejectionReason,
      'activationStatus': activationStatus,
      'roomsType': roomsType?.map((e) => e.toJson()).toList(),
      'rulesAndCancellationPolicy': rulesAndCancellationPolicy,
      'importantInformation': importantInformation,
    };
  }
}

class RoomType {
  final String? id;
  final String? roomType;
  final int? count;
  final num? price;
  final bool? includeBreakFast;
  final String? roomImage;
  final int? guestsNo;

  RoomType({
    this.id,
    this.roomType,
    this.count,
    this.price,
    this.includeBreakFast,
    this.roomImage,
    this.guestsNo,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) {
    return RoomType(
      id: json['id'],
      roomType: json['roomType'],
      count: json['count'],
      price: json['price'],
      includeBreakFast: json['includeBreakFast'],
      roomImage: json['roomImage'],
      guestsNo: json['guestsNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomType': roomType,
      'count': count,
      'price': price,
      'includeBreakFast': includeBreakFast,
      'roomImage': roomImage,
      'guestsNo': guestsNo,
    };
  }
}

class CompanyDetails {
  final String? companyId;
  final String? image;
  final String? title;
  final String? owner;
  final String? gender;
  final String? status;
  final String? address;
  final String? addressLink;
  final String? phone;
  final String? website;

  CompanyDetails({
    this.companyId,
    this.image,
    this.title,
    this.owner,
    this.gender,
    this.status,
    this.address,
    this.addressLink,
    this.phone,
    this.website,
  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) {
    return CompanyDetails(
      companyId: json['companyId'],
      image: json['image'],
      title: json['title'],
      owner: json['owner'],
      gender: json['gender'],
      status: json['status'],
      address: json['address'],
      addressLink: json['addressLink'],
      phone: json['phone'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'image': image,
      'title': title,
      'owner': owner,
      'gender': gender,
      'status': status,
      'address': address,
      'addressLink': addressLink,
      'phone': phone,
      'website': website,
    };
  }
}
