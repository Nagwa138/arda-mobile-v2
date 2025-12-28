class AddProductRequest {
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final bool isDeliveryAvailable;
  final double? shippingCost;
  final String location;
  final String rulesAndCancellationPolicy;
  final String? importantInformation;

  AddProductRequest({
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.isDeliveryAvailable,
    this.shippingCost,
    required this.location,
    required this.rulesAndCancellationPolicy,
    this.importantInformation,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "categoryId": categoryId,
        "isDeliveryAvailable": isDeliveryAvailable,
        "shippingCost": shippingCost,
        "location": location,
        "rulesAndCancellationPolicy": rulesAndCancellationPolicy,
        "importantInformation": importantInformation,
      };
}
