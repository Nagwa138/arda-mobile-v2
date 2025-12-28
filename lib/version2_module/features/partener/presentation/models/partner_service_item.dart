enum PartnerServiceType { accommodation, activity, product, trip }

class PartnerServiceItem {
  final String id;
  final String title;
  final String location;
  final String priceText;
  final double rating;
  final String imageUrl;
  final String status;

  PartnerServiceItem({
    required this.id,
    required this.title,
    required this.location,
    required this.priceText,
    required this.rating,
    required this.imageUrl,
    required this.status,
  });
}
