import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import '../model/change_password_model.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Password visibility
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  // Validation variables
  bool isFormValid = false;

  // Toggle password visibility
  void toggleNewPasswordVisibility() {
    isNewPasswordVisible = !isNewPasswordVisible;
    emit(PasswordVisibilityChanged(
      isOldPasswordVisible: false,
      isNewPasswordVisible: isNewPasswordVisible,
      
    ));
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(PasswordVisibilityChanged(
      isOldPasswordVisible: false,
      isNewPasswordVisible: isNewPasswordVisible,
     
    ));
  }

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

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase and number';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Check form validation
  void checkFormValidation() {
    isFormValid = formKey.currentState?.validate() ?? false;
    emit(ChangePasswordValidationChanged(isValid: isFormValid));
  }

  // Change password
  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) {
      emit(ChangePasswordError(error: 'Please fill all fields correctly'));
      return;
    }

    emit(ChangePasswordLoading());

    try {
      // Create change password request
      final changePasswordRequest = ChangePasswordRequest(
        email: emailController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      );

      // Create multipart request
      final url = "${Api.API_URL}Accounts/ForgetPassword";
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(url),
      );

      // Add fields
      final requestData = changePasswordRequest.toJson();
      requestData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      print("Change Password Request URL: $url");
      print("Change Password Request Fields: ${request.fields}");

      // Send request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("Change Password Response Status: ${response.statusCode}");
      print("Change Password Response: $responseBody");

      if (response.statusCode == 200) {
        try {
          var jsonBody = json.decode(responseBody);

          emit(ChangePasswordSuccess(
            message: jsonBody['message'] ?? 'Password changed successfully',
          ));
        } catch (e) {
          print("JSON Parsing Error: $e");
          emit(ChangePasswordSuccess(
            message: "Password changed successfully",
          ));
        }
      } else {
        try {
          var jsonBody = json.decode(responseBody);
          String errorMessage = jsonBody['message'] ??
              jsonBody['error'] ??
              "Failed to change password";
          emit(ChangePasswordError(error: errorMessage));
        } catch (_) {
          emit(ChangePasswordError(
              error: responseBody.isNotEmpty
                  ? responseBody
                  : "Failed to change password"));
        }
      }
    } catch (e) {
      print("Network Error: $e");
      emit(ChangePasswordError(
          error: "Network error. Please check your connection and try again."));
    }
  }

  // Clear all fields
  void clearFields() {
    emailController.clear();
    newPasswordController.clear();
   
    checkFormValidation();
  }

  // Dispose controllers
  @override
  Future<void> close() {
    emailController.dispose();
    newPasswordController.dispose();
   
    return super.close();
  }
}
