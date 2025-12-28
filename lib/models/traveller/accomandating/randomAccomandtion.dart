class AccomandationRandomModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  AccomandationRandomModel({this.statusCode, this.message, this.data});

  AccomandationRandomModel.fromJson(Map<String, dynamic> json) {
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
  String? accomodationId;
  List<String>? imageUrl;
  String? accomodationType;
  bool? isFav;
  String? accomodationName;
  String? address;
  var price;
  var rate;

  Data(
      {this.accomodationId,
      this.imageUrl,
      this.accomodationType,
      this.isFav,
      this.accomodationName,
      this.address,
      this.price,
      this.rate});

  Data.fromJson(Map<String, dynamic> json) {
    accomodationId = json['accomodationId'];
    imageUrl = json['imageUrl'].cast<String>();
    accomodationType = json['accomodationType'];
    isFav = json['isFav'];
    accomodationName = json['accomodationName'];
    address = json['address'];
    price = json['price'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accomodationId'] = this.accomodationId;
    data['imageUrl'] = this.imageUrl;
    data['accomodationType'] = this.accomodationType;
    data['isFav'] = this.isFav;
    data['accomodationName'] = this.accomodationName;
    data['address'] = this.address;
    data['price'] = this.price;
    data['rate'] = this.rate;
    return data;
  }
}
