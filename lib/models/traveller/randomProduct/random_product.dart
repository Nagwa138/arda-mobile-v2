class RandomProductModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  RandomProductModel({this.statusCode, this.message, this.data});

  RandomProductModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? productType;
  String? productName;
  dynamic price;
  dynamic rate;
  String? store;
  String? image; // Changed from List<String>? to String?
  bool? isFav;
  dynamic avilablePieces;
  dynamic amount;
  String? id;

  Data({
    this.productType,
    this.productName,
    this.price,
    this.rate,
    this.store,
    this.image,
    this.isFav,
    this.avilablePieces,
    this.amount,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    productType = json['productType'];
    productName = json['productName'];
    price = json['price'];
    rate = json['rate'];
    store = json['store'];
    // Handle both String and List cases from API
    if (json['image'] is List) {
      image = (json['image'] as List).isNotEmpty
          ? json['image'][0].toString()
          : null;
    } else {
      image = json['image']?.toString();
    }
    isFav = json['isFav'];
    avilablePieces = json['avilablePieces'];
    amount = json['amount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productType'] = productType;
    data['productName'] = productName;
    data['price'] = price;
    data['rate'] = rate;
    data['store'] = store;
    data['image'] = image;
    data['isFav'] = isFav;
    data['avilablePieces'] = avilablePieces;
    data['amount'] = amount;
    data['id'] = id;
    return data;
  }
}
