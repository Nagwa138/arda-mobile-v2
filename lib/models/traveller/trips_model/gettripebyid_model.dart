class GetTripsByIdModel {
  int? statusCode;
  String? message;
  Data? data;

  GetTripsByIdModel({this.statusCode, this.message, this.data});

  GetTripsByIdModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? description;
  var pricePerPerson;
  String? startDateAndMovementTime;
  String? endDateAdnArrivalTime;
  String? pickupMeetingLocation;
  String? endPoint;
  String? image;
  var durationInHours;
  String? whatsIncluded;
  String? rulesAndCancellationPolicy;
  String? importantInformation;
  String? providerName;
  bool? fav;
  bool? ended;
  String? id;

  Data({
    this.name,
    this.description,
    this.pricePerPerson,
    this.startDateAndMovementTime,
    this.endDateAdnArrivalTime,
    this.pickupMeetingLocation,
    this.endPoint,
    this.image,
    this.durationInHours,
    this.whatsIncluded,
    this.rulesAndCancellationPolicy,
    this.importantInformation,
    this.providerName,
    this.fav,
    this.ended,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    pricePerPerson = json['pricePerPerson'];
    startDateAndMovementTime = json['startDateAndMovementTime'];
    endDateAdnArrivalTime = json['endDateAdnArrivalTime'];
    pickupMeetingLocation = json['pickupMeetingLocation'];
    endPoint = json['endPoint'];
    image = json['image'];
    durationInHours = json['durationInHours'];
    whatsIncluded = json['whatsIncluded'];
    rulesAndCancellationPolicy = json['rulesAndCancellationPolicy'];
    importantInformation = json['importantInformation'];
    providerName = json['providerName'];
    fav = json['fav'];
    ended = json['ended'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['pricePerPerson'] = pricePerPerson;
    data['startDateAndMovementTime'] = startDateAndMovementTime;
    data['endDateAdnArrivalTime'] = endDateAdnArrivalTime;
    data['pickupMeetingLocation'] = pickupMeetingLocation;
    data['endPoint'] = endPoint;
    data['image'] = image;
    data['durationInHours'] = durationInHours;
    data['whatsIncluded'] = whatsIncluded;
    data['rulesAndCancellationPolicy'] = rulesAndCancellationPolicy;
    data['importantInformation'] = importantInformation;
    data['providerName'] = providerName;
    data['fav'] = fav;
    data['ended'] = ended;
    data['id'] = id;
    return data;
  }
}
