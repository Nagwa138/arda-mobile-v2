import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';
import 'package:PassPort/models/partner/profits/profits_model.dart';
import 'package:PassPort/models/traveller/blog/blog_model.dart';
import 'package:PassPort/models/traveller/user_model/user_model.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_state.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);
  final storage = new FlutterSecureStorage();
  UserModel? userModel;
  String? gender;
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController deleteAccountPassword = TextEditingController();
  getProfitsModel? profitsModel;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  int? val;

  void checkGender(value) {
    emit(CheckGenderLoading());
    val = value;
    emit(CheckGenderSuccessful());
  }

  String? value;

  /// get all information
  void getInformationUser() async {
    emit(getInformationLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person user = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().userInformation, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      userModel = UserModel.fromJson(responseData);
      if (userModel?.data?.gender == 1) {
        value = "Famele";
      } else {
        value = "male";
      }

      emit(getInformationSuccessful());
    } else {
      print(response.body);
      emit(getInformationError(error: response.body));
    }
  }

  /// update information
  void updateInformation(
      {required String name,
      required String email,
      required String phone,
      required dynamic valG}) async {
    emit(UpdateInformationLoading());
    var token = await storage.read(key: 'token');

    int genderValue;
    if (valG is int) {
      genderValue = valG;
    } else if (valG is String) {
      genderValue = int.tryParse(valG) ?? 0;
    } else {
      genderValue = 0;
    }

    print(
        "data is: name=$name, email=$email, phone=$phone, gender=$genderValue");

    // Send as Form Data directly
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    http.Response response = await http.put(
      Uri.parse(Api().updateUserInformation),
      body: {
        "UserName": name,
        "Email": email,
        "PhoneNumber": phone,
        "Gender": genderValue.toString()
      },
      headers: headers,
    );

    var jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      emit(UpdateInformationSuccessful());
    } else {
      print(response.body);
      emit(UpdateInformationError(error: jsonBody['message']));
    }
  }

  /// delete account
  void deleteAccount({required String password}) async {
    emit(DeleteAccountLoading());
    var token = await storage.read(key: 'token');
    print(token);
    var response = await ApiConsumer().delete(
        uri: Api().deleteAccount,
        rawData: {"password": password},
        token: token);
    var jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      storage.delete(key: "token");
      emit(DeleteAccountSuccessful());
    } else {
      print(response.body);
      emit(DeleteAccountError(error: jsonBody['message']));
    }
  }

  ///
  void getProfits() async {
    emit(ProfitsLoading());
    var token = await storage.read(key: 'token');
    print(token);
    var response = await ApiConsumer().get(uri: Api().profits, token: token);
    var jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      profitsModel = getProfitsModel.fromJson(jsonBody);
      emit(ProfitsSuccessful());
    } else {
      print(response.body);
      emit(ProfitsError(error: jsonBody['message']));
    }
  }

  /// change Password
  bool isPasswordVisible = true;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordIcon());
  }

  ///
  bool isPasswordVisibleNew = true;

  void changePasswordVisibilityNew() {
    isPasswordVisibleNew = !isPasswordVisibleNew;
    emit(ChangePasswordIconNew());
  }

  bool isPasswordVisibleDelete = true;

  void changePasswordVisibilityDelete() {
    isPasswordVisibleDelete = !isPasswordVisibleDelete;
    emit(ChangePasswordIconDelete());
  }

  void changePassword() async {
    emit(ChangePasswordLoading());
    var token = await storage.read(key: 'token');
    print(token);
    var response = await ApiConsumer().post(
        uri: Api().changePassword,
        rawData: {
          "OldPassword": oldPassword.text,
          "NewPassword": newPassword.text,
          "ConfirmPassword": confirmNewPassword.text
        },
        token: token);
    var jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      emit(ChangePasswordSuccessful());
    } else {
      print(response.body);
      emit(ChangePasswordError(error: jsonBody['message']));
    }
  }

  Future<void> launchEmail({
    required String toEmail,
    required String subject,
    required String body,
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      query:
          'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );
    await launch(emailUri.toString());

    emit(LanchEmailLoaded());
  }

  /// contact us
  Future<void> launchWhatsApp(
      {required String phoneNumber, required String message}) async {
    emit(WhatsAppLoading());

    String url =
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    await launch(url);
    emit(WhatsAppSuccess());
  }
}
