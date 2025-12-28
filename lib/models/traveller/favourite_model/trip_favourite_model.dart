class GetFavouriteModelTrip {
  int? statusCode;
  String? message;
  List<Data>? data;

  GetFavouriteModelTrip({this.statusCode, this.message, this.data});

  GetFavouriteModelTrip.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? date;
  int? pricePerPerson;
  String? imageName;
  bool? isFav;
  int? rate;
  String? id;

  Data(
      {this.name,
        this.date,
        this.pricePerPerson,
        this.imageName,
        this.isFav,
        this.rate,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    pricePerPerson = json['pricePerPerson'];
    imageName = json['imageName'];
    isFav = json['isFav'];
    rate = json['rate'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['pricePerPerson'] = this.pricePerPerson;
    data['imageName'] = this.imageName;
    data['isFav'] = this.isFav;
    data['rate'] = this.rate;
    data['id'] = this.id;
    return data;
  }
}
