class GetProductOneById {
  int? statusCode;
  String? message;
  Data? data;

  GetProductOneById({this.statusCode, this.message, this.data});

  GetProductOneById.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? productType;
  String? productName;
  dynamic price;
  String? description;
  dynamic availablePieces;
  String? store;
  String? image; // Changed to String to match API
  List<dynamic>? reviewDto;
  String? companyId;
  String? categoryId;
  String? location;
  String? rulesAndCancellationPolicy;
  String? importantInformation;
  bool? isDeliveryAvailable;
  dynamic shippingCost;
  String? id;

  Data({
    this.productType,
    this.productName,
    this.price,
    this.description,
    this.availablePieces,
    this.store,
    this.image,
    this.reviewDto,
    this.companyId,
    this.categoryId,
    this.location,
    this.rulesAndCancellationPolicy,
    this.importantInformation,
    this.isDeliveryAvailable,
    this.shippingCost,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    productType = json['productType'];
    productName = json['productName'];
    price = json['price'];
    description = json['description'];
    availablePieces = json['availablePieces'];
    store = json['store'];
    // Handle both String and List cases
    if (json['image'] is List) {
      image = (json['image'] as List).isNotEmpty
          ? json['image'][0].toString()
          : null;
    } else {
      image = json['image']?.toString();
    }
    reviewDto = json['reviewDto'] != null ? List.from(json['reviewDto']) : [];
    companyId = json['companyId'];
    categoryId = json['categoryId'];
    location = json['location'];
    rulesAndCancellationPolicy = json['rulesAndCancellationPolicy'];
    importantInformation = json['importantInformation'];
    isDeliveryAvailable = json['isDeliveryAvailable'];
    shippingCost = json['shippingCost'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productType'] = productType;
    data['productName'] = productName;
    data['price'] = price;
    data['description'] = description;
    data['availablePieces'] = availablePieces;
    data['store'] = store;
    data['image'] = image;
    data['reviewDto'] = reviewDto;
    data['companyId'] = companyId;
    data['categoryId'] = categoryId;
    data['location'] = location;
    data['rulesAndCancellationPolicy'] = rulesAndCancellationPolicy;
    data['importantInformation'] = importantInformation;
    data['isDeliveryAvailable'] = isDeliveryAvailable;
    data['shippingCost'] = shippingCost;
    data['id'] = id;
    return data;
  }
}
