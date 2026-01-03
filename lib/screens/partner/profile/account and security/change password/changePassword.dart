import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_cubit.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_state.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessful) {
            Fluttertoast.showToast(
                msg: "Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            UserCubit.get(context).oldPassword.clear();
            UserCubit.get(context).newPassword.clear();
            UserCubit.get(context).confirmNewPassword.clear();
          }
          if (state is ChangePasswordError) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'accountSecurity.changePassword'.tr(),
                style: TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  textFormFildBuilder(
                    context,
                    title: 'accountSecurity.old'.tr(),
                    hint: 'accountSecurity.oldHint'.tr(),
                    obstructText: UserCubit.get(context).isPasswordVisible,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          UserCubit.get(context).changePasswordVisibility();
                        },
                        child: UserCubit.get(context).isPasswordVisible
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.visibility_off)),
                    controller: UserCubit.get(context).oldPassword,
                  ),
                  textFormFildBuilder(
                    context,
                    title: 'accountSecurity.new'.tr(),
                    hint: 'accountSecurity.newHint'.tr(),
                    obstructText: UserCubit.get(context).isPasswordVisibleNew,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          UserCubit.get(context).changePasswordVisibilityNew();
                        },
                        child: UserCubit.get(context).isPasswordVisibleNew
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.visibility_off)),
                    controller: UserCubit.get(context).newPassword,
                  ),
                  textFormFildBuilder(
                    context,
                    title: 'accountSecurity.new'.tr(),
                    obstructText: UserCubit.get(context).isPasswordVisibleNew,
                    hint: 'accountSecurity.newHint'.tr(),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          UserCubit.get(context).changePasswordVisibilityNew();
                        },
                        child: UserCubit.get(context).isPasswordVisibleNew
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.visibility_off)),
                    controller: UserCubit.get(context).confirmNewPassword,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'forgotPassword');
                    },
                    child: Text(
                      'login.forgotPassword'.tr(),
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              child: SizedBox(
                width: 1.sw,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    print("object");
                    UserCubit.get(context).changePassword();
                  },
                  child: Text(
                    'accountSecurity.changePassword'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(accentColor),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textFormFildBuilder(
    BuildContext context, {
    required String title,
    required String hint,
    required TextEditingController controller,
    bool obstructText = false,
    TextInputType inputType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: accentColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
            width: 1.sw,
            child: TextFormField(
              controller: controller,
              obscureText: obstructText,
              style: TextStyle(
                color: accentColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: hint.tr(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                hintStyle: TextStyle(
                  color: accentColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: accentColor,
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
}
