import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

class PendingRequest extends StatelessWidget {
  const PendingRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      backgroundColor: appBackgroundColor,

      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "confirmation.t2".tr(),
              style: TextStyle(
                color: accentColor,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                "confirmation.sub2".tr(),
                style: TextStyle(
                  color: Color(0xFF8C8C8C),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Icon(Icons.bed_outlined, color: black, size: 30.sp),
              SizedBox(width: 10.w),
              Text(
                "addService.2.single".tr(),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.person_outline, color: black, size: 30.sp),
              SizedBox(width: 10.w),
              Text(
                arguments['single'] + "viewRooms.title3".tr(),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.date_range, color: accentColor, size: 30.sp),
              SizedBox(width: 10.w),
              Text(
               arguments['date'],
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Container(
          height: 50.h,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(accentColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'travellerNavBar');
              // print("object");
            },
            child: Text(
              "booking.Continue".tr(),
              style: TextStyle(
                fontSize: 16.sp,
                color: white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
