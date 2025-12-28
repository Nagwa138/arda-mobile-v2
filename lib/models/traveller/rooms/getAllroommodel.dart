class GetAllRoomModel {
  var statusCode;
  String? message;
  List<Data>? data;

  GetAllRoomModel({this.statusCode, this.message, this.data});

  GetAllRoomModel.fromJson(Map<String, dynamic> json) {
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
  var capacity;
  int? noOfRoomsToReserve;
  var roomNo;
  String? id;

  Data(
      {this.roomType,
        this.price,
        this.roomImage,
        this.priceIncludeBreakFast,
        this.capacity,
         this.noOfRoomsToReserve,
        this.id,this.roomNo});

  Data.fromJson(Map<String, dynamic> json) {
    roomType = json['roomType'];
    price = json['price'];
    roomImage = json['roomImage'].cast<String>();
    priceIncludeBreakFast = json['priceIncludeBreakFast'];
    capacity = json['capacity'];
    noOfRoomsToReserve = json['noOfRoomsToReserve'];
    id = json['id'];
    roomNo = json['roomNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomType'] = this.roomType;
    data['price'] = this.price;
    data['roomImage'] = this.roomImage;
    data['priceIncludeBreakFast'] = this.priceIncludeBreakFast;
    data['capacity'] = this.capacity;
    data['noOfRoomsToReserve'] = this.noOfRoomsToReserve;
    data['id'] = this.id;
    data['roomNo'] = this.roomNo;
    return data;
  }
}
