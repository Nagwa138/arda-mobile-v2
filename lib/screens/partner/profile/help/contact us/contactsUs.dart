import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_cubit.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_state.dart';

class ContactsUs extends StatelessWidget {
  const ContactsUs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'contact.title'.tr(),
                style: TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              children: [
                Text(
                  'contact.maintitle'.tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'contact.subtitle'.tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        final String phoneNumber = "201127306001";
                        final String message = "Hello";

                        UserCubit.get(context).launchWhatsApp(
                            phoneNumber: phoneNumber, message: message);
                      },
                      child: Container(
                        width: 154.w,
                        // height: 111,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 24.h),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white54,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.w,
                              color: Colors.white54,
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/main/phone-call 1.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              'contact.call'.tr(),
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final String email = "Mohamedheshamsheta@gmail.com";
                        UserCubit.get(context)
                            .launchEmail(toEmail: email, subject: "", body: "");
                      },
                      child: Container(
                        width: 154.w,
                        // height: 111,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 24.h),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white54,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.w,
                              color: Colors.white54,
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/main/email 1.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              'contact.email'.tr(),
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
