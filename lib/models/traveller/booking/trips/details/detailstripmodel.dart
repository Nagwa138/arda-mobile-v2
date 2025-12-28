// class TripsModelDetails {
//   int? statusCode;
//   String? message;
//   Data? data;
//
//   TripsModelDetails({this.statusCode, this.message, this.data});
//
//   TripsModelDetails.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? serviceType;
//   String? tripType;
//   String? tripId;
//   String? tripName;
//   String? from;
//   String? to;
//   String? startDate;
//   String? endDate;
//   var pricePerPersone;
//   var noOfPersons;
//   var totalPrice;
//   String? status;
//
//   Data(
//       {this.id,
//         this.serviceType,
//         this.tripType,
//         this.tripId,
//         this.tripName,
//         this.from,
//         this.to,
//         this.startDate,
//         this.endDate,
//         this.pricePerPersone,
//         this.noOfPersons,
//         this.totalPrice,
//         this.status});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serviceType = json['serviceType'];
//     tripType = json['tripType'];
//     tripId = json['tripId'];
//     tripName = json['tripName'];
//     from = json['from'];
//     to = json['to'];
//     startDate = json['startDate'];
//     endDate = json['endDate'];
//     pricePerPersone = json['pricePerPersone'];
//     noOfPersons = json['noOfPersons'];
//     totalPrice = json['totalPrice'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['serviceType'] = this.serviceType;
//     data['tripType'] = this.tripType;
//     data['tripId'] = this.tripId;
//     data['tripName'] = this.tripName;
//     data['from'] = this.from;
//     data['to'] = this.to;
//     data['startDate'] = this.startDate;
//     data['endDate'] = this.endDate;
//     data['pricePerPersone'] = this.pricePerPersone;
//     data['noOfPersons'] = this.noOfPersons;
//     data['totalPrice'] = this.totalPrice;
//     data['status'] = this.status;
//     return data;
//   }
// }
class TripsModelDetails {
  int? statusCode;
  String? message;
  Data? data;

  TripsModelDetails({this.statusCode, this.message, this.data});

  TripsModelDetails.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? serviceType;
  String? tripType;
  String? tripId;
  String? tripName;
  String? from;
  String? to;
  String? startDate;
  String? endDate;
  int? pricePerPersone;
  int? noOfPersons;
  var totalPrice;
  String? status;
  var rate;
  String? image;

  Data(
      {this.id,
        this.serviceType,
        this.tripType,
        this.tripId,
        this.tripName,
        this.from,
        this.to,
        this.startDate,
        this.endDate,
        this.pricePerPersone,
        this.noOfPersons,
        this.totalPrice,
        this.status,
        this.rate,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceType = json['serviceType'];
    tripType = json['tripType'];
    tripId = json['tripId'];
    tripName = json['tripName'];
    from = json['from'];
    to = json['to'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    pricePerPersone = json['pricePerPersone'];
    noOfPersons = json['noOfPersons'];
    totalPrice = json['totalPrice'];
    status = json['status'];
    rate = json['rate'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceType'] = this.serviceType;
    data['tripType'] = this.tripType;
    data['tripId'] = this.tripId;
    data['tripName'] = this.tripName;
    data['from'] = this.from;
    data['to'] = this.to;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['pricePerPersone'] = this.pricePerPersone;
    data['noOfPersons'] = this.noOfPersons;
    data['totalPrice'] = this.totalPrice;
    data['status'] = this.status;
    data['rate'] = this.rate;
    data['image'] = this.image;
    return data;
  }
}
