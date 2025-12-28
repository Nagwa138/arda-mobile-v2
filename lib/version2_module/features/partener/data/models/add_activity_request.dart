class AddActivityRequest {
  final String name;
  final String providerName;
  final String description;
  final int durationInHours;
  final double pricePerPerson;
  final String activityLocation;
  final String workTimes;
  final String whatsIncluded;
  final String rulesAndCancellationPolicy;
  final String? importantInformation;
  final String image;

  AddActivityRequest({
    required this.name,
    required this.providerName,
    required this.description,
    required this.durationInHours,
    required this.pricePerPerson,
    required this.activityLocation,
    required this.workTimes,
    required this.whatsIncluded,
    required this.rulesAndCancellationPolicy,
    this.importantInformation,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "providerName": providerName,
        "description": description,
        "durationInHours": durationInHours,
        "pricePerPerson": pricePerPerson,
        "activityLocation": activityLocation,
        "workTimes": workTimes,
        "whatsIncluded": whatsIncluded,
        "rulesAndCancellationPolicy": rulesAndCancellationPolicy,
        "importantInformation": importantInformation,
        "image": image,
      };
}
