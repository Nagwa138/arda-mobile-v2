class GetFavouriteModelActivity {
  int? statusCode;
  String? message;
  List<Data>? data;

  GetFavouriteModelActivity({this.statusCode, this.message, this.data});

  GetFavouriteModelActivity.fromJson(Map<String, dynamic> json) {
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
  String? activitieName;
  var duration;
  var pricePerPerson;
  var rate;
  String? description;
  String? image;
  bool? isFav;
  var reviewersCount;
  String? id;

  Data(
      {this.activitieName,
        this.duration,
        this.pricePerPerson,
        this.rate,
        this.description,
        this.image,
        this.isFav,
        this.reviewersCount,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    activitieName = json['activitieName'];
    duration = json['duration'];
    pricePerPerson = json['pricePerPerson'];
    rate = json['rate'];
    description = json['description'];
    image = json['image'];
    isFav = json['isFav'];
    reviewersCount = json['reviewersCount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activitieName'] = this.activitieName;
    data['duration'] = this.duration;
    data['pricePerPerson'] = this.pricePerPerson;
    data['rate'] = this.rate;
    data['description'] = this.description;
    data['image'] = this.image;
    data['isFav'] = this.isFav;
    data['reviewersCount'] = this.reviewersCount;
    data['id'] = this.id;
    return data;
  }
}
