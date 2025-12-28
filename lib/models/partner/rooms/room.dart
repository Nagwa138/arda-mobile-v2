class GetRoomsAccomandtionModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  GetRoomsAccomandtionModel({this.statusCode, this.message, this.data});

  GetRoomsAccomandtionModel.fromJson(Map<String, dynamic> json) {
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
  String? roomType;
  var price;
  List<String>? roomImage;
  bool? priceIncludeBreakFast;
  var guestsNo;
  var roomNo;
  String? id;

  Data(
      {this.roomType,
      this.price,
      this.roomImage,
      this.priceIncludeBreakFast,
      this.guestsNo,
      this.roomNo,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    roomType = json['roomType'];
    price = json['price'];
    roomImage = json['roomImage'].cast<String>();
    priceIncludeBreakFast = json['priceIncludeBreakFast'];
    guestsNo = json['guestsNo'];
    roomNo = json['roomNo'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomType'] = this.roomType;
    data['price'] = this.price;
    data['roomImage'] = this.roomImage;
    data['priceIncludeBreakFast'] = this.priceIncludeBreakFast;
    data['guestsNo'] = this.guestsNo;
    data['roomNo'] = this.roomNo;
    data['id'] = this.id;
    return data;
  }
}
