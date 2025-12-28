class orderDetailsModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  orderDetailsModel({this.statusCode, this.message, this.data});

  orderDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? image;
  String? productName;
  String? category;
  String? store;
 var price;
 var rate;
 var payedAmount;

  Data(
      {this.id,
        this.image,
        this.productName,
        this.category,
        this.store,
        this.price,
        this.rate,
        this.payedAmount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    productName = json['productName'];
    category = json['category'];
    store = json['store'];
    price = json['price'];
    rate = json['rate'];
    payedAmount = json['payedAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['productName'] = this.productName;
    data['category'] = this.category;
    data['store'] = this.store;
    data['price'] = this.price;
    data['rate'] = this.rate;
    data['payedAmount'] = this.payedAmount;
    return data;
  }
}
