class GetActivityByIdModel {
  int? statusCode;
  String? message;
  ActivityData? data;

  GetActivityByIdModel({
    this.statusCode,
    this.message,
    this.data,
  });

  GetActivityByIdModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? ActivityData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['statusCode'] = statusCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class ActivityData {
  String? id;
  String? name;
  num? durationInHours;
  num? pricePerPerson;
  num? rate;
  String? description;
  String? image;
  bool? isFav;
  num? reviewersCount;
  String? activityLocation;
  String? providerName;
  String? workTimes;
  String? whatsIncluded;
  String? rulesAndCancellationPolicy;
  String? importantInformation;

  ActivityData({
    this.id,
    this.name,
    this.durationInHours,
    this.pricePerPerson,
    this.rate,
    this.description,
    this.image,
    this.isFav,
    this.reviewersCount,
    this.activityLocation,
    this.providerName,
    this.workTimes,
    this.whatsIncluded,
    this.rulesAndCancellationPolicy,
    this.importantInformation,
  });

  ActivityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    durationInHours = json['durationInHours'];
    pricePerPerson = json['pricePerPerson'];
    rate = json['rate'];
    description = json['description'];
    image = json['image'];
    isFav = json['isFav'];
    reviewersCount = json['reviewersCount'];
    activityLocation = json['activityLocation'];
    providerName = json['providerName'];
    workTimes = json['workTimes'];
    whatsIncluded = json['whatsIncluded'];
    rulesAndCancellationPolicy = json['rulesAndCancellationPolicy'];
    importantInformation = json['importantInformation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['durationInHours'] = durationInHours;
    map['pricePerPerson'] = pricePerPerson;
    map['rate'] = rate;
    map['description'] = description;
    map['image'] = image;
    map['isFav'] = isFav;
    map['reviewersCount'] = reviewersCount;
    map['activityLocation'] = activityLocation;
    map['providerName'] = providerName;
    map['workTimes'] = workTimes;
    map['whatsIncluded'] = whatsIncluded;
    map['rulesAndCancellationPolicy'] = rulesAndCancellationPolicy;
    map['importantInformation'] = importantInformation;
    return map;
  }
}
