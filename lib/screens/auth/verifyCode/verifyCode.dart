import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customButton/customButton.dart';
import 'package:PassPort/services/auth/login/loginCubit.dart';
import 'package:PassPort/services/auth/login/loginState.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is VerifyCodeSuccess) {
            Navigator.pushNamed(context, 'createPassword', arguments: {
              'email': args['email']!,
            });
          }
          if (state is VerifyCodeError) {
            context.showCustomSnackBar(
              state.error,
              type: SnackBarType.error,
            );
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
                      key: LoginCubit.get(context).formKeyVerifyCode,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20.h),
                                  Image.asset(
                                      "assets/images/login/forgotPassword.png"),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    'login.verifyCode'.tr(),
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: accentColor),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 25.w),
                                        child: Text(
                                          'login.verifyCodeContent'.tr(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                122, 134, 153, 1),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        args['email']!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                    ),
                                    child: PinCodeTextField(
                                      appContext: context,
                                      pastedTextStyle: TextStyle(
                                        color: Colors.green.shade600,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      length: 6,

                                      blinkWhenObscuring: true,
                                      animationType: AnimationType.fade,

                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(5),
                                        fieldHeight: 50,
                                        fieldWidth: 40,
                                        activeFillColor: Colors.white,
                                        selectedColor: accentColor,
                                        selectedFillColor: Colors.white,
                                        inactiveColor: accentColor,
                                        inactiveFillColor: Colors.white,
                                        activeColor: accentColor,
                                      ),
                                      cursorColor: accentColor,
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      enableActiveFill: true,
                                      controller:
                                          LoginCubit.get(context).verifyCode,
                                      keyboardType: TextInputType.number,
                                      errorTextSpace: 30.sp,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'login.enterverifyCode'.tr();
                                        }
                                        return null;
                                      },
                                      boxShadows: const [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          color: accentColor,
                                          blurRadius: 10,
                                        )
                                      ],
                                      onCompleted: (v) {
                                        debugPrint("Completed");
                                      },
                                      textStyle: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600,
                                          color: accentColor),
                                      // onTap: () {
                                      //   print("Pressed");
                                      // },
                                      onChanged: (value) {
                                        debugPrint(value);
                                        context
                                            .read<LoginCubit>()
                                            .verifyCode
                                            .text = value;
                                      },
                                      beforeTextPaste: (text) {
                                        debugPrint("Allowing to paste $text");
                                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                        return true;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  CustomButton(
                                      height: 50.h,
                                      backgroudColor: LoginCubit.get(context)
                                              .verifyCode
                                              .text
                                              .trim()
                                              .isEmpty
                                          ? Color.fromRGBO(140, 140, 140, 1)
                                          : orange,
                                      function: () {
                                        if (LoginCubit.get(context)
                                            .formKeyVerifyCode
                                            .currentState!
                                            .validate()) {
                                          // Navigator.pushNamed(context, 'createPassword');
                                          print(
                                              'verifyCode: ${LoginCubit.get(context).verifyCode.text}');
                                        }
                                        context
                                            .read<LoginCubit>()
                                            .verifyCodeSentToUser(
                                                email: args["email"]!);
                                      },
                                      text: 'login.verify'.tr(),
                                      width: 327.w),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'login.sendCode'.tr(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: accentColor),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // context.read<LoginCubit>().sendCode(email: args["email"]!);
                                          LoginCubit.get(context)
                                              .verifyCode
                                              .text = '';
                                          LoginCubit.get(context)
                                              .sendCode(email: args["email"]!)
                                              .then(
                                                (value) => ScaffoldMessenger.of(
                                                        context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text('sent'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                ),
                                              );
                                        },
                                        child: Text(
                                          'login.send'.tr(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: accentColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
