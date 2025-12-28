class GetAllReviewModel {
  int? statusCode;
  String? message;
  Data? data;

  GetAllReviewModel({this.statusCode, this.message, this.data});

  GetAllReviewModel.fromJson(Map<String, dynamic> json) {
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
  var rating;
  int? reviewsCount;
  List<UsersReviews>? usersReviews;

  Data({this.rating, this.reviewsCount, this.usersReviews});

  Data.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    reviewsCount = json['reviewsCount'];
    if (json['usersReviews'] != null) {
      usersReviews = <UsersReviews>[];
      json['usersReviews'].forEach((v) {
        usersReviews!.add(new UsersReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['reviewsCount'] = this.reviewsCount;
    if (this.usersReviews != null) {
      data['usersReviews'] = this.usersReviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UsersReviews {
  String? id;
  String? userName;
  String? gender;
  String? comment;
  double? rate;
  String? date;
  String? time;

  UsersReviews(
      {this.id,
        this.userName,
        this.gender,
        this.comment,
        this.rate,
        this.date,
        this.time});

  UsersReviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    gender = json['gender'];
    comment = json['comment'];
    rate = json['rate'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['gender'] = this.gender;
    data['comment'] = this.comment;
    data['rate'] = this.rate;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
