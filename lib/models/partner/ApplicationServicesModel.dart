class ApplicationServicesModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  ApplicationServicesModel({this.statusCode, this.message, this.data});

  ApplicationServicesModel.fromJson(Map<String, dynamic> json) {
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
  String? id;

  Data({this.name, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['serviceName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceName'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
