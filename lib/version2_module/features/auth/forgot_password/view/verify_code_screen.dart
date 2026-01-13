import 'package:PassPort/version2_module/core/const/app_colors.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:PassPort/version2_module/core/widgets/custom_button.dart';
import 'package:PassPort/version2_module/features/auth/forgot_password/view_model/verify_code_cubit.dart';
import 'package:PassPort/version2_module/features/auth/forgot_password/view_model/verify_code_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyCodeScreen extends StatelessWidget {
  final String email;

  const VerifyCodeScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCodeCubit()..initializeWithEmail(email),
      child: BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
        listener: (context, state) {
          if (state is VerifyCodeSuccess) {
            context.showCustomSnackBar(
              state.message,
              type: SnackBarType.success,
            );
            // Navigate to reset password screen
            Navigator.pushNamed(
              context,
              'changePasswordV2',
              arguments: {
                'email': email,
              },
            );
          } else if (state is VerifyCodeError) {
            context.showCustomSnackBar(
              state.error,
              type: SnackBarType.error,
            );
          } else if (state is ResendCodeSuccess) {
            context.showCustomSnackBar(
              state.message,
              type: SnackBarType.success,
            );
          } else if (state is ResendCodeError) {
            context.showCustomSnackBar(
              state.error,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          final cubit = VerifyCodeCubit.get(context);

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo and Back Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                          Image.asset(
                            'assets/images/ard_logo.png', // Update path as needed
                            width: 60,
                          ),
                        ],
                      ),
                      SizedBox(height: 44.h),

                      // Title Texts
                      const Text('Verify Email',
                          style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const Text('Code',
                          style: TextStyle(
                              fontSize: 25, color: Color(0xFF233A6A))),
                      const SizedBox(height: 4),
                      Text("We've sent a 6-digit verification code to\n$email",
                          style: TextStyle(
                              fontSize: 10, color: Colors.black, height: 1.4)),
                      SizedBox(height: 50.h),

                      // OTP Input Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          return Container(
                            width: 45.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              controller: cubit.otpControllers[index],
                              focusNode: cubit.otpFocusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) {
                                cubit.onOtpChanged(index, value);
                              },
                              validator: cubit.validateOtpField,
                            ),
                          );
                        }),
                      ),

                      SizedBox(height: 40.h),

                      // Verify Button with loading state
                      state is VerifyCodeLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              text: 'Verify Code',
                              onPressed: () {
                                cubit.verifyCode();
                              },
                            ),

                      SizedBox(height: 30.h),

                      // Timer and Resend Code Section
                      Center(
                        child: Column(
                          children: [
                            if (state is TimerUpdated &&
                                state.remainingSeconds > 0)
                              Text(
                                "Resend code in ${state.remainingSeconds}s",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: state is ResendCodeLoading
                                    ? null
                                    : () {
                                        cubit.resendCode();
                                      },
                                child: state is ResendCodeLoading
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        "Resend Code",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                          color: Color(0xFF233A6A),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                              ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Back to Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Wrong email? ",
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Change Email",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                color: Color(0xFF233A6A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
