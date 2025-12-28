import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/partner/landingMainContentCubit/landingMainContentCubit.dart';

class CancelGuests extends StatelessWidget {
  const CancelGuests({super.key});

  @override
  Widget build(BuildContext context) {

    return

      Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 25.w),
            child: Container(
                width: 327.w,
                height: 350.h,
                decoration: BoxDecoration(
                    color:  Colors.white54,
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(16.r),
                      bottomEnd: Radius.circular(0.r),
                      topStart: Radius.circular(16.r),
                      bottomStart: Radius.circular(16.r),

                    )
                ),
                child:

                LandingMainContentCubit.get(context).cancelModel?.data!.length == 0 ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/landingHome/guestEmpty.png"),
                    Text(
                      "homeLanding.exitGuests".tr(),
                      style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    )

                  ],
                ) :
                ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 15.w, left : 15.w , ),
                          child: Row(
                            children: [
                              Text(
                                "homeLanding.guests".tr(),
                                style: TextStyle(
                                    color: accentColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, "viewAllGuests",arguments: {
                                    'state' : "3"
                                  });
                                },
                                child: Text(
                                  "homeLanding.allGuests".tr(),
                                  style: TextStyle(
                                      color: accentColor,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      fontSize: 18.sp),
                                ),
                              ),


                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            "You now have ${LandingMainContentCubit.get(context).cancelModel!.data!.length} user for your service",

                            style: TextStyle(
                                color: Color.fromRGBO(140, 140, 140, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: 12.sp),
                          ),
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context,index) =>

                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, "profilePartner",arguments: {
                                    'id' : LandingMainContentCubit.get(context).cancelModel!.data![index].id.toString()
                                  });
                                },
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/landingHome/male.png"),
                                    SizedBox(width: 10.w,),
                                    Column(
                                      children: [
                                        Text(
                                          LandingMainContentCubit.get(context).cancelModel!.data![index].name.toString(),
                                          style: TextStyle(
                                              color: accentColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp),
                                        ),
                                        Text(
                                          LandingMainContentCubit.get(context).cancelModel!.data![index].email.toString(),

                                          style: TextStyle(
                                              color: accentColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),

                          separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
                          itemCount:  LandingMainContentCubit.get(context).cancelModel!.data!.length,
                        ),
                        SizedBox(height: 10.h,),

                      ],
                    )
                  ],
                )
            ),
          ),





        ],
      );
  }
}
