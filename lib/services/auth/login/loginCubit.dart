import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';

import 'loginState.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  Api api = Api();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyForgotPassword = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyVerifyCode = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyCreatePassword = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgotPassword = TextEditingController();
  TextEditingController verifyCode = TextEditingController();
  TextEditingController createPassword = TextEditingController();
  TextEditingController confirmCreatePassword = TextEditingController();
  final storage = new FlutterSecureStorage();

  bool isPasswordVisible = true;
  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordIcon());
  }

  bool changeColorBtn = true;

  void toggleChangeColorBtn() {
    changeColorBtn = !changeColorBtn;
    emit(ChangeColorBtnSucsses());
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());

      try {
        // Create a multipart request
        var request = http.MultipartRequest(
          "POST",
          Uri.parse("${Api.API_URL}Accounts/Login"),
        );

        // Add headers
        request.headers.addAll({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

        // Add fields to the request
        request.fields.addAll({
          'email': emailController.text.trim(),
          'password': passwordController.text,
        });

        // Send the request
        var response = await request.send();

        // Read the response body
        var responseBody = await response.stream.bytesToString();
        print("********** Response: $responseBody");

        // Check the status code
        if (response.statusCode == 200) {
          try {
            final Map<String, dynamic> data = json.decode(responseBody);

            // Save token and user details to local storage
            await storage.write(key: "token", value: data['data']['token']);
            await storage.write(
                key: "userName", value: data['data']['userName']);
            await storage.write(key: "email", value: data['data']['email']);
            await storage.write(
                key: "userType", value: data['data']['userType'].toString());

            print("Token: ${await storage.read(key: 'token')}");
            emit(LoginSuccess(data['data']['userType']));
          } catch (e) {
            print("JSON Parsing Error: $responseBody");
            emit(LoginError("خطأ في تحليل البيانات!"));
          }
        } else {
          print("Error ${response.statusCode}: $responseBody");
          try {
            // محاولة تحليل رسالة الخطأ من السيرفر
            final Map<String, dynamic> errorData = json.decode(responseBody);
            final String errorMessage = errorData.containsKey('message')
                ? errorData['message']
                : "خطأ في تسجيل الدخول: ${response.statusCode}";
            emit(LoginError(errorMessage));
          } catch (e) {
            // إذا فشل تحليل الرسالة، عرض الخطأ الافتراضي
            emit(LoginError("خطأ في تسجيل الدخول: ${response.statusCode}"));
          }
        }
      } catch (e) {
        print("Network Error: $e");
        emit(LoginError("خطأ في الاتصال بالسيرفر!"));
      }
    }
  }

  sendCode({required String email}) async {
    emit(ForgotPasswordLoading());
    var req = await http.get(
      Uri.parse(api.sendCode + "?Email=${email}"),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var databody = json.decode(req.body);
    print(req.body);
    if (req.statusCode == 200) {
      emit(ForgotPasswordSuccess(databody['message']));
    } else {
      emit(ForgotPasswordError(databody['message']));
    }
  }

  verifyCodeSentToUser({required String email}) async {
    if (formKeyVerifyCode.currentState!.validate()) {
      emit(VerifyCodeLoading());
      var req = await http.post(
        Uri.parse(api.verifyUser),
        body: {
          'Email': email,
          'VerificationCode': verifyCode.text,
        },
      );
      var databody = json.decode(req.body);
      print(req.body);
      if (req.statusCode == 200) {
        emit(VerifyCodeSuccess());
      } else {
        emit(VerifyCodeError(databody['message']));
      }
    }
  }

  createNewPassword({
    required String email,
  }) async {
    if (formKeyCreatePassword.currentState!.validate()) {
      if (createPassword.text == confirmCreatePassword.text) {
        emit(ChangePasswordLoading());
        var req = await http.post(
          Uri.parse(api.createPassword),
          body: {
            'Email': email,
            'NewPassword': confirmCreatePassword.text,
          },
        );
        var databody = json.decode(req.body);
        print(req.body);
        if (req.statusCode == 200) {
          emit(ChangePasswordSuccess(databody['message']));
        } else {
          emit(ChangePasswordError(databody['message']));
        }
      } else {
        emit(ChangePasswordError('Password not match'));
      }
    }
  }

  @override
  void onChange(Change<LoginStates> change) {
    // TODO: implement onChange
    print(change);
    super.onChange(change);
  }
}
