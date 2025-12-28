class CardModel {
  final String title;
  final String description;
  final String image;
  final String store;
  final double price;
  final String productId;
  int amount;
  int pices;

  CardModel(
      {required this.title,
      required this.store,
      required this.description,
      required this.image,
      required this.productId,
      required this.amount,
      required this.pices,
      required this.price});

  // Convert a CardModel object into a Map object
  CardModel copyWith(
      {String? productId,
      String? title,
      double? price,
      String? description,
      int? amount,
      String? store,
        var pices,
      String? image}) {
    return CardModel(
      productId: productId ?? this.productId,

      title: title ?? this.title,
      price: price ?? this.price,
      pices: pices ?? this.pices,
      amount: amount ?? this.amount,
      store: store ?? this.store,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'store': store,
      'productId': productId,
      'price': price,
      'amount': amount,
      'pices' : pices
    };
  }

  // Convert a Map object into a CardModel object
  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
        title: map['title'],
        description: map['description'],
        image: map['image'],
        store: map['store'],
        price: map['price'],
        productId: map['productId'],
        pices : map['pices'],
        amount: map['amount']);

  }
}
