import 'package:PassPort/screens/auth/login/widget/buildModernTextField.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customButton/customButton.dart';
import 'package:PassPort/components/widgets/customText.dart';
import 'package:PassPort/services/auth/login/loginCubit.dart';
import 'package:PassPort/services/auth/login/loginState.dart';

import '../login/login.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ChangePasswordError) {
            // print('ChangePasswordIcon');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: TextStyle(color: white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ChangePasswordSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'login', (route) => false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'password changed success'.tr(),
                  style: TextStyle(color: white),
                ),
                backgroundColor: accentColor,
              ),
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
                      key: LoginCubit.get(context).formKeyCreatePassword,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/ard_logo.png",
                            height: 300.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 10.w, left: 10.w, bottom: 10.h),
                            child: Container(
                              width: 355.w,
                              decoration: BoxDecoration(
                                  color: white,
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
                                      height: 40.h,
                                    ),
                                    Text(
                                      'login.createPassword'.tr(),
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
                                        'login.pleasePassword'.tr(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(122, 134, 153, 1),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    buildModernTextField(context,
                                        title: 'login.createPassword'.tr(),
                                        hint: 'register.inputs.password'.tr(),
                                        validation: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'login.enterPassword'.tr();
                                      }
                                      return null;
                                    },
                                        controller: LoginCubit.get(context)
                                            .createPassword,
                                        suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.visibility_off),
                                        ),
                                        prefixIcon: Icons.lock_outline),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    buildModernTextField(context,
                                        title: 'login.confirmPassword1'.tr(),
                                        hint: 'register.inputs.password'.tr(),
                                        validation: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'login.enterPassword'.tr();
                                      }
                                      return null;
                                    },
                                        controller: LoginCubit.get(context)
                                            .confirmCreatePassword,
                                        suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.visibility_off,
                                            color: accentColor,
                                          ),
                                        ),
                                        prefixIcon: Icons.lock_outline),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    CustomButton(
                                        height: 50.h,
                                        backgroudColor: accentColor,
                                        function: () {
                                          LoginCubit.get(context)
                                              .createNewPassword(
                                                  email: args['email']);
                                        },
                                        text: 'login.confirmPassword1'.tr(),
                                        width: 327.w),
                                    SizedBox(
                                      height: 20.h,
                                    ),
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
