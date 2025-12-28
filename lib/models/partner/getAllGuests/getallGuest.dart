class getAllGuestModel {
  int? statusCode;
  String? message;
  var totalCount;
  var skip;
  var take;
  List<Data>? data;

  getAllGuestModel({this.statusCode, this.message, this.data});

  getAllGuestModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    totalCount = json['totalCount'];
    skip = json['skip'];
    take = json['take'];
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
    data['totalCount'] = this.totalCount;
    data['skip'] = this.skip;
    data['take'] = this.take;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? email;
  String? gender;
  String? bookingId;

  Data({this.id, this.name, this.email, this.gender, this.bookingId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    bookingId = json['bookingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['bookingId'] = this.bookingId;
    return data;
  }
}
