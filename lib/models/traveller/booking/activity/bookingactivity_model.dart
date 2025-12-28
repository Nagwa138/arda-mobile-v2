// class bookingActivityModel {
//   int? statusCode;
//   String? message;
//   List<Data>? data;
//
//   bookingActivityModel({this.statusCode, this.message, this.data});
//
//   bookingActivityModel.fromJson(Map<String, dynamic> json) {
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
//   String? id;
//   String? serviceId;
//   String? image;
//   String? activityName;
//   var price;
//   var rate;
//
//   Data(
//       {this.id,
//         this.serviceId,
//         this.image,
//         this.activityName,
//         this.price,
//         this.rate});
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serviceId = json['serviceId'];
//     image = json['image'];
//     activityName = json['activityName'];
//     price = json['price'];
//     rate = json['rate'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['serviceId'] = this.serviceId;
//     data['image'] = this.image;
//     data['activityName'] = this.activityName;
//     data['price'] = this.price;
//     data['rate'] = this.rate;
//     return data;
//   }
// }
class bookingActivityModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  bookingActivityModel({this.statusCode, this.message, this.data});

  bookingActivityModel.fromJson(Map<String, dynamic> json) {
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
  String? serviceId;
  String? image;
  String? activityName;
  var price;
  var rate;
  String? status;

  Data(
      {this.id,
        this.serviceId,
        this.image,
        this.activityName,
        this.price,
        this.rate,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['serviceId'];
    image = json['image'];
    activityName = json['activityName'];
    price = json['price'];
    rate = json['rate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceId'] = this.serviceId;
    data['image'] = this.image;
    data['activityName'] = this.activityName;
    data['price'] = this.price;
    data['rate'] = this.rate;
    data['status'] = this.status;
    return data;
  }
}
