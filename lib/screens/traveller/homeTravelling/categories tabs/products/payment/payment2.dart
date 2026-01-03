import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

class Payment2 extends StatelessWidget {
  const Payment2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("payment.confirm".tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ))),
      
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "payment.p1".tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Color.fromRGBO(9, 30, 66, 1),
                  fontWeight: FontWeight.w600,
                )
            ),
            SizedBox(height: 10.h,),
            Text(
                "payment.p2".tr(),
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(9, 30, 66, 1),

                  fontWeight: FontWeight.w400,
                )
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/traveller/fawery.png"),
                Image.asset("assets/images/traveller/visa.png"),
                Image.asset("assets/images/traveller/money.png"),
                Image.asset("assets/images/traveller/vodafone.png"),
                Image.asset("assets/images/traveller/insta.png"),






              ],
            ),
            SizedBox(height: 20.h,),
            Container(
              width: 327.w,
              height: 50.h,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(5, 10, 42, 1)),
                borderRadius: BorderRadiusDirectional.circular(10.r),
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 10.w,),
                    Text(
                        "payment.add".tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        )
                    )
                  ],
                ),
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
                  onPressed: () {},
                  child: Text(
                    "payment.checkOut".tr(),
                    style: TextStyle(fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                  )),
            ),
            SizedBox(height: 10.h,),
          ],
        ),
      ),
    );
  }
}
