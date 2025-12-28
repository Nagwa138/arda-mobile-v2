class TripsModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  TripsModel({this.statusCode, this.message, this.data});

  TripsModel.fromJson(Map<String, dynamic> json) {
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
  String? serviceType;
  var price;
  String? from;
  String? to;
  String? startDate;
  String? endDate;
  String? tripName;
  String? image;
  var rate;
  String? status;

  Data(
      {this.id,
        this.serviceId,
        this.serviceType,
        this.price,
        this.from,
        this.to,
        this.startDate,
        this.endDate,
        this.tripName,
        this.image,
        this.rate,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['serviceId'];
    serviceType = json['serviceType'];
    price = json['price'];
    from = json['from'];
    to = json['to'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    tripName = json['tripName'];
    image = json['image'];
    rate = json['rate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceId'] = this.serviceId;
    data['serviceType'] = this.serviceType;
    data['price'] = this.price;
    data['from'] = this.from;
    data['to'] = this.to;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['tripName'] = this.tripName;
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['status'] = this.status;
    return data;
  }
}
