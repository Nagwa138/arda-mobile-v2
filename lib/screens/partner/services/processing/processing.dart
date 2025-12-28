import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

class Processing extends StatelessWidget {
  const Processing({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context,index){
          return Column(
            children: [
              Container(
                width: 327.w,

                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(25.r),
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset("assets/images/services/serviceImage.png",
                      width: 327.w, fit: BoxFit.fill,),
                    Padding(
                      padding:  EdgeInsets.only(top: 20.h,right: 10.w),
                      child: Container(
                        width: 115.w,
                        height: 41.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(24.r),
                            color: white
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.circle,size: 10.sp,color: orange,),
                            SizedBox(width: 5.w,),

                            Text("Services.confirm".tr(),style: TextStyle(
                                color: black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700
                            ),),
                          ],
                        ),
                      ),
                    )


                  ],
                ),

              ),
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  children: [
                    Text("Enight Marsa Alam - Red sea",style: TextStyle(
                        color: black,
                        fontSize: 18.sp,
                        fontFamily: "'Mona Sans",
                        fontWeight: FontWeight.w700
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 15.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  children: [
                    Text("Services.hotels".tr(),style: TextStyle(
                        color: orange,
                        fontSize: 18.sp,
                        fontFamily: "'Mona Sans",
                        fontWeight: FontWeight.w700
                    ),),
                  ],
                ),
              ),
            ],
          );
        }, separatorBuilder: (context,index)=>Padding(
      padding:  EdgeInsets.symmetric(horizontal: 25.w),
      child: Divider(color: Colors.grey,),
    ), itemCount: 5);
  }
}
