import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

class PendingBooking extends StatelessWidget {
  const PendingBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: appBackgroundColor,

      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding:  EdgeInsets.only(top: 30.h,left: 20.w,right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "trips.t9".tr(),
                style: TextStyle(
                  fontSize: 28.sp,
                  color: accentColor,
                  fontWeight: FontWeight.w700,
                )
            ),
            SizedBox(height: 10.h,),
            Text(
                "trips.t10".tr(),                style: TextStyle(
                  fontSize: 14.sp,
                  color: accentColor,

                  fontWeight: FontWeight.w400,
                )
            ),
            Spacer(),
            Image.asset("assets/images/traveller/anim.gif"),

            SizedBox(
              width: 350.w,
              height: 55.h,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: orange))),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    backgroundColor: WidgetStateProperty.all<Color>(accentColor),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "travellerNavBar");
                  },
                  child: Text(
                   "trips.goBack".tr(),
                    style: TextStyle(fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                  )),
            ),
            SizedBox(height: 20.h,),
          ],
        ),
      ),
    );
  }
}
