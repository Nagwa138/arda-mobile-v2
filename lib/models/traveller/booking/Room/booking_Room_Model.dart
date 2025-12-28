class GetBookingRoomModelDetails {
  int? statusCode;
  String? message;
  List<Data>? data;

  GetBookingRoomModelDetails({this.statusCode, this.message, this.data});

  GetBookingRoomModelDetails.fromJson(Map<String, dynamic> json) {
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
  var roomNo;
  String? roomType;
  var price;
  List<String>? roomImages;
  var guestNo;
  bool? priceIncludeBreakFast;
  String? id;

  Data(
      {this.roomNo,
        this.roomType,
        this.price,
        this.roomImages,
        this.guestNo,
        this.priceIncludeBreakFast,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    roomNo = json['roomNo'];
    roomType = json['roomType'];
    price = json['price'];
    roomImages = json['roomImages'].cast<String>();
    guestNo = json['guestNo'];
    priceIncludeBreakFast = json['priceIncludeBreakFast'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomNo'] = this.roomNo;
    data['roomType'] = this.roomType;
    data['price'] = this.price;
    data['roomImages'] = this.roomImages;
    data['guestNo'] = this.guestNo;
    data['priceIncludeBreakFast'] = this.priceIncludeBreakFast;
    data['id'] = this.id;
    return data;
  }
}
