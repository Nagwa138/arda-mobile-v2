// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/transeletarabic/transalet.dart';
import 'package:PassPort/screens/auth/registration/partner/partner_register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/services/auth/registration/partner/partner_register_cubit.dart';

class GeneralInformation extends StatelessWidget {
  const GeneralInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBackgroundColor,
      height: 0.8.sh,
      // color: Colors.red,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),

        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          textFormFildBuilder(
            context,
            title: 'register.username'.tr(),
            hint: 'register.inputs.username'.tr(),
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'register.inputs.username'.tr();
              }
              if (value.length < 6 || value.length > 20) {
                return 'valid.usernameLength'.tr();
              }
              if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                return 'Username must contain only letters and numbers'
                    .tr(); // أضف هذه الرسالة في ملف الترجمة
              }
              if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'Username must contain at least one number'
                    .tr(); // أضف هذه الرسالة في ملف الترجمة
              }
              if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                return 'must contain at least one letter'
                    .tr(); // أضف هذه الرسالة في ملف الترجمة
              }
              return null;
            },
            controller: context.read<PartnerRegisterCubit>().usernameController,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'register.emailAddress'.tr(),
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller:
                      context.read<PartnerRegisterCubit>().emailController,
                  onChanged: (value) {
                    context.read<PartnerRegisterCubit>().currentPage == 0
                        ? context
                            .read<PartnerRegisterCubit>()
                            .toggleGeneralInfo()
                        : context
                            .read<PartnerRegisterCubit>()
                            .togglePrivateInfo();
                  },
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'register.inputs.email'.tr();
                    } else if (!input.isValidEmail()) {
                      return 'valid.email'.tr();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),

                    hintText: 'register.inputs.email'.tr(),

                    hintStyle: TextStyle(
                      color: accentColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: Color(0xFFDFE2E6),
                      ),
                    ),
                    // suffixIcon: suffixIcon,
                    // filled: true,
                    // fillColor: Color(0xFFF5F7FA),
                  ),
                ),
              ],
            ),
          ),
          textFormFildBuilder(
            context,
            title: 'register.phone'.tr(),
            hint: 'register.inputs.phone'.tr(),
            controller: context.read<PartnerRegisterCubit>().phoneController,
            validation: (value) {
              if (value!.isEmpty) {
                return 'register.inputs.phone'.tr();
              }
              return null;
            },
            inputType: TextInputType.phone,
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'register.password'.tr(),
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                TextFormField(
                  controller:
                      context.read<PartnerRegisterCubit>().passwordController,
                  onChanged: (value) {
                    context.read<PartnerRegisterCubit>().currentPage == 0
                        ? context
                            .read<PartnerRegisterCubit>()
                            .toggleGeneralInfo()
                        : context
                            .read<PartnerRegisterCubit>()
                            .togglePrivateInfo();
                  },
                  obscureText: context.read<PartnerRegisterCubit>().isVisible,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  inputFormatters: [
                    ArabicToEnglishNumeralsFormatter(),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'register.inputs.password'.tr();
                    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*[a-z])')
                        .hasMatch(value)) {
                      return 'valid.lowerCase'.tr();
                    } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
                      return 'valid.number'.tr();
                    } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
                      return 'valid.symbol'.tr();
                    } else if (value.length < 8) {
                      return 'valid.length'.tr();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    hintText: 'register.inputs.password'.tr(),
                    hintStyle: TextStyle(
                      color: accentColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: Color(0xFFDFE2E6),
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        context
                            .read<PartnerRegisterCubit>()
                            .togglePasswordVisibility();
                      },
                      child: Icon(
                        context.read<PartnerRegisterCubit>().isVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'register.confirmPassword'.tr(),
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                TextFormField(
                  controller: context
                      .read<PartnerRegisterCubit>()
                      .confirmPasswordController,
                  onChanged: (value) {
                    context.read<PartnerRegisterCubit>().currentPage == 0
                        ? context
                            .read<PartnerRegisterCubit>()
                            .toggleGeneralInfo()
                        : context
                            .read<PartnerRegisterCubit>()
                            .togglePrivateInfo();
                  },
                  obscureText: context
                      .read<PartnerRegisterCubit>()
                      .isVisibleConfirmPassword,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  inputFormatters: [
                    ArabicToEnglishNumeralsFormatter(),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'register.inputs.password'.tr();
                    } else if (value !=
                        context
                            .read<PartnerRegisterCubit>()
                            .passwordController
                            .text) {
                      return 'valid.passwordNotMatch'.tr();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    hintText: 'register.inputs.password'.tr(),
                    hintStyle: TextStyle(
                      color: accentColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: Color(0xFFDFE2E6),
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        context
                            .read<PartnerRegisterCubit>()
                            .toggleConfirmPasswordVisibility();
                      },
                      child: Icon(
                        context
                                .read<PartnerRegisterCubit>()
                                .isVisibleConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {
              //close keyboard
              FocusScope.of(context).unfocus();
              // if (context.read<PartnerRegisterCubit>().generalInfoFormKey.currentState!.validate()) {
              //   context.read<PartnerRegisterCubit>().toggleGeneralInfo();
              //   context.read<PartnerRegisterCubit>().pageController.nextPage(
              //         duration: Duration(milliseconds: 500),
              //         curve: Curves.easeIn,
              //       );
              // }

              if (context
                  .read<PartnerRegisterCubit>()
                  .formKey
                  .currentState!
                  .validate()) {
                context.read<PartnerRegisterCubit>().pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
              }
            },
            child: Container(
              width: 1.sw,
              height: 48.h,
              decoration: ShapeDecoration(
                color: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Center(
                child: Text(
                  'register.next'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'register.signinSuggestion'.tr() + " ",
              style: TextStyle(
                color: accentColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, 'login');
                    },
                  text: 'register.login'.tr(),
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: accentColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
        ],
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
