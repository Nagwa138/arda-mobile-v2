import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restart_app/restart_app.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customText.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,

      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'language.title'.tr(),
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
          GestureDetector(
            onTap: () {
              context.setLocale(const Locale('en'));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(12.r),
                border: Border.all(
                  color: context.locale.toLanguageTag() == 'en' ? accentColor : Colors.grey,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/splash/us.png",
                    width: 56.w,
                    height: 56.h,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  CustomText(text: 'English', size: 16.sp, color: accentColor, fontWeight: FontWeight.w600)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              context.setLocale(const Locale('ar'));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(12.r),
                border: Border.all(
                  color: context.locale.toLanguageTag() == 'ar' ? accentColor : Colors.grey,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/splash/egypt.png",
                    width: 56.w,
                    height: 56.h,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  CustomText(
                    text: 'عربي',
                    size: 16.sp,
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: ElevatedButton(
          onPressed: () {
            Restart.restartApp();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: CustomText(
              text: 'language.change'.tr(),
              size: 14.sp,
              color: white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
