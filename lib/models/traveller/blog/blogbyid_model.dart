class GetBlogByIdModel {
  int? statusCode;
  String? message;
  Data? data;

  GetBlogByIdModel({this.statusCode, this.message, this.data});

  GetBlogByIdModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? contant;
  String? author;
  String? publishedOn;
  String? imageName;
  String? id;
  bool? isFavourite;

  Data(
      {this.title,
        this.contant,
        this.author,
        this.publishedOn,
        this.imageName,
        this.isFavourite,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    contant = json['contant'];
    author = json['author'];
    publishedOn = json['publishedOn'];
    imageName = json['imageName'];
    id = json['id'];
    isFavourite = json['isFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['contant'] = this.contant;
    data['author'] = this.author;
    data['publishedOn'] = this.publishedOn;
    data['imageName'] = this.imageName;
    data['id'] = this.id;
    data['isFavourite'] = this.isFavourite;
    return data;
  }
}