class bookingAccomandationModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  bookingAccomandationModel({this.statusCode, this.message, this.data});

  bookingAccomandationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? serviceId;
  String? bookingDate;
  var price;
  String? address;
  String? serviceName;
  String? image;
  var wantedPrice;

  Data(
      {this.id,
        this.serviceId,
        this.bookingDate,
        this.price,
        this.address,
        this.serviceName,
        this.image,
        this.wantedPrice

      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['serviceId'];
    bookingDate = json['bookingDate'];
    price = json['price'];
    address = json['address'];
    serviceName = json['serviceName'];
    image = json['image'];
    wantedPrice = json['wantedPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceId'] = this.serviceId;
    data['bookingDate'] = this.bookingDate;
    data['price'] = this.price;
    data['address'] = this.address;
    data['serviceName'] = this.serviceName;
    data['image'] = this.image;
    data['wantedPrice'] = this.wantedPrice;
    return data;
  }
}
