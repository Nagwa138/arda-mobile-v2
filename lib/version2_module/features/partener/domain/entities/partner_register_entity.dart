class PartnerRegisterEntity {
  final String email;
  final String? firebaseToken;
  final String companyName;
  final String? applicantName;
  final String? governmentId;
  final String? addressLink;
  final String? websiteLink;
  final String? serviceId;
  final String? companyLogo;
  final String? tripType;

  PartnerRegisterEntity({
    required this.email,
    this.firebaseToken,
    required this.companyName,
    this.applicantName,
    this.governmentId,
    this.addressLink,
    this.websiteLink,
    this.serviceId,
    this.companyLogo,
    this.tripType,
  });
}

class ApplicationServiceEntity {
  final String id;
  final String serviceName;

  ApplicationServiceEntity({
    required this.id,
    required this.serviceName,
  });
}

class GovernmentEntity {
  final String id;
  final String name;

  GovernmentEntity({
    required this.id,
    required this.name,
  });
}
