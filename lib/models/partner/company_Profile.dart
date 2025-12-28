class model_company {
  int? statusCode;
  String? message;
  Data? data;

  model_company({this.statusCode, this.message, this.data});

  model_company.fromJson(Map<String, dynamic> json) {
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
  String? logo;
  String? companyName;
  String? companyCategory;
  String? governate;
  String? website;
  String? address;

  Data(
      {this.id,
        this.logo,
        this.companyName,
        this.companyCategory,
        this.governate,
        this.website,
        this.address});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    companyName = json['companyName'];
    companyCategory = json['companyCategory'];
    governate = json['governate'];
    website = json['website'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['companyName'] = this.companyName;
    data['companyCategory'] = this.companyCategory;
    data['governate'] = this.governate;
    data['website'] = this.website;
    data['address'] = this.address;
    return data;
  }
}
