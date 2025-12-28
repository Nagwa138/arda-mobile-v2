import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';
import 'package:PassPort/models/partner/ApplicationServicesModel.dart';
import 'package:PassPort/models/partner/GovernmentsModel.dart';
import 'package:PassPort/screens/auth/registration/partner/general%20information/general_information.dart';
import 'package:PassPort/screens/auth/registration/register.dart';
import 'package:http/http.dart' as http;

part 'partner_register_state.dart';

class PartnerRegisterCubit extends Cubit<PartnerRegisterState> {
  PartnerRegisterCubit() : super(PartnerRegisterInitial());

  //key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();
  var generalInfoFormKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();

  //controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ///////////////////////////////////////
  TextEditingController companyNameController = TextEditingController();
  String governateController = 'Alex';
  String serviceController = 'Hotel';
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController websiteController = TextEditingController();
  PageController pageController = PageController();
  GovernmentsModel governmentsModel = GovernmentsModel();
  ApplicationServicesModel applicationServicesModel =
      ApplicationServicesModel();
  var CompanyLogo = null;
  Api api = Api();
  //variables
  bool isVisible = true;
  bool isVisible2 = true;
  bool isVisibleConfirmPassword = false;
  bool generalInfoStatus = false;
  bool privateInfoStatus = false;
  int currentPage = 0;
  int serviceSelected = -1; // Default to -1 (none selected)
  String? tripType; // "company" or "tour"
  String? valueTrips;
  String? tour;
  String? selectedValue; // Default selected value

  void checkGender(value) {
    selectedValue = value;
    emit(CheckGenderSuccessful());
  }

  void togglePasswordVisibility() {
    isVisible = !isVisible;
    emit(PartnerRegisterPasswordVisibilityChanged());
  }

  void togglePasswordVisibility2() {
    isVisible2 = !isVisible;
    emit(PartnerRegisterPasswordVisibilityChanged2());
  }

  void toggleConfirmPasswordVisibility() {
    isVisibleConfirmPassword = !isVisibleConfirmPassword;
    emit(PartnerRegisterPasswordVisibilityChanged());
  }

  toggleGeneralInfo() {
    if (passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        usernameController.text.isNotEmpty) {
      generalInfoStatus = true;
      emit(PartnerRegisterToggleGeneralInfo());
    } else {
      generalInfoStatus = false;
    }
  }

