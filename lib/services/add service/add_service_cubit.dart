import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/models/partner/AccommodationTypeModel.dart';
import 'package:PassPort/models/partner/AmenitiesModel.dart';
import 'package:PassPort/models/partner/SpecialsModel.dart';
import 'package:PassPort/screens/add%20service/addServices.dart';
import 'package:http/http.dart' as http;

part 'add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit() : super(AddServiceInitial());
  final imagePicker = ImagePicker();
  Api api = Api();
  final storage = new FlutterSecureStorage();

  TextEditingController placeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController governateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressLinkController = TextEditingController();
  var locationForm = GlobalKey<FormState>();
  var serviceForm = GlobalKey<FormState>();
  var roomDetailsForm = GlobalKey<FormState>();
  var contactForm = GlobalKey<FormState>();

  TextEditingController serviceNameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController empController = TextEditingController();
  TextEditingController rulesController = TextEditingController();
  TextEditingController importantController = TextEditingController();

  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();

  bool isOtherAmenitySelected = false;
  TextEditingController customAmenityController = TextEditingController();
  List<String> customAmenities = [];

  String descriptionIndex = '6ee2cdd7-18da-4b24-b6b9-84e0be7389eb';
  int currentIndex = 0;
  ///////////
  int singleRoomNum = 0;
  int singleRoomNumAdult = 0;
  int child = 0;

  int night = 0;
  int singleRoomNumActvity = 1;
  int singleRoomNumtrip = 0;

  Map<String, int> selectedRooms = {}; // roomType: quantity

  void updateRoomQuantity({required String roomId, required int quantity}) {
    if (quantity > 0) {
      selectedRooms[roomId] = quantity;
    } else {
      selectedRooms.remove(roomId);
    }
    emit(UpdateRoomQuantityState()); // لازم تعمل الـ State ده
  }

  changeSingleRoomNumActvity({bool isAdded = false}) {
    if (isAdded) {
      singleRoomNumActvity++;
    } else {
      if (singleRoomNumActvity != 0) {
        singleRoomNumActvity--;
      }
    }
    sumOfRooms();
  }

  changeSingleRoomNumTrips({
    bool isAdded = false,
  }) {
    if (isAdded) {
      singleRoomNumActvity++;
    } else {
      if (singleRoomNumActvity != 0) {
        singleRoomNumActvity--;
      }
    }
    sumOfRooms();
  }

  XFile? singleRoomImage;
  TextEditingController singleRoomNightController = TextEditingController();
  bool agree = false;
  bool agreeDouble = false;

  TextEditingController singleRoomGuestController = TextEditingController();
  int doubleRoomNum = 0;
  XFile? doubleRoomImage;
  TextEditingController doubleRoomNightController = TextEditingController();
  TextEditingController doubleRoomGuestController = TextEditingController();
  int tripleRoomNum = 0;
  XFile? tripleRoomImage;
  TextEditingController tripleRoomNightController = TextEditingController();
  TextEditingController tripleRoomGuestController = TextEditingController();
  int kingRoomNum = 0;
  XFile? kingRoomImage;
  TextEditingController kingRoomNightController = TextEditingController();
  TextEditingController kingRoomGuestController = TextEditingController();
  /////////////
  int sumOfAllRooms = 0;

  List amenities = [];
  List feature = [];
  List<XFile> serviceImages = [];
  int serviceImageCoverImageNumber = 0;

  ////models//////
  AccommodationTypeModel? accommodationTypeModel;
  SpecialsModel? specialsModel;
  AmenitiesModel? amenitiesModel;
  bool agreeTriple = false;
  bool agreeKingSize = false;

  void changeAgree(value) {
    emit(AgreeCheckLoading());
    agree = value;
    emit(AgreeCheckLoadingSuccessful());
  }

  void changeAgreeDouble(value) {
    emit(AgreeCheckDoubleLoading());
    agreeDouble = value;
    emit(AgreeCheckDoubleLoadingSuccessful());
  }

  void changeAgreeTriple(value) {
    emit(AgreeCheckTripleLoading());
    agreeTriple = value;
    emit(AgreeCheckTripleLoadingSuccessful());
  }

  void changeAgreeKingSize(value) {
    emit(AgreeCheckKingSizeLoading());
    agreeKingSize = value;
    emit(AgreeCheckKingSizeLoadingSuccessful());
  }

  addSingleRoomImage({bool isPicked = false}) {
    if (isPicked) {
      // singleRoomImage = null;
      imagePicker
          .pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1920,
      )
          .then((value) {
        singleRoomImage = value;
        emit(AddServiceRoomNumChanged());
      });
    } else {
      // singleRoomImage = null;
      imagePicker
          .pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1920,
      )
          .then((value) {
        singleRoomImage = value;
        emit(AddServiceRoomNumChanged());
      });
    }
    print('done');
  }

  removeSingleRoomImage() {
    singleRoomImage = null;
    emit(AddServiceRoomNumChanged());
  }

  addDoubleRoomImage({bool isPicked = false}) {
    if (isPicked) {
      // doubleRoomImage = null;
      imagePicker
          .pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1920,
      )
          .then((value) {
        doubleRoomImage = value;
        emit(AddServiceRoomNumChanged());
      });
    } else {
      // doubleRoomImage = null;
      imagePicker
          .pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1920,
      )
          .then((value) {
        doubleRoomImage = value;
        emit(AddServiceRoomNumChanged());
      });
    }
  }

  removeDoubleRoomImage() {
    doubleRoomImage = null;
    emit(AddServiceRoomNumChanged());
  }

  addTripleRoomImage({bool isPicked = false}) {
    if (isPicked) {
      // tripleRoomImage = null;
      imagePicker
          .pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1920,
      )
          .then((value) {
        tripleRoomImage = value;
        emit(AddServiceRoomNumChanged());
      });
    } else {
      // tripleRoomImage = null;
      imagePicker
          .pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1920,
      )
          .then((value) {
        tripleRoomImage = value;
        emit(AddServiceRoomNumChanged());
      });
    }
  }

  removeTripleRoomImage() {
    tripleRoomImage = null;
    emit(AddServiceRoomNumChanged());
  }

  addKingRoomImage({bool isPicked = false}) {
    if (isPicked) {
      // kingRoomImage = null;
      imagePicker
          .pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1920,
      )
          .then((value) {
        kingRoomImage = value;
        emit(AddServiceRoomNumChanged());
      });
    } else {
      // kingRoomImage = null;
      imagePicker
          .pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1920,
      )
          .then((value) {
        kingRoomImage = value;
        emit(AddServiceRoomNumChanged());
      });
    }
  }

  removeKingRoomImage() {
    kingRoomImage = null;
    emit(AddServiceRoomNumChanged());
  }

  changeNight({bool isAdded = false}) {
    if (isAdded) {
      night++;
    } else {
      if (night != 0) {
        night--;
      }
    }
    sumOfRooms();
  }

  void toggleOtherAmenity() {
    isOtherAmenitySelected = !isOtherAmenitySelected;
    if (!isOtherAmenitySelected) {
      customAmenityController.clear();
      customAmenities.clear();
    }
    emit(AddServiceInitial()); // أو أي state تستخدمه لتحديث الـ UI
  }

  void addCustomAmenity(String amenity) {
    if (!customAmenities.contains(amenity)) {
      customAmenities.add(amenity);
      emit(AddServiceInitial());
    }
  }

  void removeCustomAmenity(String amenity) {
    customAmenities.remove(amenity);
    emit(AddServiceInitial());
  }

  void changeDescriptionIndex(String index) {
    descriptionIndex = index;
    emit(AddServiceDescriptionIndex());
  }

  changeSingleRoomNum({bool isAdded = false}) {
    if (isAdded) {
      singleRoomNum++;
    } else {
      if (singleRoomNum != 0) {
        singleRoomNum--;
      }
    }
    sumOfRooms();
  }

  /// change product

  ///
  changeSingleRoomNumUpdate({bool isAdded = false}) {
    if (isAdded) {
      if (singleRoomNum >= 10) {
        print("4 > is  ${singleRoomNum}");
      } else {
        singleRoomNum++;
      }
    } else {
      if (singleRoomNum != 0) {
        singleRoomNum--;
      }
    }
    sumOfRooms();
  }

  ///
  changeSingleRoomNumUpdateAdult({bool isAdded = false}) {
    if (isAdded) {
      singleRoomNumAdult++;
    } else {
      if (singleRoomNumAdult != 0) {
        singleRoomNumAdult--;
      }
    }
    sumOfRooms();
  }

  ///
  ///
  ///
  ///
  changeSingleRoomNumUpdateChild({bool isAdded = false}) {
    if (isAdded) {
      child++;
    } else {
      if (child != 0) {
        child--;
      }
    }
    sumOfRooms();
  }

  ///
  ///
  ///
  ///

  changeDoubleRoomeNum({bool isAdded = false}) {
    if (isAdded) {
      doubleRoomNum++;
    } else {
      if (doubleRoomNum != 0) {
        doubleRoomNum--;
      }
    }
    sumOfRooms();
  }

  changeTripleRoomNum({bool isAdded = false}) {
    if (isAdded) {
      tripleRoomNum++;
    } else {
      if (tripleRoomNum != 0) {
        tripleRoomNum--;
      }
    }
    sumOfRooms();
  }

  changeKingRoomNum({bool isAdded = false}) {
    if (isAdded) {
      kingRoomNum++;
    } else {
      if (kingRoomNum != 0) {
        kingRoomNum--;
      }
    }
    sumOfRooms();
  }

  sumOfRooms() {
    sumOfAllRooms = singleRoomNum + doubleRoomNum + tripleRoomNum + kingRoomNum;
    // return singleRoomNum
    emit(AddServiceRoomNumChanged());
  }

  void changePage(int index) {
    currentIndex = index;

    emit(AddServiceChangeIndex());
  }

  addAmenities(String amenity) {
    if (amenities.contains(amenity)) {
      amenities.remove(amenity);
    } else {
      amenities.add(amenity);
    }
    emit(AddServiceAmenitiesChanged());
  }

  addFeature(String feature) {
    if (this.feature.contains(feature)) {
      this.feature.remove(feature);
      print("object");
    } else {
      this.feature.add(feature);
    }
    emit(AddServiceFeatureChanged());
  }

  addServiceImages(List<XFile> selectedImages) async {
    emit(AddServiceImagesChanged());

    serviceImages!.addAll(selectedImages);
    print(serviceImages);
    emit(AddServiceRoomNumChanged());
  }

  removeServiceImage(int index) {
    serviceImages!.removeAt(index);
    emit(AddServiceImagesChanged());
  }

  changeServiceImageCoverImageNumber(int index) {
    serviceImageCoverImageNumber = index;
    emit(AddServiceImagesChanged());
  }

  nextPage(BuildContext context) {
    print(currentIndex);

    if (currentIndex == 0) {
      if (currentIndex > 0) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
      pageController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    }

    if (currentIndex == 1) {
      if (
          // amenities.isNotEmpty &&
          //     feature.isNotEmpty &&
          serviceImages.length != 0 &&
              serviceNameController.text.trim().isNotEmpty &&
              (sumOfAllRooms != 0)) {
        if (currentIndex > 0) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
        pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      } else if (sumOfAllRooms == 0) {
        snackBarBuilder(context, 'addService.roomNumError'.tr());
      }
      // else if (amenities.isEmpty) {
      //   snackBarBuilder(context, 'addService.amenitiesError'.tr());
      // } else if (feature.isEmpty) {
      //   snackBarBuilder(context, 'addService.featureError'.tr());
      // }
      else if (serviceNameController.text.trim().isEmpty) {
        snackBarBuilder(context, 'addService.servicePhoneError'.tr());
      } else if (serviceImages.length == 0) {
        snackBarBuilder(context, 'addService.serviceImagesError'.tr());
      }
    }

    if (descriptionIndex == 2) {
      print('object');
      if (phoneController.text.trim().isEmpty) {
        snackBarBuilder(context, 'addService.servicePhoneError'.tr());
      } else {
        // submit
        Navigator.pushNamed(context, 'submitService');
      }
    } else if (currentIndex == 3) {
      addService();
      print("object");
    } else {
      pageController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  previousPage() {
    pageController.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    if (currentIndex >= 1) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  checkSingleRoom() {
    if (singleRoomNum != 0) {
      if (singleRoomImage == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  checkDoubleRoom() {
    if (doubleRoomNum != 0) {
      if (doubleRoomImage == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  checkTripleRoom() {
    if (tripleRoomNum != 0) {
      if (tripleRoomImage == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  checkKingRoom() {
    if (kingRoomNum != 0) {
      if (kingRoomImage == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  getAccommodationType() async {
    var req = await http.get(Uri.parse(api.accommondationsType));
    var databody = json.decode(req.body);
    if (req.statusCode == 200) {
      accommodationTypeModel = AccommodationTypeModel.fromJson(databody);
      print(databody);
      emit(AddServiceDataFetched());
    }
  }

  getSpecials() async {
    var req = await http.get(Uri.parse(api.specials));
    var databody = json.decode(req.body);
    if (req.statusCode == 200) {
      print(databody);
      specialsModel = SpecialsModel.fromJson(databody);
      emit(AddServiceDataFetched());
    }
  }

  getAmenities() async {
    var req = await http.get(Uri.parse(api.amenities));
    var databody = json.decode(req.body);
    if (req.statusCode == 200) {
      print(databody);
      amenitiesModel = AmenitiesModel.fromJson(databody);
      emit(AddServiceDataFetched());
    }
  }

  uploadImage(List<XFile> images) async {
    var request = http.MultipartRequest('POST', Uri.parse(api.uploadImage));
    for (var image in images) {
      request.files
          .add(await http.MultipartFile.fromPath('Images', image.path));
    }

    http.StreamedResponse response = await request.send();
    var databody = await json.decode(await response.stream.bytesToString());
    // return databody;
    // print(databody);
    // return databody;
    return databody;
  }

  @override
  Future<void> close() {
    customAmenityController.dispose();
    return super.close();
  }

  addService() async {
    var token = await storage.read(key: "token");
    emit(AddServiceLoading());
    List room = [];
    List<XFile> roomImages = [];
    room.clear();
    roomImages.clear();
    if (singleRoomNum != 0) {
      room.add({
        "roomType": "Single",
        "count": singleRoomNum,
        "price": int.parse(singleRoomNightController.text),
        "guestNum": int.parse(singleRoomGuestController.text),
        "priceIncludeBreakFast": agree,
        "roomImage": await uploadImage([singleRoomImage!])
      });
    }
    if (doubleRoomNum != 0) {
      room.add({
        "roomType": "Double",
        "count": doubleRoomNum,
        "price": int.parse(doubleRoomNightController.text),
        "guestNum": int.parse(doubleRoomGuestController.text),
        "priceIncludeBreakFast": agreeDouble,
        "roomImage": await uploadImage([doubleRoomImage!])
      });
    }
    if (tripleRoomNum != 0) {
      room.add({
        "roomType": "Triple",
        "count": tripleRoomNum,
        "price": int.parse(tripleRoomNightController.text),
        "guestNum": int.parse(tripleRoomGuestController.text),
        "priceIncludeBreakFast": agreeTriple,
        "roomImage": await uploadImage([tripleRoomImage!])
      });
    }
    if (kingRoomNum != 0) {
      room.add({
        "roomType": "King",
        "count": kingRoomNum,
        "price": int.parse(kingRoomNightController.text),
        "guestNum": int.parse(kingRoomGuestController.text),
        "priceIncludeBreakFast": agreeKingSize,
        "roomImage": await uploadImage([kingRoomImage!])
      });
    }

    var cover =
        await uploadImage([serviceImages[serviceImageCoverImageNumber]]);
    print({
      "accomodationTypeId": descriptionIndex,
      "apartmentArea": null,
      "reservationPrice": null,
      "coverPhotoUrl": cover[0],
      "beds": null,
      "bathrooms": null,
      // "serviceName": placeNameController.text,
      // "address": addressController.text,
      // "city": cityController.text,
      // "government": governateController.text,
      // "addressLink": addressLinkController.text,
      "room": room,
      // "serviceDesc": serviceNameController.text,
      // "serverImagesName": await uploadImage(serviceImages),
      "website": websiteController.text,
      "officialPhone": phoneController.text,
      "importantInformation": importantController.text,
      "rulesAndCancellationPolicy": rulesController.text,
      "language": empController.text,
      // "amenityId": amenities,
      "specialId": feature,
    });

    var request = await http.post(
      Uri.parse(api.addService),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        "accomodationTypeId": descriptionIndex,
        // "apartmentArea": 0,
        // "reservationPrice": 0,
        "coverPhotoName": cover[0],
        // "beds": 0,
        // "bathrooms": 0,
        "serviceName": placeNameController.text,
        "address": addressController.text,
        "city": cityController.text,
        "government": governateController.text,
        "addressLink": addressLinkController.text,
        "RoomsType": room,
        "serviceDesc": serviceNameController.text,
        "serverImagesName": await uploadImage(serviceImages),
        "website": websiteController.text,
        "officialPhone": phoneController.text,
        "language": empController.text,
        "amenityId": amenities,
        "specialId": feature,
      }),
    );

    var databody = json.decode(request.body);
    print(databody);
    print(
        "request :::******************************************\n${request.body}");
    print(
        "response ::: ******************************************\n${databody['message']}");
    if (request.statusCode == 200) {
      emit(AddServiceSuccess());
    } else {
      emit(AddServiceError(databody['message']));
    }
  }
}
