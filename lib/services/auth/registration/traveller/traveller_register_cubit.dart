import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:PassPort/consts/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/services/auth/registration/traveller/traveller_register_state.dart';

class TravellerRegisterCubit extends Cubit<TravellerRegisterState> {
  TravellerRegisterCubit() : super(TravellerRegisterInitial());

  static TravellerRegisterCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController nationalty = TextEditingController();
  TextEditingController birthDay = TextEditingController();

  //variables
  bool isVisible = true;
  bool toggleBtn = false;
  // Gender: 0 for male, 1 for female
  int selectedGender = 0;

  /// security
  final storage = new FlutterSecureStorage();

  void togglePasswordVisibility() {
    isVisible = !isVisible;
    emit(TravellerRegisterPasswordVisibilityChanged());
  }

  void changeGender(int i) {
    selectedGender = i;
    checkFields();
    emit(TravellerRegisterGenderChanged());
  }

  void checkFields() {
    emit(TravellerRegisterToggleBtn());

    if (usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty &&
        nationalty.text.isNotEmpty &&
        birthDay.text.isNotEmpty &&
        (selectedGender == 0 || selectedGender == 1)) {
      toggleBtn = true;
    } else {
      toggleBtn = false;
    }
  }

  Future<void> registerTraveller() async {
    emit(RegisterTravellingLoading());

    try {
      // Get Firebase token
      var token = await storage.read(key: "tokenFireBase");

      // Create a multipart request
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${Api.API_URL}Accounts/Traveller/register"),
      );

      // Add fields to the request
      request.fields.addAll({
        'UserName': usernameController.text.trim(),
        'Email': emailController.text.trim(),
        'Password': passwordController.text.trim(),
        'ConfirmPassword': confirmPasswordController.text.trim(),
        'PhoneNumber': phoneNumber.text.trim(),
        'Gender': selectedGender.toString(),
        'Nationality': nationalty.text.trim(),
        'DateOfBirth': birthDay.text,
        'FirebaseToken': token ?? '',
      });

      // Send the request
      var response = await request.send();

      // Read the response body
      var responseBody = await response.stream.bytesToString();
      print("********** Response: $responseBody");

      // Check the status code
      if (response.statusCode == 200) {
        try {
          var jsonBody = json.decode(responseBody);

          // Save the token to storage
          await storage.write(key: "token", value: jsonBody['token']);
          print("********** \nToken: ${await storage.read(key: 'token')}");

          // Emit success state
          emit(RegisterTravellingSuccessful());
        } catch (e) {
            var jsonBody = json.decode(responseBody);
          print("JSON Parsing Error: $responseBody");
          emit(RegisterTravellingError(jsonBody['message'] ?? "Error during registration"));
        }
      } else {
        print("Error ${response.statusCode}: $responseBody");
        try {
          // Try to parse the error response as JSON
          var jsonBody = json.decode(responseBody);
          String errorMessage =
              jsonBody['message'] ?? jsonBody['error'] ?? "Unknown error";
          emit(RegisterTravellingError(errorMessage));
        } catch (_) {
          // If parsing fails, use the raw response body or a generic message
          emit(RegisterTravellingError(responseBody.isNotEmpty
              ? responseBody
              : "Error during registration"));
        }
      }
    } catch (e) {
      print("Network Error: $e");
      emit(RegisterTravellingError("Server error, please try again later."));
    }
  }

  void PickDate(
      {context,
      required TextEditingController controller,
      required DateTime firstTime,
      required DateTime lastTime}) async {
    emit(PickDateBlocLoading());
    DateTime? pickDate = await showDatePicker(
        //selectableDayPredicate: ,
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstTime,
        lastDate: lastTime);

    if (pickDate != null) {
      controller.text = pickDate.toString().split(" ")[0];
    }
    emit(PickDateBlocSSuccessfulState());
  }
}