  validateGeneralInfo() {
    if (passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        usernameController.text.isNotEmpty) {
      if (!emailController.text.isValidEmail()) {
        emit(PartnerRegisterFailure('Please enter a valid email'));
        return false;
      } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*[a-z])')
          .hasMatch(passwordController.text)) {
        emit(PartnerRegisterFailure('errorMessages.lowerUpperCase'.tr()));
        return false;
      } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(passwordController.text)) {
        emit(PartnerRegisterFailure('errorMessages.number'.tr()));
        return false;
      } else if (!RegExp(r'^(?=.*?[!@#\$&*~])')
          .hasMatch(passwordController.text)) {
        emit(PartnerRegisterFailure('errorMessages.specialCharacter'.tr()));
        return false;
      } else if (passwordController.text.length < 8) {
        emit(PartnerRegisterFailure('errorMessages.length'.tr()));
        return false;
      } else if (passwordController.text != confirmPasswordController.text) {
        emit(PartnerRegisterFailure('errorMessages.passwordNotMatch'.tr()));
        return false;
      } else {
        return true;
      }
    } else {
      // generalInfoStatus = false;
      emit(PartnerRegisterFailure('Please fill all fields'));
      return false;
    }
  }

  togglePrivateInfo() {
    emit(PartnerRegisterToggleGeneralInfo());

    if (companyNameController.text.isNotEmpty &&
        addressController.text.isNotEmpty) {
      privateInfoStatus = true;
    } else {
      privateInfoStatus = false;
    }
  }

  void changeCurrentIndex(int index) {
    currentPage = index;
    emit(PartnerRegisterChangeCurrentIndex());
  }

  void changeServiceSelected(int index, {BuildContext? context}) {
    if (index >= 0 && index < applicationServicesModel.data!.length) {
      serviceSelected = index;
      serviceController = applicationServicesModel.data![index].id!;
      emit(PartnerRegisterChangeServiceSelected());

      // Remove trip type dialog logic
      final serviceName =
          applicationServicesModel.data![index].name?.toLowerCase() ?? "";
      if (serviceName.contains("trip")) {
        // Optionally set a default tripType if needed
        tripType = "company";
      } else {
        tripType = null; // Reset tripType if not trip service
      }
    } else {
      print("Error: Invalid service index selected.");
    }
  }

  Future<void> getGovernments() async {
    try {
      var response = await http.get(Uri.parse(api.governments));

      if (response.statusCode == 200) {
        var dataBody = json.decode(response.body);
        print('Governments data retrieved successfully.');

        if (dataBody['data'] != null) {
          governmentsModel = GovernmentsModel.fromJson(dataBody);
        } else {
          print("Error: No data found in response.");
        }
      } else {
        print(
            "Error: Failed to fetch governments. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred while fetching governments: $e");
    }
  }

  void changeCountry(String? value) {
    governateController = value!;
    emit(ChangeContry());
  }

  getServices() async {
    var response =
        await http.get(Uri.parse("${Api.API_URL}ApplicationServices"));
    print(response.body);
    var databody = json.decode(response.body);
    applicationServicesModel = ApplicationServicesModel.fromJson(databody);
  }

  pickCompanyLogo() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    CompanyLogo = image;
    emit(PartnerRegisterPickCompanyLogo());
  }

  Future<void> register() async {
    emit(RegisterPartnerLoading());
    String? tokenValue = await storage.read(key: "tokenFireBase");
    String token = tokenValue ?? '';

    // Use tripType only if service is "Trip"
    String? selectedTripType;
    final selectedServiceName = (serviceSelected >= 0 &&
            serviceSelected < applicationServicesModel.data!.length)
        ? applicationServicesModel.data![serviceSelected].name?.toLowerCase()
        : null;
    if (selectedServiceName != null && selectedServiceName.contains("trip")) {
      selectedTripType = tripType ?? "company";
    }

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(api.register),
    );

    // According to your API structure, TripType should be under PartenerInformation
    final fields = {
      'UserName': usernameController.text,
      'Email': emailController.text.trim(),
      'Password': passwordController.text,
      'ConfirmPassword': confirmPasswordController.text,
      'PhoneNumber': phoneController.text,
      'Gender': '0',
      'FirebaseToken': token,
      'PartenerInformation.CompanyName': companyNameController.text,
      'PartenerInformation.GovernmentId': governateController,
      'PartenerInformation.AddressLink': addressController.text,
      'PartenerInformation.WebSiteLink': websiteController.text,
      'PartenerInformation.ServiceId': serviceController,
      if (selectedTripType != null)
        'PartenerInformation.TripType': selectedTripType,
    };

    print('Register request fields: $fields');

    request.fields.addAll(fields);

    if (CompanyLogo != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'PartenerInformation.CompanyLogo', CompanyLogo!.path));
    }

    try {
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      print('Register response status: ${response.statusCode}');
      print('Register response body: $responseString');
      var databody;
      try {
        databody = json.decode(responseString);
      } catch (e) {
        databody = {};
      }

      if (response.statusCode == 200) {
        emit(PartnerRegisterSuccess());
      } else {
        final errorMsg = databody['message'] ??
            databody['Message'] ??
            databody['details'] ??
            responseString ??
            'Unknown error';
        emit(PartnerRegisterFailure(errorMsg));
      }
    } catch (e) {
      print('Register exception: $e');
      emit(PartnerRegisterFailure('Registration failed: $e'));
    }
  }

  TextEditingController companyNameEdit = TextEditingController();
  TextEditingController webSiteEdit = TextEditingController();
  //TextEditingController companyNameEdit = TextEditingController();

  @override
  void onChange(Change<PartnerRegisterState> change) {
    // TODO: implement onChange
    print(change);
    super.onChange(change);
  }
}
