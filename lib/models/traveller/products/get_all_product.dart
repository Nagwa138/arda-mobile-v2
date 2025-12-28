class GetAllProductModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  GetAllProductModel({this.statusCode, this.message, this.data});

  GetAllProductModel.fromJson(Map<String, dynamic> json) {
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
  String? imageName;
  String? id;

  Data({this.name, this.imageName, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageName = json['imageName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imageName'] = this.imageName;
    data['id'] = this.id;
    return data;
  }
}
