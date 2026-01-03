import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

class FollowTrips extends StatelessWidget {
  const FollowTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: appBackgroundColor,

      appBar: AppBar(
          backgroundColor: appBackgroundColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
              "trips.TripBooking".tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              )
          )),
      body: Column(

        children: [
          Padding(
            padding:  EdgeInsets.only(right: 20.w,left: 20.w,top: 50.h),
            child: Row(

              children: [
                Image.asset("assets/images/traveller/tripbooking.png"),
                SizedBox(width: 20.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        "trips.t1".tr(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: accentColor
                          )
                      ),
                    ),
                    SizedBox(height: 20.h,),

                    SizedBox(
                      width: 280.w,
                      child: Text(
                          "trips.t2".tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                              color: accentColor

                          )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Divider(color: Color.fromRGBO(178, 187, 198, 1),),
          Padding(
            padding:  EdgeInsets.only(right: 20.w,left: 20.w,top: 50.h),
            child: Row(

              children: [
                Image.asset("assets/images/traveller/tripbooking2.png"),
                SizedBox(width: 20.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250.w,
                      child: Row(
                        children: [
                          Text(
                              "trips.t3".tr(),

                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              )
                          ),
                          SizedBox(width: 5.w,),
                          Image.asset("assets/images/traveller/warining.png")
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Text(
                        "trips.t4".tr(),

                        style: TextStyle(
                          fontSize: 14.sp,
                          color: accentColor,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                    SizedBox(height: 10.h,),

                    SizedBox(
                      width: 280.w,
                      child:Text(
                          "trips.t5".tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: accentColor,
                            fontWeight: FontWeight.w400,
                          )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Container(
            width: 275.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15.r),
              border: Border.all(color: Colors.white54)
            ),
            child: Padding(
              padding:  EdgeInsets.only(right: 20.w,left: 20.w,top: 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/traveller/warining.png"),
                  SizedBox(width: 10.w,),
                  Column(
                    children: [
                      Text(
                          "trips.t6".tr(),

                          style: TextStyle(
                            fontSize: 12.sp,
                            color: accentColor,
                            fontWeight: FontWeight.w600,
                          )
                      ),
                      SizedBox(height: 10.h,),
                      Text(
                          "trips.t7".tr(),

                          style: TextStyle(
                            fontSize: 12,
                            color: accentColor,

                            fontWeight: FontWeight.w400,
                          )
                      ),
                      SizedBox(height: 10.h,),
                      Text(
                          "trips.t8".tr(),

                          style: TextStyle(
                            fontSize: 12,
                            color: accentColor,
                            fontWeight: FontWeight.w400,
                          )
                      ),
                      SizedBox(height: 10.h,),



                    ],
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
                  backgroundColor: WidgetStateProperty.all<Color>(accentColor),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "pendingBooking");
                },
                child: Text(
                  "booking.CompleteBooking".tr(),
                  style: TextStyle(fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                )),
          ),
          SizedBox(height: 20.h,),



        ],
      ),
    );
  }
}
