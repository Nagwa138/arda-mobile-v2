class GetAllTripsModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  GetAllTripsModel({this.statusCode, this.message, this.data});

  GetAllTripsModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  String? time;
  String? to;
  String? from;
  int? availableSeats;
  int? pricePerPerson;
  String? image;
  String? id;

  Data(
      {this.name,
        this.date,
        this.time,
        this.to,
        this.from,
        this.availableSeats,
        this.pricePerPerson,
        this.image,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    time = json['time'];
    to = json['to'];
    from = json['from'];
    availableSeats = json['availableSeats'];
    pricePerPerson = json['pricePerPerson'];
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['time'] = this.time;
    data['to'] = this.to;
    data['from'] = this.from;
    data['availableSeats'] = this.availableSeats;
    data['pricePerPerson'] = this.pricePerPerson;
    data['image'] = this.image;
    data['id'] = this.id;
    return data;
  }
}
