import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import '../model/verify_code_model.dart';
import 'verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit() : super(VerifyCodeInitial()) {
    startTimer();
  }

  static VerifyCodeCubit get(context) => BlocProvider.of(context);

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers for OTP fields
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  // Email passed from forgot password screen
  String? email;

  // Timer for resend code
  Timer? _timer;
  int remainingSeconds = 60;
  bool canResend = false;

  // Validation variables
  bool isFormValid = false;

  // Initialize with email
  void initializeWithEmail(String emailAddress) {
    email = emailAddress;
  }

  // Start countdown timer
  void startTimer() {
    remainingSeconds = 60;
    canResend = false;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        emit(TimerUpdated(remainingSeconds: remainingSeconds));
      } else {
        canResend = true;
        timer.cancel();
        emit(TimerUpdated(remainingSeconds: 0));
      }
    });
  }

  // Handle OTP input
  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      // Move to next field
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // Move to previous field if current is empty
      otpFocusNodes[index - 1].requestFocus();
    }

    checkFormValidation();
  }

  // Get complete OTP code
  String getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }

  // Validation methods
  String? validateOtpField(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    if (!RegExp(r'^[0-9]$').hasMatch(value)) {
      return '';
    }
    return null;
  }

  // Check form validation
  void checkFormValidation() {
    String otpCode = getOtpCode();
    isFormValid =
        otpCode.length == 6 && RegExp(r'^[0-9]{6}$').hasMatch(otpCode);
    emit(VerifyCodeValidationChanged(isValid: isFormValid));
  }

  // Verify code
  Future<void> verifyCode() async {
    if (email == null) {
      emit(VerifyCodeError(error: 'Email not found. Please try again.'));
      return;
    }

    String otpCode = getOtpCode();
    if (otpCode.length != 6) {
      emit(VerifyCodeError(error: 'Please enter a valid 6-digit code'));
      return;
    }

    emit(VerifyCodeLoading());

    try {
      // Create verify code request
      final verifyRequest = VerifyCodeRequest(
        email: email!,
        verificationCode: otpCode,
      );

      // Create multipart request
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${Api.API_URL}Accounts/verify"),
      );

      // Add fields
      final requestData = verifyRequest.toJson();
      requestData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      // Send request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("Verify Code Response: $responseBody");

      if (response.statusCode == 200) {
        try {
          var jsonBody = json.decode(responseBody);

          emit(VerifyCodeSuccess(
            message: jsonBody['message'] ?? 'Code verified successfully',
            token: jsonBody['token'],
          ));
        } catch (e) {
          print("JSON Parsing Error: $e");
          emit(VerifyCodeSuccess(
            message: "Code verified successfully",
          ));
        }
      } else {
        try {
          var jsonBody = json.decode(responseBody);
          String errorMessage = jsonBody['message'] ??
              jsonBody['error'] ??
              "Invalid verification code";
          emit(VerifyCodeError(error: errorMessage));
        } catch (_) {
          emit(VerifyCodeError(
              error: responseBody.isNotEmpty
                  ? responseBody
                  : "Invalid verification code"));
        }
      }
    } catch (e) {
      print("Network Error: $e");
      emit(VerifyCodeError(
          error: "Network error. Please check your connection and try again."));
    }
  }

  // Resend verification code
  Future<void> resendCode() async {
    if (email == null) {
      emit(ResendCodeError(error: 'Email not found. Please try again.'));
      return;
    }

    if (!canResend) {
      emit(ResendCodeError(error: 'Please wait before requesting a new code'));
      return;
    }

    emit(ResendCodeLoading());

    try {
      // Create URL with email as query parameter (same as forgot password)
      final Uri url = Uri.parse("${Api.API_URL}Accounts/sendVerificationCode")
          .replace(queryParameters: {
        'email': email!,
      });

      // Send GET request
      var response = await http.get(url);

      print("Resend Code Response: ${response.body}");

      if (response.statusCode == 200) {
        try {
          var jsonBody = json.decode(response.body);

          emit(ResendCodeSuccess(
            message: jsonBody['message'] ??
                'New verification code sent to your email',
          ));

          // Clear current OTP fields and restart timer
          clearOtpFields();
          startTimer();
        } catch (e) {
          print("JSON Parsing Error: $e");
          emit(ResendCodeSuccess(
            message: "New verification code sent to your email",
          ));
          clearOtpFields();
          startTimer();
        }
      } else {
        try {
          var jsonBody = json.decode(response.body);
          String errorMessage = jsonBody['message'] ??
              jsonBody['error'] ??
              "Failed to send verification code";
          emit(ResendCodeError(error: errorMessage));
        } catch (_) {
          emit(ResendCodeError(
              error: response.body.isNotEmpty
                  ? response.body
                  : "Failed to send verification code"));
        }
      }
    } catch (e) {
      print("Network Error: $e");
      emit(ResendCodeError(
          error: "Network error. Please check your connection and try again."));
    }
  }

  // Clear OTP fields
  void clearOtpFields() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    checkFormValidation();
  }

  // Dispose resources
  @override
  Future<void> close() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in otpFocusNodes) {
      focusNode.dispose();
    }
    return super.close();
  }
}
