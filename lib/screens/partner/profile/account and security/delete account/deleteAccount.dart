import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customText.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_cubit.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_state.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (BuildContext context, state) {
          if (state is DeleteAccountSuccessful) {
            deleteAccountSuccessDialog(context);
            Navigator.pushNamed(context, "register");
          } else if (state is DeleteAccountError) {
            context.showCustomSnackBar(
              state.error,
              type: SnackBarType.error,
            );
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'accountSecurity.deleteAccount'.tr(),
                style: TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
            ),
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
                // Existing content
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'accountSecurity.deleteAccountTitle'.tr(),
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'accountSecurity.deleteAccountHint'.tr(),
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Text(
                        'register.password'.tr(),
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller:
                            UserCubit.get(context).deleteAccountPassword,
                        obscureText:
                            UserCubit.get(context).isPasswordVisibleDelete,
                        decoration: InputDecoration(
                          hintText: 'register.password'.tr(),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              UserCubit.get(context)
                                  .changePasswordVisibilityDelete();
                            },
                            child: UserCubit.get(context)
                                        .isPasswordVisibleDelete ==
                                    true
                                ? Icon(
                                    Icons.visibility_off,
                                    color: accentColor,
                                    size: 20.sp,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: accentColor,
                                    size: 20.sp,
                                  ),
                          ),
                          hintStyle: TextStyle(
                            color: accentColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: double.infinity,
                        height: 60.h,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (contextItem) {
                                return AlertDialog(
                                  surfaceTintColor: Colors.white,
                                  title: Image.asset(
                                    'assets/images/main/code-review 1.png',
                                    width: 120.w,
                                    height: 120.h,
                                  ),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          'register.delete'.tr(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: accentColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                UserCubit.get(context)
                                                    .deleteAccount(
                                                        password: UserCubit.get(
                                                                context)
                                                            .deleteAccountPassword
                                                            .text);
                                                Navigator.pop(contextItem);
                                              },
                                              child: Container(
                                                width: 100.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                  border:
                                                      Border.all(color: white),
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: CustomText(
                                                  text: "register.confirm".tr(),
                                                  size: 16.sp,
                                                  color: white,
                                                  fontWeight: FontWeight.w700,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(contextItem);
                                              },
                                              child: Container(
                                                width: 100.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                  border:
                                                      Border.all(color: white),
                                                  color: Colors.grey.shade500,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: CustomText(
                                                  text: "register.cancel".tr(),
                                                  size: 16.sp,
                                                  color: white,
                                                  fontWeight: FontWeight.w700,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            'accountSecurity.deleteAccount'.tr(),
                            style: TextStyle(
                              color: white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      //cancel button
                      Container(
                        width: double.infinity,
                        height: 60.h,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'accountSecurity.cancel'.tr(),
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  deleteAccountSuccessDialog(BuildContext cxt) {
    showDialog(
      context: cxt,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Icon(
            Icons.delete_forever_outlined,
            color: Colors.red,
            size: 120.sp,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'accountSecurity.deleteAccountSuccess'.tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'accountSecurity.deleteAccountSuccessHint'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
