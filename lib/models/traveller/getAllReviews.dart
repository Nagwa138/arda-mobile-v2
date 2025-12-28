class getAllReviews {
  int? statusCode;
  String? message;
  Data? data;

  getAllReviews({this.statusCode, this.message, this.data});

  getAllReviews.fromJson(Map<String, dynamic> json) {
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
  var totalRate;
  var reviewrsCount;
  var recomendPercent;
  DetailedRate? detailedRate;
  List<UsersReviews>? usersReviews;

  Data(
      {this.totalRate,
        this.reviewrsCount,
        this.recomendPercent,
        this.detailedRate,
        this.usersReviews});

  Data.fromJson(Map<String, dynamic> json) {
    totalRate = json['totalRate'];
    reviewrsCount = json['reviewrsCount'];
    recomendPercent = json['recomendPercent'];
    detailedRate = json['detailedRate'] != null
        ? new DetailedRate.fromJson(json['detailedRate'])
        : null;
    if (json['usersReviews'] != null) {
      usersReviews = <UsersReviews>[];
      json['usersReviews'].forEach((v) {
        usersReviews!.add(new UsersReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalRate'] = this.totalRate;
    data['reviewrsCount'] = this.reviewrsCount;
    data['recomendPercent'] = this.recomendPercent;
    if (this.detailedRate != null) {
      data['detailedRate'] = this.detailedRate!.toJson();
    }
    if (this.usersReviews != null) {
      data['usersReviews'] = this.usersReviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailedRate {
  var one;
  var two;
  var three;
  var four;
  var five;

  DetailedRate({this.one, this.two, this.three, this.four, this.five});

  DetailedRate.fromJson(Map<String, dynamic> json) {
    one = json['one'];
    two = json['two'];
    three = json['three'];
    four = json['four'];
    five = json['five'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['one'] = this.one;
    data['two'] = this.two;
    data['three'] = this.three;
    data['four'] = this.four;
    data['five'] = this.five;
    return data;
  }
}

class UsersReviews {
  String? id;
  String? userName;
  String? gender;
  String? comment;
  var rate;
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
