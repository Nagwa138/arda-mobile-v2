class GetGuestByIdModel {
  int? statusCode;
  String? message;
  Data? data;

  GetGuestByIdModel({this.statusCode, this.message, this.data});

  GetGuestByIdModel.fromJson(Map<String, dynamic> json) {
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
  String? status;
  UserDate? userDate;
  GuestInfo? guestInfo;
  BookingInfo? bookingInfo;
  ServiceDetails? serviceDetails;

  Data(
      {this.id,
        this.status,
        this.userDate,
        this.guestInfo,
        this.bookingInfo,
        this.serviceDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    userDate = json['userDate'] != null
        ? new UserDate.fromJson(json['userDate'])
        : null;
    guestInfo = json['guestInfo'] != null
        ? new GuestInfo.fromJson(json['guestInfo'])
        : null;
    bookingInfo = json['bookingInfo'] != null
        ? new BookingInfo.fromJson(json['bookingInfo'])
        : null;
    serviceDetails = json['serviceDetails'] != null
        ? new ServiceDetails.fromJson(json['serviceDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.userDate != null) {
      data['userDate'] = this.userDate!.toJson();
    }
    if (this.guestInfo != null) {
      data['guestInfo'] = this.guestInfo!.toJson();
    }
    if (this.bookingInfo != null) {
      data['bookingInfo'] = this.bookingInfo!.toJson();
    }
    if (this.serviceDetails != null) {
      data['serviceDetails'] = this.serviceDetails!.toJson();
    }
    return data;
  }
}

class UserDate {
  String? userName;
  String? email;
  String? gender;

  UserDate({this.userName, this.email, this.gender});

  UserDate.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    return data;
  }
}

class GuestInfo {
  String? name;
  String? email;
  String? birthDate;
  String? gender;

  GuestInfo({this.name, this.email, this.birthDate, this.gender});

  GuestInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    birthDate = json['birthDate'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['birthDate'] = this.birthDate;
    data['gender'] = this.gender;
    return data;
  }
}

class BookingInfo {
  String? checkIn;
  String? checkOut;
  String? start;
  String? end;
  int? guestNo;
  List<Room>? room;
  String? payMentMethod;
  BookingInfo(
      {this.checkIn,
        this.checkOut,
        this.guestNo,
        this.room,
        this.payMentMethod,
        this.start,
        this.end

      });

  BookingInfo.fromJson(Map<String, dynamic> json) {
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    guestNo = json['guestNo'];
    start = json['start'];
    end = json['end'];
    if (json['roomsType'] != null) {
      room = <Room>[];
      json['roomsType'].forEach((v) {
        room!.add(new Room.fromJson(v));
      });
    }
    payMentMethod = json['payMentMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['guestNo'] = this.guestNo;
    data['start'] = this.start;
    data['end'] = this.end;
    if (this.room != null) {
      data['room'] = this.room!.map((v) => v.toJson()).toList();
    }
    data['payMentMethod'] = this.payMentMethod;
    return data;
  }
}

class Room {
  String? roomType;
  int? count;

  Room({this.roomType, this.count});

  Room.fromJson(Map<String, dynamic> json) {
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

class ServiceDetails {
  String? title;
  String? location;
  var price;
  String? image;

  ServiceDetails({this.title, this.location, this.price, this.image});

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    location = json['location'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['location'] = this.location;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
