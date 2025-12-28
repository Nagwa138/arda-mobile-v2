class GetFavouriteModelAccomandation {
  int? statusCode;
  String? message;
  List<Data>? data;

  GetFavouriteModelAccomandation({this.statusCode, this.message, this.data});

  GetFavouriteModelAccomandation.fromJson(Map<String, dynamic> json) {
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
  String? accomodationType;
  String? serviceName;
  String? coverPhotoUrl;
  String? city;
  String? government;
  var rate;
  var reservationPrice;
  bool? isFav;
  String? id;

  Data(
      {this.accomodationType,
        this.serviceName,
        this.coverPhotoUrl,
        this.city,
        this.government,
        this.rate,
        this.reservationPrice,
        this.isFav,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    accomodationType = json['accomodationType'];
    serviceName = json['serviceName'];
    coverPhotoUrl = json['coverPhotoUrl'];
    city = json['city'];
    government = json['government'];
    rate = json['rate'];
    reservationPrice = json['reservationPrice'];
    isFav = json['isFav'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accomodationType'] = this.accomodationType;
    data['serviceName'] = this.serviceName;
    data['coverPhotoUrl'] = this.coverPhotoUrl;
    data['city'] = this.city;
    data['government'] = this.government;
    data['rate'] = this.rate;
    data['reservationPrice'] = this.reservationPrice;
    data['isFav'] = this.isFav;
    data['id'] = this.id;
    return data;
  }
}
