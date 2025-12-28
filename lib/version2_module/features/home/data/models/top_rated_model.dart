class TopRatedModel {
  String? accomodationId;
  List<String>? imageUrl;
  String? accomodationType;
  bool? isFav;
  String? accomodationName;
  String? address;
  double? price;
  double? rate;

  TopRatedModel(
      {this.accomodationId,
      this.imageUrl,
      this.accomodationType,
      this.isFav,
      this.accomodationName,
      this.address,
      this.price,
      this.rate});

  factory TopRatedModel.fromJson(Map<String, dynamic> json) {
    return TopRatedModel(
      accomodationId: json['accomodationId'],
      imageUrl:
          json['imageUrl'] != null ? List<String>.from(json['imageUrl']) : null,
      accomodationType: json['accomodationType'],
      isFav: json['isFav'],
      accomodationName: json['accomodationName'],
      address: json['address'],
      rate: (json['rate'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accomodationId'] = this.accomodationId;
    data['imageUrl'] = this.imageUrl;
    data['accomodationType'] = this.accomodationType;
    data['isFav'] = this.isFav;
    data['accomodationName'] = this.accomodationName;
    data['address'] = this.address;
    data['price'] = this.price;
    data['rate'] = this.rate;
    return data;
  }
}
