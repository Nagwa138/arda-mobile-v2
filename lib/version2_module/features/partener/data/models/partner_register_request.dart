class PartnerRegisterRequest {
  final String email;
  final String? firebaseToken;
  final PartnerInformation partnerInformation;

  PartnerRegisterRequest({
    required this.email,
    this.firebaseToken,
    required this.partnerInformation,
  });

  Map<String, String> toFormFields() {
    final fields = <String, String>{
      'Email': email,
      'PartenerInformation.CompanyName': partnerInformation.companyName,
      'PartenerInformation.AddressLink': 'N/A', // قيمة مؤقتة للعنوان
    };

    if (firebaseToken != null) {
      fields['FirebaseToken'] = firebaseToken!;
    }
    if (partnerInformation.applicantName != null) {
      fields['PartenerInformation.ApplicantName'] =
          partnerInformation.applicantName!;
    }
    if (partnerInformation.governmentId != null) {
      fields['PartenerInformation.GovernmentId'] =
          partnerInformation.governmentId!;
    }
    if (partnerInformation.serviceId != null) {
      fields['PartenerInformation.ServiceId'] = partnerInformation.serviceId!;
    }
    if (partnerInformation.tripType != null) {
      fields['PartenerInformation.TripType'] = partnerInformation.tripType!;
    }

    return fields;
  }

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'FirebaseToken': firebaseToken,
      'PartenerInformation.CompanyName': partnerInformation.companyName,
      'PartenerInformation.ApplicantName': partnerInformation.applicantName,
      'PartenerInformation.GovernmentId': partnerInformation.governmentId,
      'PartenerInformation.AddressLink': partnerInformation.addressLink,
      'PartenerInformation.WebSiteLink': partnerInformation.websiteLink,
      'PartenerInformation.ServiceId': partnerInformation.serviceId,
      'PartenerInformation.CompanyLogo': partnerInformation.companyLogo,
      'PartenerInformation.TripType': partnerInformation.tripType,
    };
  }
}

class PartnerInformation {
  final String companyName;
  final String? applicantName;
  final String? governmentId;
  final String? addressLink;
  final String? websiteLink;
  final String? serviceId;
  final String? companyLogo;
  final String? tripType;

  PartnerInformation({
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
