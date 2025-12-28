// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/transeletarabic/transalet.dart';
import 'package:PassPort/services/auth/registration/traveller/traveller_register_cubit.dart';
import 'package:PassPort/services/auth/registration/traveller/traveller_register_state.dart';

class TravellerRegister extends StatelessWidget {
  const TravellerRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TravellerRegisterCubit(),
      child: BlocConsumer<TravellerRegisterCubit, TravellerRegisterState>(
        listener: (context, state) {
          if (state is RegisterTravellingLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Center(
                    child: CircularProgressIndicator(
                  color: accentColor,
                ));
              },
            );
          } else if (state is RegisterTravellingSuccessful) {
            Navigator.pushReplacementNamed(context, "login");

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Register Successfully',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: orange,
            ));
            TravellerRegisterCubit.get(context).usernameController.clear();
            TravellerRegisterCubit.get(context).emailController.clear();
            TravellerRegisterCubit.get(context).passwordController.clear();
          } else if (state is RegisterTravellingError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/auth/image3.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  children: [
                    Center(
                        child: Image.asset(
                      "assets/images/ard_logo.png",
                      height: 250.h,
                    )),
                    // SizedBox(
                    //   height: 15.h,
                    // ),
                    // Text(
                    //   'slogan'.tr(),
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 8.sp,
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 100.h,
                    // ),
                    Container(
                      /// height: 0.75.sh,
                      decoration: BoxDecoration(
                        color: appBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.r),
                          topRight: Radius.circular(24.r),
                          bottomLeft: Radius.circular(24.r),
                          bottomRight: Radius.circular(4.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 10.h),
                        child: Form(
                          key: context.read<TravellerRegisterCubit>().formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'register.title'.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'register.subtitle2'.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7A8699),
                                  fontSize: 12.sp,
                                  fontFamily: 'Mona Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              //Username *
                              textFormFildBuilder(context,
                                  title: 'register.username',
                                  hint: 'register.inputs.username',
                                  controller: context
                                      .read<TravellerRegisterCubit>()
                                      .usernameController,
                                  validation: (String? value) {
                                if (value!.isEmpty) {
                                  return 'register.userNameEnter'.tr();
                                } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(
                                    context
                                        .read<TravellerRegisterCubit>()
                                        .usernameController
                                        .text)) {
                                  return 'valid.number'.tr();
                                }
                                return null;
                              }),
                              textFormFildBuilder(context,
                                  title: 'register.emailAddress',
                                  hint: 'register.inputs.email',
                                  controller: context
                                      .read<TravellerRegisterCubit>()
                                      .emailController,
                                  validation: (String? value) {
                                if (value!.isEmpty) {
                                  return 'register.EmailEnter'.tr();
                                }
                                return null;
                              }),
                              textFormFildBuilder(context,
                                  title: 'register.phone',
                                  hint: 'register.inputs.phone',
                                  controller: context
                                      .read<TravellerRegisterCubit>()
                                      .phoneNumber,
                                  inputType: TextInputType.number,
                                  validation: (String? value) {
                                if (!RegExp(r'^(?=.*?[0-9])').hasMatch(context
                                    .read<TravellerRegisterCubit>()
                                    .phoneNumber
                                    .text)) {
                                  return 'valid.number'.tr();
                                }
                                return null;
                              }),
                              textFormFildBuilder(context,
                                  title: 'Nationality',
                                  hint: 'Enter Nationality',
                                  controller: context
                                      .read<TravellerRegisterCubit>()
                                      .nationalty,
                                  inputType: TextInputType.text,
                                  validation: (String? value) {
                                if (value!.isEmpty) {
                                  return "enter nationality";
                                }
                                return null;
                              }),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "BirthDay",
                                        style: TextStyle(
                                          color: accentColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: true ? ' *' : '',
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
                                      onTap: () {
                                        context
                                            .read<TravellerRegisterCubit>()
                                            .PickDate(
                                                controller: context
                                                    .read<
                                                        TravellerRegisterCubit>()
                                                    .birthDay,
                                                context: context,
                                                firstTime: DateTime(1900),
                                                lastTime: DateTime.now());
                                      },
                                      readOnly: true,
                                      controller: context
                                          .read<TravellerRegisterCubit>()
                                          .birthDay,
                                      onChanged: (value) {},
                                      validator: (value) {
                                        return null;
                                      },
                                      style: TextStyle(
                                        color: accentColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 17.h),

                                        hintText: "EnterBirthDay",
                                        hintStyle: TextStyle(
                                          color: Color(0xFFCECFD1),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                223, 226, 230, 1),
                                          ),
                                        ),
                                        // filled: true,
                                        // fillColor: Color(0xFFF5F7FA),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              textFormFildBuilder(
                                context,
                                title: 'register.password',
                                hint: 'register.inputs.password',
                                controller: context
                                    .read<TravellerRegisterCubit>()
                                    .passwordController,
                                obstructText: context
                                    .read<TravellerRegisterCubit>()
                                    .isVisible,
                                validation: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'register.PasswordEnter'.tr();
                                  } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(
                                      context
                                          .read<TravellerRegisterCubit>()
                                          .passwordController
                                          .text)) {
                                    return 'valid.number'.tr();
                                  } else if (!RegExp(
                                          r'^(?=.*?[A-Z])(?=.*[a-z])')
                                      .hasMatch(context
                                          .read<TravellerRegisterCubit>()
                                          .passwordController
                                          .text)) {
                                    return 'valid.lowerCase'.tr();
                                  } else if (!RegExp(r'^(?=.*?[!@#\$&*~])')
                                      .hasMatch(context
                                          .read<TravellerRegisterCubit>()
                                          .passwordController
                                          .text)) {
                                    return 'valid.symbol'.tr();
                                  }
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    context
                                            .read<TravellerRegisterCubit>()
                                            .isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(0xFFCECFD1),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<TravellerRegisterCubit>()
                                        .togglePasswordVisibility();
                                  },
                                ),
                              ),

                              SizedBox(
                                height: 10.h,
                              ),

                              textFormFildBuilder(
                                context,
                                title: 'register.confirmPassword',
                                hint: 'register.inputs.password',
                                controller: context
                                    .read<TravellerRegisterCubit>()
                                    .confirmPasswordController,
                                obstructText: context
                                    .read<TravellerRegisterCubit>()
                                    .isVisible,
                                validation: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'register.PasswordEnter'.tr();
                                  } else if (context
                                          .read<TravellerRegisterCubit>()
                                          .confirmPasswordController
                                          .text
                                          .trim() !=
                                      context
                                          .read<TravellerRegisterCubit>()
                                          .passwordController
                                          .text
                                          .tr()) {
                                    return 'valid.passwordNotMatch'.tr();
                                  } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(
                                      context
                                          .read<TravellerRegisterCubit>()
                                          .passwordController
                                          .text)) {
                                    return 'valid.number'.tr();
                                  } else if (!RegExp(
                                          r'^(?=.*?[A-Z])(?=.*[a-z])')
                                      .hasMatch(context
                                          .read<TravellerRegisterCubit>()
                                          .passwordController
                                          .text)) {
                                    return 'valid.lowerCase'.tr();
                                  } else if (!RegExp(r'^(?=.*?[!@#\$&*~])')
                                      .hasMatch(context
                                          .read<TravellerRegisterCubit>()
                                          .passwordController
                                          .text)) {
                                    return 'valid.passwordNotMatch'.tr();
                                  }
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    context
                                            .read<TravellerRegisterCubit>()
                                            .isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(0xFFCECFD1),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<TravellerRegisterCubit>()
                                        .togglePasswordVisibility();
                                  },
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25.w, vertical: 10.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<TravellerRegisterCubit>()
                                              .changeGender(0);
                                        },
                                        child: Container(
                                          height: 130.h,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1.w,
                                                color: context
                                                            .read<
                                                                TravellerRegisterCubit>()
                                                            .selectedGender ==
                                                        0
                                                    ? accentColor
                                                    : Color(0xFFB2BBC6),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/auth/male.png',
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                'register.male'.tr(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: context
                                                              .read<
                                                                  TravellerRegisterCubit>()
                                                              .selectedGender ==
                                                          0
                                                      ? accentColor
                                                      : Color(0xFF47586E),
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<TravellerRegisterCubit>()
                                              .changeGender(1);
                                        },
                                        child: Container(
                                          height: 130.h,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1.w,
                                                color: context
                                                            .read<
                                                                TravellerRegisterCubit>()
                                                            .selectedGender ==
                                                        1
                                                    ? accentColor
                                                    : Color(0xFFB2BBC6),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/auth/famele.png',
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                'register.female'.tr(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: context
                                                              .read<
                                                                  TravellerRegisterCubit>()
                                                              .selectedGender ==
                                                          1
                                                      ? accentColor
                                                      : Color(0xFF47586E),
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "termConditions");
                                },
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'register.termAlert'.tr() + " ",
                                    style: TextStyle(
                                      color: accentColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'register.terms&conditions'.tr(),
                                        style: TextStyle(
                                          color: accentColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (TravellerRegisterCubit.get(context)
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    TravellerRegisterCubit.get(context)
                                        .registerTraveller();
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
                              SizedBox(
                                height: 10.h,
                              ),

                              RichText(
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
                                          Navigator.pushNamed(context, "login");
                                        },
                                      text: 'register.signin'.tr(),
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
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget textFormFildBuilder(
  BuildContext context, {
  required String title,
  required String hint,
  bool isRequired = true,
  required TextEditingController controller,
  bool obstructText = false,
  required final Function validation,
  TextInputType inputType = TextInputType.text,
  Widget? suffixIcon,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 7.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title.tr(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: isRequired ? ' *' : '',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          controller: controller,
          onChanged: (value) {
            context.read<TravellerRegisterCubit>().checkFields();
          },
          validator: (input) => validation(input),
          inputFormatters: [
            ArabicToEnglishNumeralsFormatter(),
          ],
          obscureText: obstructText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hint.tr(),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
            suffixIcon: suffixIcon,
            // filled: true,
            // fillColor: Color(0xFFF5F7FA),
          ),
        ),
      ],
    ),
  );
}
