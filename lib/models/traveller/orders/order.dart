class GetAllOrder {
  int? statusCode;
  String? message;
  List<Data>? data;

  GetAllOrder({this.statusCode, this.message, this.data});

  GetAllOrder.fromJson(Map<String, dynamic> json) {
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
  var rate;
  String? deliveryDate;
  String? deliveryTime;
  String? bookingDate;
  String? bookingTime;
 var noOfProducts;
 var totalPrice;
  String? orderStatus;

  Data(
      {this.id,
        this.rate,
        this.deliveryDate,
        this.deliveryTime,
        this.bookingDate,
        this.bookingTime,
        this.noOfProducts,
        this.totalPrice,
        this.orderStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    deliveryDate = json['deliveryDate'];
    deliveryTime = json['deliveryTime'];
    bookingDate = json['bookingDate'];
    bookingTime = json['bookingTime'];
    noOfProducts = json['noOfProducts'];
    totalPrice = json['totalPrice'];
    orderStatus = json['orderStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rate'] = this.rate;
    data['deliveryDate'] = this.deliveryDate;
    data['deliveryTime'] = this.deliveryTime;
    data['bookingDate'] = this.bookingDate;
    data['bookingTime'] = this.bookingTime;
    data['noOfProducts'] = this.noOfProducts;
    data['totalPrice'] = this.totalPrice;
    data['orderStatus'] = this.orderStatus;
    return data;
  }
}
