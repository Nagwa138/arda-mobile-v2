class TripModel {
  final String id;
  final String title;
  final String description;
  final num priceText;
  final String location;
  final String? imageUrl;
  final String companyId;
  final String providerName;
  final String durationInHours;
  final String endPoint;
  final String whatsIncluded;
  final String rulesAndCancellationPolicy;
  final String importantInformation;
  final String status;
  final String? rejectionReason;
  final String activationStatus;
  final num? rating;

  TripModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priceText,
    required this.location,
    this.rating,
    this.imageUrl,
    required this.companyId,
    required this.providerName,
    required this.durationInHours,
    required this.endPoint,
    required this.whatsIncluded,
    required this.rulesAndCancellationPolicy,
    required this.importantInformation,
    required this.status,
    this.rejectionReason,
    required this.activationStatus,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] ?? '',
      title: json['name'] ?? '',
      description: json['description'] ?? '',
      priceText: json['pricePerPerson'] ?? 0,
      location: json['pickupMeetingLocation'] ?? '',
      imageUrl: json['image'],
      companyId: json['companyId'] ?? '',
      providerName: json['providerName'] ?? '',
      durationInHours: json['durationInHours']?.toString() ?? '',
      endPoint: json['endPoint'] ?? '',
      whatsIncluded: json['whatsIncluded'] ?? '',
      rulesAndCancellationPolicy: json['rulesAndCancellationPolicy'] ?? '',
      importantInformation: json['importantInformation'] ?? '',
      status: json['progressStatus'] ?? '',
      rejectionReason: json['rejectionReason'],
      activationStatus: json['activationStatus'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'description': description,
      'pricePerPerson': priceText,
      'pickupMeetingLocation': location,
      'image': imageUrl,
      'companyId': companyId,
      'providerName': providerName,
      'durationInHours': durationInHours,
      'endPoint': endPoint,
      'whatsIncluded': whatsIncluded,
      'rulesAndCancellationPolicy': rulesAndCancellationPolicy,
      'importantInformation': importantInformation,
      'progressStatus': status,
      'rejectionReason': rejectionReason,
      'activationStatus': activationStatus,
      'rating': rating,
    };
  }
}
