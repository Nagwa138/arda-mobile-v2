class RoomTypeModel {
  final String roomType;
  final int count;
  final int guestNum;
  final bool priceIncludeBreakFast;
  final List<String> roomImage;
  final double price;

  RoomTypeModel({
    required this.roomType,
    required this.count,
    required this.guestNum,
    required this.priceIncludeBreakFast,
    required this.roomImage,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        "roomType": roomType,
        "count": count,
        "guestNum": guestNum,
        "priceIncludeBreakFast": priceIncludeBreakFast,
        "roomImage": roomImage,
        "price": price,
      };
}

class AddAccommodationRequest {
  final String accomodationTypeId;
  final String coverPhotoName;
  final String serviceName;
  final String address;
  final String city;
  final String government;
  final String addressLink;
  final List<RoomTypeModel> roomsType;
  final String serviceDesc;
  final List<String> serverImagesName;
  final String website;
  final String officialPhone;
  final String language;
  final List<String> amenityId;
  final List<String> specialId;

  AddAccommodationRequest({
    required this.accomodationTypeId,
    required this.coverPhotoName,
    required this.serviceName,
    required this.address,
    required this.city,
    required this.government,
    required this.addressLink,
    required this.roomsType,
    required this.serviceDesc,
    required this.serverImagesName,
    required this.website,
    required this.officialPhone,
    required this.language,
    required this.amenityId,
    required this.specialId,
  });

  Map<String, dynamic> toJson() => {
        "accomodationTypeId": accomodationTypeId,
        "coverPhotoName": coverPhotoName,
        "serviceName": serviceName,
        "address": address,
        "city": city,
        "government": government,
        "addressLink": addressLink,
        "roomsType": roomsType.map((e) => e.toJson()).toList(),
        "serviceDesc": serviceDesc,
        "serverImagesName": serverImagesName,
        "website": website,
        "officialPhone": officialPhone,
        "language": language,
        "amenityId": amenityId,
        "specialId": specialId,
      };
}
