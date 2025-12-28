import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import '../model/forgot_password_model.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  static ForgotPasswordCubit get(context) => BlocProvider.of(context);

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();

  // Validation variables
  bool isFormValid = false;

  // Validation methods
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Check form validation
  void checkFormValidation() {
    isFormValid = formKey.currentState?.validate() ?? false;
    emit(ForgotPasswordValidationChanged(isValid: isFormValid));
  }

  // Send forgot password request
  Future<void> sendForgotPasswordRequest() async {
    if (!formKey.currentState!.validate()) {
      emit(ForgotPasswordError(error: 'Please enter a valid email address'));
      return;
    }

    emit(ForgotPasswordLoading());

    try {
      // Create URL with email as query parameter
      final Uri url = Uri.parse("${Api.API_URL}Accounts/sendVerificationCode")
          .replace(queryParameters: {
        'email': emailController.text.trim(),
      });

      // Send GET request
      var response = await http.get(url);
      var responseBody = response.body;

      print("Forgot Password Response: $responseBody");

      if (response.statusCode == 200) {
        try {
          var jsonBody = json.decode(responseBody);

          emit(ForgotPasswordSuccess(
            message: jsonBody['message'] ??
                'Password reset instructions sent to your email',
          ));
        } catch (e) {
          print("JSON Parsing Error: $e");
          emit(ForgotPasswordSuccess(
            message: "Password reset instructions sent to your email",
          ));
        }
      } else {
        try {
          var jsonBody = json.decode(responseBody);
          String errorMessage = jsonBody['message'] ??
              jsonBody['error'] ??
              "Failed to send reset instructions";
          emit(ForgotPasswordError(error: errorMessage));
        } catch (_) {
          emit(ForgotPasswordError(
              error: responseBody.isNotEmpty
                  ? responseBody
                  : "Failed to send reset instructions"));
        }
      }
    } catch (e) {
      print("Network Error: $e");
      emit(ForgotPasswordError(
          error: "Network error. Please check your connection and try again."));
    }
  }

  // Dispose controllers
  void dispose() {
    emailController.dispose();
  }
}
