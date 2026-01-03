import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text(
                    "payment.s1".tr(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,)
                ),
              ],
            ),
          ),
          SizedBox(height: 60.h,),
          Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.send_sharp,size: 80.sp,color: orange,))),
          SizedBox(height: 60.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
                "payment.s2".tr(),
                style: TextStyle(
                  fontSize: 14,color: Color.fromRGBO(9, 30, 66, 1),
                  fontWeight: FontWeight.w400,)
            ),
          ),
          SizedBox(height: 30.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
                "payment.s3".tr(),
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(9, 30, 66, 1),
                  fontWeight: FontWeight.w700,
                )
            ),
          ),
          SizedBox(height: 30.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Icon(Icons.date_range_outlined,color: orange,),
                SizedBox(width: 5.w,),
                Text(
                    "13 Jun 2024",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: orange,
                      fontWeight: FontWeight.w500,
                    )
                )
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Icon(Icons.lock_clock,color: orange,),
                SizedBox(width: 5.w,),
                Text(
                    "5:00 pm",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    )
                )
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            width: 350.w,
            height: 55.h,
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: orange))),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  backgroundColor: WidgetStateProperty.all<Color>(orange),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "travellerNavBar");

                },
                child: Text(
                  "payment.s4".tr(),
                  style: TextStyle(fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                )),
          ),
          SizedBox(height: 10.h,),



        ],
      ),

    );
  }
}
