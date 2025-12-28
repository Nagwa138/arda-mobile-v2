import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import '../model/login_model.dart';
import 'login_state.dart';

/// UserType enum for navigation logic
enum UserType {
  traveller(0, 'Traveller'),
  partner(1, 'Partner'),
  accommodation(3, 'Accommodation'),
  activity(4, 'Activity'),
  trip(5, 'Trip'),
  product(6, 'Product');

  const UserType(this.id, this.displayName);
  final int id;
  final String displayName;

  static UserType? fromId(int? id) {
    if (id == null) return null;
    return UserType.values.firstWhere(
      (type) => type.id == id,
      orElse: () => UserType.traveller,
    );
  }
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Validation variables
  bool isPasswordVisible = false;
  bool isFormValid = false;

  // Storage
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginPasswordVisibilityChanged());
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Check form validation
  void checkFormValidation() {
    isFormValid = formKey.currentState?.validate() ?? false;
    emit(LoginValidationChanged(isValid: isFormValid));
  }

  // Login user
  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) {
      emit(LoginError(error: 'Please fill all fields correctly'));
      return;
    }

    emit(LoginLoading());

    try {
      // Get Firebase token
      String? firebaseToken = await storage.read(key: "tokenFireBase");

      // Create login request
      final loginRequest = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        firebaseToken: firebaseToken,
      );

      // Create multipart request
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${Api.API_URL}Accounts/Login"),
      );

      // Add fields
      final requestData = loginRequest.toJson();
      requestData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      // Send request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("Login Response: $responseBody");

      if (response.statusCode == 200) {
        try {
          var jsonBody = json.decode(responseBody);
          final loginResponse = LoginResponse.fromJson(jsonBody);

          if (loginResponse.isSuccess && loginResponse.data != null) {
            final userData = loginResponse.data!;

            // Save essential user data
            await storage.write(key: "token", value: userData.token ?? '');
            await storage.write(
                key: "userName", value: userData.userName ?? '');
            await storage.write(key: "email", value: userData.email ?? '');
            await storage.write(
                key: "userType", value: userData.userType?.toString() ?? '');

            print("Login successful - Token: ${userData.token}");
            print("User Type: ${userData.userType}");

            emit(LoginSuccess(
              message: loginResponse.message,
              token: userData.token,
              userType: userData.userType,
            ));
          } else {
            emit(LoginError(error: loginResponse.message));
          }
        } catch (e) {
          print("JSON Parsing Error: $e");
          emit(LoginError(
              error: "Login successful but response parsing failed"));
        }
      } else {
        try {
          var jsonBody = json.decode(responseBody);
          String errorMessage =
              jsonBody['message'] ?? jsonBody['error'] ?? "Login failed";
          emit(LoginError(error: errorMessage));
        } catch (_) {
          emit(LoginError(
              error: responseBody.isNotEmpty ? responseBody : "Login failed"));
        }
      }
    } catch (e) {
      print("Network Error: $e");
      emit(LoginError(
          error: "Network error. Please check your connection and try again."));
    }
  }

  // Check if user is logged in
  Future<bool> isUserLoggedIn() async {
    try {
      String? token = await storage.read(key: "token");
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Get stored user data
  Future<Map<String, String?>> getUserData() async {
    try {
      return {
        'token': await storage.read(key: "token"),
        'userName': await storage.read(key: "userName"),
        'email': await storage.read(key: "email"),
        'userType': await storage.read(key: "userType"),
      };
    } catch (e) {
      return {};
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      await storage.delete(key: "token");
      await storage.delete(key: "userName");
      await storage.delete(key: "email");
      await storage.delete(key: "userType");
      emit(LoginInitial());
    } catch (e) {
      print("Logout error: $e");
    }
  }

  // Get navigation route based on user type
  String getNavigationRoute(int? userType) {
    if (userType == null) return 'travellerNavBar';

    try {
      final userTypeEnum = UserType.fromId(userType);
      print('Navigation: User type $userType (${userTypeEnum?.displayName})');

      switch (userTypeEnum) {
        case UserType.traveller:
          print('Navigation: Routing to travellerNavBar');
          return 'travellerNavBar';
        case UserType.partner:
        case UserType.accommodation:
        case UserType.activity:
        case UserType.trip:
        case UserType.product:
          print('Navigation: Routing to partnerMobileDashboard (Partner type)');
          return 'partnerMobileDashboard';
        default:
          print('Navigation: Unknown user type, routing to travellerNavBar');
          return 'travellerNavBar';
      }
    } catch (e) {
      print(
          'Navigation: Invalid user type: $userType, routing to travellerNavBar');
      return 'travellerNavBar';
    }
  }

  // Dispose controllers
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
