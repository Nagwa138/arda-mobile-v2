import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customButton/customButton.dart';
import 'package:PassPort/components/widgets/customText.dart';
import 'package:PassPort/services/auth/login/loginCubit.dart';
import 'package:PassPort/services/auth/login/loginState.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            Navigator.pushNamed(context, 'verifyCode', arguments: {
              'email': LoginCubit.get(context).forgotPassword.text,
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ));
          }
          if (state is ForgotPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: appBackgroundColor,
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/login/image2.png"),
                          fit: BoxFit.cover,
                        ),
                      )),
                  SingleChildScrollView(
                    child: Form(
                      key: LoginCubit.get(context).formKeyForgotPassword,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/ard_logo.png",
                            height: 300.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 10.w, left: 10.w, bottom: 20.h),
                            child: Container(
                              width: 355.w,
                              decoration: BoxDecoration(
                                  color: appBackgroundColor,
                                  borderRadius: BorderRadiusDirectional.only(
                                    topEnd: Radius.circular(24.r),
                                    topStart: Radius.circular(24.r),
                                    bottomStart: Radius.circular(4.r),
                                    bottomEnd: Radius.circular(24.r),
                                  )),
                              child: SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Image.asset(
                                        "assets/images/login/forgotPassword.png"),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      'login.forgotPassword'.tr(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: accentColor),
                                    ),
                                    SizedBox(height: 10.h),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 25.w, left: 25.w),
                                      child: Text(
                                        'login.contentPassword'.tr(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(122, 134, 153, 1),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    textFormFildBuilder(
                                      context,
                                      title: 'register.emailAddress'.tr(),
                                      hint: 'register.inputs.email'.tr(),
                                      controller: LoginCubit.get(context)
                                          .forgotPassword,
                                      validation: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'login.enterEmail'.tr();
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomButton(
                                        height: 50.h,
                                        backgroudColor: accentColor,
                                        function: () {
                                          if (LoginCubit.get(context)
                                              .formKeyForgotPassword
                                              .currentState!
                                              .validate()) {
                                            LoginCubit.get(context).sendCode(
                                                email: LoginCubit.get(context)
                                                    .forgotPassword
                                                    .text);
                                          }
                                        },
                                        text: 'login.confirmPassword'.tr(),
                                        width: 327.w),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'login.createAccount'.tr(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: accentColor),
                                        ),
                                        Text(
                                          'login.signUp'.tr(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: accentColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
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
  required final Function validation,
  bool obstructText = false,
  TextInputType inputType = TextInputType.text,
  Widget? suffixIcon,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 7.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: title,
            size: 14.sp,
            color: accentColor,
            fontWeight: FontWeight.w700),
        SizedBox(
          height: 5.h,
        ),
        SizedBox(
          width: 327.w,
          child: TextFormField(
            controller: controller,
            obscureText: obstructText,
            style: TextStyle(
              color: accentColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            validator: (input) => validation(input),
            decoration: InputDecoration(
              hintText: hint.tr(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
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
        ),
      ],
    ),
  );
}
