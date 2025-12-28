class GetFavouriteModelProduct {
  int? statusCode;
  String? message;
  List<Data>? data;

  GetFavouriteModelProduct({this.statusCode, this.message, this.data});

  GetFavouriteModelProduct.fromJson(Map<String, dynamic> json) {
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
  String? productType;
  String? productName;
  var price;
  var rate;
  var amount;
  var avilablePieces;
  String? store;
  List<String>? image;
  bool? isFav;
  String? id;

  Data(
      {this.productType,
        this.productName,
        this.price,
        this.rate,
        this.store,
        this.image,
        this.isFav,
        this.amount,
        this.avilablePieces,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    productType = json['productType'];
    productName = json['productName'];
    price = json['price'];
    rate = json['rate'];
    store = json['store'];
    image = json['image'].cast<String>();
    isFav = json['isFav'];
    amount = json['amount'];
    avilablePieces = json['avilablePieces'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productType'] = this.productType;
    data['productName'] = this.productName;
    data['price'] = this.price;
    data['rate'] = this.rate;
    data['store'] = this.store;
    data['image'] = this.image;
    data['isFav'] = this.isFav;
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['avilablePieces'] = this.avilablePieces;
    return data;
  }
}
