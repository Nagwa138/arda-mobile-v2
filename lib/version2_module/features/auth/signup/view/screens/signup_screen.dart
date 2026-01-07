import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/version2_module/core/widgets/custom_text_field.dart';
import 'package:PassPort/version2_module/features/auth/privacy/privacy_policy_screen.dart';
import 'package:PassPort/version2_module/features/auth/signup/view_model/signup_cubit.dart';
import 'package:PassPort/version2_module/features/auth/signup/view_model/signup_state.dart';
import 'package:PassPort/version2_module/features/auth/terms/terms_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                margin: EdgeInsets.all(16.w),
                duration: Duration(seconds: 2),
              ),
            );

            Navigator.pushNamedAndRemoveUntil(
              context,
              'login',
              (route) => false,
            );
          } else if (state is SignupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error_outline_rounded,
                        color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Expanded(child: Text(state.error)),
                  ],
                ),
                backgroundColor: Colors.red.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                margin: EdgeInsets.all(16.w),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = SignupCubit.get(context);

          return Scaffold(
            body: Stack(
              children: [
                // Background Image
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
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),

                            // Logo
                            CustomLogo(),

                            SizedBox(height: 32.h),

                            // Welcome Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome',
                                  style: TextStyle(
                                    fontSize: 42.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    height: 1.2,
                                    letterSpacing: -1,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Text(
                                      'Ahlan bek',
                                      style: TextStyle(
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.w600,
                                        color: accentColor,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "Let's create an account",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 32.h),

                            // Form Fields
                            CustomTextField(
                              label: 'User Name',
                              controller: cubit.usernameController,
                              hint: 'Enter your username',
                              validator: cubit.validateUsername,
                            ),

                            SizedBox(height: 16.h),

                            CustomTextField(
                              label: 'E-mail',
                              controller: cubit.emailController,
                              hint: 'Enter your email address',
                              keyboardType: TextInputType.emailAddress,
                              validator: cubit.validateEmail,
                            ),

                            SizedBox(height: 16.h),

                            CustomTextField(
                              label: 'Whatsapp Number',
                              controller: cubit.whatsappController,
                              hint: 'Enter your WhatsApp number',
                              keyboardType: TextInputType.phone,
                              validator: cubit.validateWhatsapp,
                            ),

                            SizedBox(height: 16.h),

                            CustomTextField(
                              label: 'Nationality',
                              controller: cubit.nationalityController,
                              hint: 'Enter your nationality',
                              validator: cubit.validateNationality,
                            ),

                            SizedBox(height: 16.h),

                            CustomTextField(
                              label: 'Password',
                              controller: cubit.passwordController,
                              focusNode: cubit.passwordFocusNode,
                              obscureText: !cubit.isPasswordVisible,
                              hint: cubit.getPasswordHint(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  cubit.isPasswordVisible
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  color: accentColor.withValues(alpha: 0.5),
                                ),
                                onPressed: cubit.togglePasswordVisibility,
                              ),
                              validator: cubit.validatePassword,
                            ),

                            SizedBox(height: 16.h),

                            CustomTextField(
                              label: 'Confirm Password',
                              controller: cubit.confirmPasswordController,
                              obscureText: !cubit.isConfirmPasswordVisible,
                              focusNode: cubit.confirmPasswordFocusNode,
                              hint: cubit.getConfirmPasswordHint(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  cubit.isConfirmPasswordVisible
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  color: accentColor.withValues(alpha: 0.5),
                                ),
                                onPressed:
                                    cubit.toggleConfirmPasswordVisibility,
                              ),
                              validator: cubit.validateConfirmPassword,
                            ),

                            SizedBox(height: 20.h),

                            // Terms and Conditions - Enhanced Design
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: accentColor.withValues(alpha: 0.04),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: accentColor.withValues(alpha: 0.1),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 1.1,
                                    child: Checkbox(
                                      value: cubit.isTermsAccepted,
                                      onChanged: (value) {
                                        cubit.toggleTermsAcceptance();
                                      },
                                      activeColor: accentColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 2.h),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            "I agree to the ",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.black87,
                                              height: 1.5,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TermsConditionsScreen(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Terms and Conditions",
                                              style: TextStyle(
                                                color: accentColor,
                                                fontWeight: FontWeight.w700,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 12.sp,
                                                height: 1.5,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            " and ",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.black87,
                                              height: 1.5,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PrivacyPolicyScreen(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Privacy Policy",
                                              style: TextStyle(
                                                color: accentColor,
                                                fontWeight: FontWeight.w700,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 12.sp,
                                                height: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 28.h),

                            // Sign Up Button
                            state is SignupLoading
                                ? Container(
                                    height: 56.h,
                                    decoration: BoxDecoration(
                                      color: accentColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: 24.w,
                                        height: 24.w,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            accentColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 56.h,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          accentColor,
                                          Color(0xFF1a2d52),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: accentColor.withValues(
                                              alpha: 0.3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          cubit.registerUser();
                                        },
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Sign Up',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Colors.white,
                                                size: 20.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                            SizedBox(height: 24.h),

                            // Divider
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.black12,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.black12,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // Login Link
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Have an account? ",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, 'login');
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(0, 0),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.sp,
                                        color: accentColor,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 32.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomLogo extends StatelessWidget {
  const CustomLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Image.asset(
          'assets/images/ard_logo.png',
          width: 50.w,
          height: 50.w,
        ),
      ),
    );
  }
}
