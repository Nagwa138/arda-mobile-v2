import 'package:PassPort/components/widgets/custom_lodaing_indicator.dart';
import 'package:PassPort/version2_module/core/const/app_colors.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:PassPort/version2_module/core/widgets/custom_button.dart';
import 'package:PassPort/version2_module/core/widgets/custom_text_field.dart';
import 'package:PassPort/version2_module/features/auth/forgot_password/view_model/change_password_cubit.dart';
import 'package:PassPort/version2_module/features/auth/forgot_password/view_model/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get email from arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final email = args?['email'] ?? '';

    return BlocProvider(
      create: (context) => ChangePasswordCubit()..emailController.text = email,
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            context.showCustomSnackBar(
              state.message,
              type: SnackBarType.success,
            );
            // Clear fields and navigate to login
            final cubit = ChangePasswordCubit.get(context);
            cubit.clearFields();
            Navigator.pushNamedAndRemoveUntil(
              context,
              'login',
              (route) => false,
            );
          } else if (state is ChangePasswordError) {
            context.showCustomSnackBar(
              state.error,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          final cubit = ChangePasswordCubit.get(context);

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
                      const Text('Reset',
                          style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const Text('Password',
                          style: TextStyle(
                              fontSize: 25, color: Color(0xFF233A6A))),
                      const SizedBox(height: 4),
                      const Text(
                          "Enter your email address and create a new secure password",
                          style: TextStyle(
                              fontSize: 10, color: Colors.black, height: 1.4)),
                      SizedBox(height: 50.h),

                      // Email Field
                      CustomTextField(
                        label: 'Email Address',
                        controller: cubit.emailController,
                        hint: 'E-mail ',
                        validator: cubit.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: 20.h),

                      // New Password Field
                      CustomTextField(
                        label: 'New Password',
                        controller: cubit.newPasswordController,
                        hint: 'New password',
                        obscureText: !cubit.isNewPasswordVisible,
                        suffixIcon: IconButton(
                          onPressed: cubit.toggleNewPasswordVisibility,
                          icon: Icon(
                            cubit.isNewPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        validator: cubit.validateNewPassword,
                        keyboardType: TextInputType.visiblePassword,
                      ),

                      SizedBox(height: 20.h),

                      SizedBox(height: 16.h),

                      // Password Requirements
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password Requirements:',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF233A6A),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '• At least 6 characters\n• Contains uppercase letter\n• Contains lowercase letter\n• Contains at least one number',
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: Colors.grey[700],
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 40.h),

                      // Change Password Button with loading state
                      state is ChangePasswordLoading
                          ? const CustomLodaingIndicator()
                          : CustomButton(
                              text: 'Reset Password',
                              onPressed: () {
                                cubit.changePassword();
                              },
                            ),

                      SizedBox(height: 24.h),

                      // Back Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't want to reset? ",
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Go Back",
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
