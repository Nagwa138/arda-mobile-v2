import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

class ConnectTeamSupport extends StatelessWidget {
  const ConnectTeamSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
       title:  Text("homeLanding.connectMe".tr(),style: TextStyle(
          color: accentColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),

        ),

      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            Row(
              children: [
                Text("homeLanding.helpMe".tr(),style: TextStyle(
                  color: accentColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
                ),
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              children: [
                Expanded(
                  child: Text("homeLanding.connectMessage".tr(),style: TextStyle(
                    color: accentColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  
                  
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 154.w,
                    height: 111.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(16.r),
                      border: Border.all(
                        color: accentColor
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/landingHome/phone.png"),
                        Text("homeLanding.callMe".tr(),style: TextStyle(
                          color: accentColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),


                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20.w,),
                Expanded(
                  child: Container(
                    width: 154.w,
                    height: 111.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(16.r),
                        border: Border.all(
                            color: accentColor
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/landingHome/email.png"),
                        Text("homeLanding.sendSms".tr(),style: TextStyle(
                          color: accentColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
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
      ),
    );
  }
}
