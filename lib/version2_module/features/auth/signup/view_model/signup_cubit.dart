import 'dart:convert';

import 'package:PassPort/consts/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/signup_model.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial()) {
    _setupFocusListeners();
  }

  static SignupCubit get(context) => BlocProvider.of(context);

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Focus nodes
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  // Validation variables
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isFormValid = false;
  bool isPasswordFieldFocused = false;
  bool isConfirmPasswordFieldFocused = false;
  bool isTermsAccepted = false;

  // Storage
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Setup focus listeners
  void _setupFocusListeners() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus != isPasswordFieldFocused) {
        isPasswordFieldFocused = passwordFocusNode.hasFocus;
        print('Password field focus changed: $isPasswordFieldFocused');
        print('Password hint will be: ${getPasswordHint()}');
        emit(SignupPasswordLabelChanged());
      }
    });

    confirmPasswordFocusNode.addListener(() {
      if (confirmPasswordFocusNode.hasFocus != isConfirmPasswordFieldFocused) {
        isConfirmPasswordFieldFocused = confirmPasswordFocusNode.hasFocus;
        print(
            'Confirm Password field focus changed: $isConfirmPasswordFieldFocused');
        print('Confirm Password hint will be: ${getConfirmPasswordHint()}');
        emit(SignupPasswordLabelChanged());
      }
    });
  }

  // Get password hint text based on focus state
  String getPasswordHint() {
    return isPasswordFieldFocused ? 'Example@123' : 'Password';
  }

  // Get confirm password hint text based on focus state
  String getConfirmPasswordHint() {
    return isConfirmPasswordFieldFocused ? 'Example@123' : 'Confirm Password';
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SignupPasswordVisibilityChanged());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(SignupPasswordVisibilityChanged());
  }

  // Toggle terms acceptance
  void toggleTermsAcceptance() {
    isTermsAccepted = !isTermsAccepted;
    emit(SignupValidationChanged(isValid: isFormValid));
  }

  // Validation methods
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 6) {
      return 'Username must be at least 6 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateWhatsapp(String? value) {
    if (value == null || value.isEmpty) {
      return 'WhatsApp number is required';
    }

    // Remove any spaces, dashes, parentheses, and dots
    String cleanNumber = value.replaceAll(RegExp(r'[\s\-\(\)\.]'), '');

    // Check for international format with country code
    // Valid formats:
    // - +[country_code][number] (e.g., +1234567890, +201234567890)
    // - 00[country_code][number] (e.g., 001234567890, 00201234567890)
    // - [country_code][number] without prefix (e.g., 1234567890)

    // Remove leading zeros if not part of country code format
    if (cleanNumber.startsWith('00') && cleanNumber.length > 2) {
      // International format with 00 prefix
      cleanNumber = '+' + cleanNumber.substring(2);
    }

    // Add + if number starts with digits but no +
    if (!cleanNumber.startsWith('+') &&
        cleanNumber.isNotEmpty &&
        RegExp(r'^\d').hasMatch(cleanNumber)) {
      cleanNumber = '+' + cleanNumber;
    }

    // Validate international phone number format
    // Must start with + followed by 1-4 digit country code and 4-15 digit phone number
    // Total length should be between 8-19 characters (including +)
    if (RegExp(r'^\+[1-9]\d{7,18}$').hasMatch(cleanNumber)) {
      // Additional check: ensure it's not too short or too long
      String numberWithoutPlus = cleanNumber.substring(1);
      if (numberWithoutPlus.length >= 8 && numberWithoutPlus.length <= 15) {
        return null; // Valid international number
      }
    }

    // Also accept numbers without country code if they're reasonable length (7-15 digits)
    if (RegExp(r'^\d{7,15}$').hasMatch(cleanNumber.replaceAll('+', ''))) {
      return null; // Valid local number format
    }

    return 'Please enter a valid phone number (e.g., +1234567890 or 1234567890)';
  }

  String? validateNationality(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nationality is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'^(?=.*[0-9])').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'^(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?])')
        .hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Check form validation
  void checkFormValidation() {
    isFormValid =
        (formKey.currentState?.validate() ?? false) && isTermsAccepted;
    emit(SignupValidationChanged(isValid: isFormValid));
  }

  // Register user
  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) {
      emit(SignupError(error: 'Please fill all fields correctly'));
      return;
    }

    if (!isTermsAccepted) {
      emit(SignupError(
          error: 'Please accept the Terms and Conditions to continue'));
      return;
    }

    emit(SignupLoading());

    try {
      // Get Firebase token
      String? firebaseToken = await storage.read(key: "tokenFireBase");

      // Create signup request
      final signupRequest = SignupRequest(
        userName: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
        phoneNumber: whatsappController.text.trim(),
        gender: 0, // Default to male, you can add gender selection UI later
        firebaseToken: firebaseToken,
        nationality: nationalityController.text.trim(),
      );

      // Create multipart request
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${Api.API_URL}Accounts/Traveller/register"),
      );

      // Add fields
      final requestData = signupRequest.toJson();
      requestData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      // Send request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("Registration Response: $responseBody");

      if (response.statusCode == 200) {
        try {
          var jsonBody = json.decode(responseBody);

          // Save token if provided
          if (jsonBody['token'] != null) {
            await storage.write(key: "token", value: jsonBody['token']);
          }

          emit(SignupSuccess(
            message: jsonBody['message'] ??
                'Your account has been created successfully. You can now log in using your email.',
            token: jsonBody['token'],
          ));
        } catch (e) {
          print("JSON Parsing Error: $e");
          emit(SignupError(
              error: "Registration successful but response parsing failed"));
        }
      } else {
        try {
          var jsonBody = json.decode(responseBody);
          String errorMessage =
              jsonBody['message'] ?? jsonBody['error'] ?? "Registration failed";
          emit(SignupError(error: errorMessage));
        } catch (_) {
          emit(SignupError(
              error: responseBody.isNotEmpty
                  ? responseBody
                  : "Registration failed"));
        }
      }
    } catch (e) {
      print("Network Error: $e");
      emit(SignupError(
          error: "Network error. Please check your connection and try again."));
    }
  }

  // Dispose controllers
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    whatsappController.dispose();
    nationalityController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }
}
