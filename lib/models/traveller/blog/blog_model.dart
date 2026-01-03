class BlogModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  BlogModel({this.statusCode, this.message, this.data});

  BlogModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  Null contant;
  Null author;
  String? publishedOn;
  String? imageName;
  String? id;

  Data(
      {this.title,
      this.contant,
      this.author,
      this.publishedOn,
      this.imageName,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    contant = json['contant'];
    author = json['author'];
    publishedOn = json['publishedOn'];
    imageName = json['imageName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['contant'] = this.contant;
    data['author'] = this.author;
    data['publishedOn'] = this.publishedOn;
    data['imageName'] = this.imageName;
    data['id'] = this.id;
    return data;
  }
}
