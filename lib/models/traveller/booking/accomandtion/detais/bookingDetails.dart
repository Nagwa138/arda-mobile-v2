class AccomandationDetailsModel {
  int? statusCode;
  String? message;
  Data? data;

  AccomandationDetailsModel({this.statusCode, this.message, this.data});

  AccomandationDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? serviceType;
  String? accomodationId;
  String? accomodationType;
  String? serviceName;
  String? location;
  String? phone;
  String? checkIn;
  String? checkOut;
  var guestNo;
  List<RoomType>? roomType;
  var pricePerNight;
  var totalNight;
  var totalPrice;
  String? bookStatus;
  List<String>? roomImages;
  var rate;

  Data(
      {this.id,
        this.serviceType,
        this.accomodationId,
        this.accomodationType,
        this.serviceName,
        this.location,
        this.phone,
        this.checkIn,
        this.checkOut,
        this.guestNo,
        this.roomType,
        this.pricePerNight,
        this.totalNight,
        this.totalPrice,
        this.bookStatus,
        this.roomImages,
        this.rate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceType = json['serviceType'];
    accomodationId = json['accomodationId'];
    accomodationType = json['accomodationType'];
    serviceName = json['serviceName'];
    location = json['location'];
    phone = json['phone'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    guestNo = json['guestNo'];
    if (json['roomType'] != null) {
      roomType = <RoomType>[];
      json['roomType'].forEach((v) {
        roomType!.add(new RoomType.fromJson(v));
      });
    }
    pricePerNight = json['pricePerNight'];
    totalNight = json['totalNight'];
    totalPrice = json['totalPrice'];
    bookStatus = json['bookStatus'];
    roomImages = json['roomImages'].cast<String>();
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceType'] = this.serviceType;
    data['accomodationId'] = this.accomodationId;
    data['accomodationType'] = this.accomodationType;
    data['serviceName'] = this.serviceName;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['guestNo'] = this.guestNo;
    if (this.roomType != null) {
      data['roomType'] = this.roomType!.map((v) => v.toJson()).toList();
    }
    data['pricePerNight'] = this.pricePerNight;
    data['totalNight'] = this.totalNight;
    data['totalPrice'] = this.totalPrice;
    data['bookStatus'] = this.bookStatus;
    data['roomImages'] = this.roomImages;
    data['rate'] = this.rate;
    return data;
  }
}

class RoomType {
  String? roomType;
  int? count;

  RoomType({this.roomType, this.count});

  RoomType.fromJson(Map<String, dynamic> json) {
    roomType = json['roomType'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomType'] = this.roomType;
    data['count'] = this.count;
    return data;
  }
}
