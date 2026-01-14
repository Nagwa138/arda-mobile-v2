import 'dart:convert';

import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';
import 'package:PassPort/models/partner/PersonalProfileModel.dart';
import 'package:PassPort/models/partner/company_Profile.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  PersonalProfileModel personalProfileModel = PersonalProfileModel();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final storage = new FlutterSecureStorage();
  model_company? companymodel;

  bool isAllInputNotEmpty = false;

  checkIfAllInputIsNotEmpty() {
    if (userNameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty) {
      isAllInputNotEmpty = true;
    } else {
      isAllInputNotEmpty = false;
    }
    emit(AllInputCheck());
  }


  void getPersonalData() async {

      emit(ProfileLoading());
      final token = await storage.read(key: 'token');
      print("tokn is person user = $token");
      http.Response response = await ApiConsumer().get(uri: "${Api.API_URL}Users/PersonalData", token: token);
      var responseData = await json.decode(response.body);
      if (response.statusCode == 200) {
        personalProfileModel = PersonalProfileModel.fromJson(responseData);
        emit(ProfileLoaded());
      } else {
        print(response.body);
        emit(ProfileError( response.body));
      }



  }
  void updateInformation({required String name , required String email,required String phone , required int valG })async{
    emit(ProfileEditLoading());
    var token  =await storage.read(key: 'token');
    http.Response response = await ApiConsumer().put(
        uri:Api().updateUserInformation, rawData: {
      "UserName": name,
      "Email": email,
      "PhoneNumber": phone,
      "Gender": valG.toString()
    },token: token);
    var jsonBody = json.decode(response.body);
    if(response.statusCode == 200){
      print(response.body);
      emit(ProfileEditLoaded());
    }
    else{
      print(response.body);
      emit(ProfileEditError( jsonBody['message']));
    }
  }
  int? val ;

  void checkGender(value) {

    val = value;
    emit(CheckGenderSuccessful());
  }


  ///
  // void updateInformation()async{
  //   emit(ProfileEditLoading());
  //   var token  =await storage.read(key: 'token');
  //   http.Response response = await ApiConsumer().put(
  //       uri:Api().editProfile, rawData: {
  //     "UserName": userNameController.text.trim(),
  //     "Email": emailController.text.trim(),
  //     "PhoneNumber": phoneController.text.trim(),
  //     "Gender": "0"
  //   },token: token);
  //   var jsonBody = json.decode(response.body);
  //   if(response.statusCode == 200){
  //     print(response.body);
  //     emit(ProfileEditLoaded());
  //   }
  //   else{
  //     print(response.body);
  //     emit(ProfileEditError( response.statusCode.toString()));
  //   }
  // }

  ///

  void companyInformation() async {

    emit(CompanyLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person user = $token");
    http.Response response = await ApiConsumer().get(uri: "${Api.API_URL}PartenerInfo", token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      companymodel = model_company.fromJson(responseData);
      emit(CompanyLoaded());
    } else {
      print(response.body);
      emit(CompanyError( response.body));
    }



  }

  /// update company



}
