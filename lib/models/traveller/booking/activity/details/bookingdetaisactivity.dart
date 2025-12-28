class detailsActivityModel {
  int? statusCode;
  String? message;
  Data? data;

  detailsActivityModel({this.statusCode, this.message, this.data});

  detailsActivityModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? serviceType;
  String? activityId;
  String? image;
  String? title;
  var rate;
  var noOfPersons;
  var daysCount;
  var pricePerPerson;
  var totalPrice;

  Data(
      {this.id,
        this.serviceType,
        this.activityId,
        this.image,
        this.title,
        this.rate,
        this.noOfPersons,
        this.daysCount,
        this.pricePerPerson,
        this.totalPrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceType = json['serviceType'];
    activityId = json['activityId'];
    image = json['image'];
    title = json['title'];
    rate = json['rate'];
    noOfPersons = json['noOfPersons'];
    daysCount = json['daysCount'];
    pricePerPerson = json['pricePerPerson'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceType'] = this.serviceType;
    data['activityId'] = this.activityId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['rate'] = this.rate;
    data['noOfPersons'] = this.noOfPersons;
    data['daysCount'] = this.daysCount;
    data['pricePerPerson'] = this.pricePerPerson;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
