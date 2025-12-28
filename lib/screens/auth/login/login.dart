import 'dart:io';

import 'package:PassPort/screens/auth/login/widget/buildModernTextField.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/transeletarabic/transalet.dart';
import 'package:PassPort/components/widgets/customButton/customButton.dart';
import 'package:PassPort/consts/cache%20manger/cache.dart';
import 'package:PassPort/services/auth/login/loginCubit.dart';
import 'package:PassPort/services/auth/login/loginState.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (cm) {
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: CircularProgressIndicator(color: orange),
                  ),
                );
              },
            );
          }
          if (state is LoginSuccess) {
            if (state.userType == 0) {
              Navigator.pop(context);
              CacheManger.loadAllData();
              Navigator.pushNamed(context, 'travellerNavBar');
            } else if (state.userType == 1) {
              Navigator.pushReplacementNamed(context, 'landingHomeMain');
            } else {
              Navigator.pushReplacementNamed(context, 'homeAdmin');
            }
          } else if (state is LoginError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.white),
                    SizedBox(width: 12.w),
                    Expanded(child: Text(state.error)),
                  ],
                ),
                backgroundColor: Colors.red.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                margin: EdgeInsets.all(16.w),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            body: Stack(
              children: [
                // Background Image with Gradient Overlay
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/login/image1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),

                // Content
                SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: LoginCubit.get(context).formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 40.h),

                          // Logo with Animation-ready Container
                          Hero(
                            tag: 'logo',
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                "assets/images/ard_logo.png",
                                height: 120.h,
                              ),
                            ),
                          ),

                          SizedBox(height: 40.h),

                          // Login Form Card
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: appBackgroundColor,
                                borderRadius: BorderRadius.circular(32.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 30,
                                    offset: Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(32.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Welcome Text
                                    Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            'login.welcome'.tr(),
                                            style: TextStyle(
                                              fontSize: 28.sp,
                                              fontWeight: FontWeight.w800,
                                              color: accentColor,
                                              letterSpacing: -0.5,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            'login.login'.tr(),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  blackWhite.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 32.h),

                                    // Email Field
                                    buildModernTextField(
                                      context,
                                      title: 'register.emailAddress'.tr(),
                                      hint: 'register.inputs.email'.tr(),
                                      controller: LoginCubit.get(context)
                                          .emailController,
                                      prefixIcon: Icons.email_outlined,
                                      validation: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'login.enterEmail'.tr();
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: 20.h),

                                    // Password Field
                                    buildModernTextField(
                                      context,
                                      title: 'register.password'.tr(),
                                      hint: 'register.inputs.password'.tr(),
                                      controller: LoginCubit.get(context)
                                          .passwordController,
                                      prefixIcon: Icons.lock_outline,
                                      obstructText: LoginCubit.get(context)
                                          .isPasswordVisible,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          LoginCubit.get(context)
                                              .changePasswordVisibility();
                                        },
                                        icon: Icon(
                                          LoginCubit.get(context)
                                                  .isPasswordVisible
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: accentColor.withOpacity(0.5),
                                        ),
                                      ),
                                      validation: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'login.enterPassword'.tr();
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: 12.h),

                                    // Forgot Password
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, 'forgotPassword');
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size(0, 0),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: Text(
                                          'login.forgotPassword'.tr(),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: accentColor,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 24.h),

                                    // Login Button
                                    Container(
                                      width: double.infinity,
                                      height: 56.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        gradient: LinearGradient(
                                          colors: [
                                            accentColor,
                                            accentColor.withOpacity(0.8)
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: accentColor.withOpacity(0.3),
                                            blurRadius: 16,
                                            offset: Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            LoginCubit.get(context).login();
                                          },
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          child: Center(
                                            child: Text(
                                              'onboarding.next'.tr(),
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                letterSpacing: 0.5,
                                              ),
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
                                            color: blackWhite.withOpacity(0.2),
                                            thickness: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          child: Text(
                                            'OR',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color:
                                                  blackWhite.withOpacity(0.4),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Divider(
                                            color: blackWhite.withOpacity(0.2),
                                            thickness: 1,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 24.h),

                                    // Sign Up Section
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'login.createAccount'.tr(),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  blackWhite.withOpacity(0.6),
                                            ),
                                          ),
                                          SizedBox(width: 6.w),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(
                                                  context, "register");
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: Size(0, 0),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            child: Text(
                                              'login.signUp'.tr(),
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700,
                                                color: accentColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 40.h),
                        ],
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
