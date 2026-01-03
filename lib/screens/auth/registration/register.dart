// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PassPort/components/color/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/auth/image5.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: ListView(
            children: [
              SizedBox(
                height: 100.h,
              ),
              Center(child: Image.asset("assets/images/ard_logo.png")),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'travellerRegister');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: ShapeDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'landing.traveller'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'partnerRegister');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: ShapeDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'landing.partner'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login, color: Colors.white),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      'register.login'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
