import 'package:PassPort/version2_module/core/const/app_colors.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:PassPort/version2_module/core/widgets/custom_button.dart';
import 'package:PassPort/version2_module/core/widgets/custom_text_field.dart';
import 'package:PassPort/version2_module/features/auth/forgot_password/view_model/forgot_password_cubit.dart';
import 'package:PassPort/version2_module/features/auth/forgot_password/view_model/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            context.showCustomSnackBar(
              state.message,
              type: SnackBarType.success,
            );
            final cubit = ForgotPasswordCubit.get(context);
            // Navigate to verify code screen after success
            Navigator.pushNamed(
              context,
              'verifyCodeV2',
              arguments: {
                'email': cubit.emailController.text,
              },
            );
          } else if (state is ForgotPasswordError) {
            context.showCustomSnackBar(
              state.error,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          final cubit = ForgotPasswordCubit.get(context);

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
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
                                  icon: Icon(Icons.arrow_back,
                                      color: Colors.black),
                                ),
                                Image.asset(
                                  'assets/images/ard_logo.png', // Update path as needed
                                  width: 60,
                                ),
                              ],
                            ),
                            SizedBox(height: 44.h),

                            // Title Texts
                            const Text('Oh, Forgot!',
                                style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            const Text('Nseet',
                                style: TextStyle(
                                    fontSize: 25, color: Color(0xFF233A6A))),
                            const SizedBox(height: 4),
                            const Text(
                                "Enter your email address and we'll send you instructions to reset your password",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    height: 1.4)),
                            SizedBox(height: 70.h),

                            // Email Field
                            CustomTextField(
                              label: 'E-mail',
                              controller: cubit.emailController,
                              hint: 'E-mail',
                              keyboardType: TextInputType.emailAddress,
                              validator: cubit.validateEmail,
                            ),

                            SizedBox(height: 40.h),

                            // Send Reset Button with loading state
                            state is ForgotPasswordLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomButton(
                                    text: 'Send Code',
                                    onPressed: () {
                                      cubit.sendForgotPasswordRequest();
                                    },
                                  ),

                            SizedBox(height: 24.h),

                            // Back to Login Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Remember your password? ",
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Back to Login",
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
