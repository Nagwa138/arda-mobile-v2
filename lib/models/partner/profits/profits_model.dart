class getProfitsModel {
  int? statusCode;
  String? message;
  Data? data;

  getProfitsModel({this.statusCode, this.message, this.data});

  getProfitsModel.fromJson(Map<String, dynamic> json) {
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
  var totalProfits;
  var totalBooking;

  Data({this.totalProfits, this.totalBooking});

  Data.fromJson(Map<String, dynamic> json) {
    totalProfits = json['totalProfits'];
    totalBooking = json['totalBooking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalProfits'] = this.totalProfits;
    data['totalBooking'] = this.totalBooking;
    return data;
  }
}
