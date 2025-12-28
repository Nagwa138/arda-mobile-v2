// class GetAllProductById {
//   int? statusCode;
//   String? message;
//   List<Data>? data;
//
//   GetAllProductById({this.statusCode, this.message, this.data});
//
//   GetAllProductById.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? productType;
//   String? productName;
//   var price;
//   var rate;
//   Null? description;
//   int? availablePieces;
//   String? store;
//   List<String>? image;
//   Null? companyId;
//   Null? reviewDto;
//   String? additionDate;
//   String? productCategoryId;
//   String? id;
//
//   Data(
//       {this.productType,
//         this.productName,
//         this.price,
//         this.rate,
//         this.description,
//         this.availablePieces,
//         this.store,
//         this.image,
//         this.companyId,
//         this.reviewDto,
//         this.additionDate,
//         this.productCategoryId,
//         this.id});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     productType = json['productType'];
//     productName = json['productName'];
//     price = json['price'];
//     rate = json['rate'];
//     description = json['description'];
//     availablePieces = json['availablePieces'];
//     store = json['store'];
//     image = json['image'].cast<String>();
//     companyId = json['companyId'];
//     reviewDto = json['reviewDto'];
//     additionDate = json['additionDate'];
//     productCategoryId = json['productCategoryId'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['productType'] = this.productType;
//     data['productName'] = this.productName;
//     data['price'] = this.price;
//     data['rate'] = this.rate;
//     data['description'] = this.description;
//     data['availablePieces'] = this.availablePieces;
//     data['store'] = this.store;
//     data['image'] = this.image;
//     data['companyId'] = this.companyId;
//     data['reviewDto'] = this.reviewDto;
//     data['additionDate'] = this.additionDate;
//     data['productCategoryId'] = this.productCategoryId;
//     data['id'] = this.id;
//     return data;
//   }
// }
class GetAllProductById {
  int? statusCode;
  String? message;
  List<Data>? data;

  GetAllProductById({this.statusCode, this.message, this.data});

  GetAllProductById.fromJson(Map<String, dynamic> json) {
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
  String? store;
  List<String>? image;
  bool? isFav;
  var avilablePieces;
  var amount;
  String? id;

  Data(
      {this.productType,
        this.productName,
        this.price,
        this.rate,
        this.store,
        this.image,
        this.isFav,
        this.avilablePieces,
        this.amount,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    productType = json['productType'];
    productName = json['productName'];
    price = json['price'];
    rate = json['rate'];
    store = json['store'];
    image = json['image'].cast<String>();
    isFav = json['isFav'];
    avilablePieces = json['avilablePieces'];
    amount = json['amount'];
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
    data['avilablePieces'] = this.avilablePieces;
    data['amount'] = this.amount;
    data['id'] = this.id;
    return data;
  }
}
