import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/partner/landingMainContentCubit/landingMainContentCubit.dart';

class GuestsHosts extends StatelessWidget {
  const GuestsHosts({super.key});

  @override
  Widget build(BuildContext context) {
    bool haveGuest = false;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
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
                  )),
              child: LandingMainContentCubit.get(context).guestModel!.data!.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/landingHome/guestEmpty.png"),
                        Text(
                          "homeLanding.noHaveGuest".tr(),
                          style: TextStyle(color: accentColor, fontWeight: FontWeight.w400, fontSize: 16.sp),
                        )
                      ],
                    )
                  : ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Row(
                                children: [
                                  Text(
                                    "homeLanding.guests".tr(),
                                    style: TextStyle(color: accentColor, fontWeight: FontWeight.w700, fontSize: 18.sp),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, "viewAllGuests",
                                      arguments: {
                                        'state' : "0"
                                      }
                                      );
                                    },
                                    child: Text(
                                      "homeLanding.allGuests".tr(),
                                      style:
                                          TextStyle(color: accentColor, fontWeight: FontWeight.w700, decoration: TextDecoration.underline, fontSize: 18.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Text(
                                "You now have ${LandingMainContentCubit.get(context).guestModel!.data!.length} user for your service",

                                style: TextStyle(color: Color.fromRGBO(140, 140, 140, 1), fontWeight: FontWeight.w700, fontSize: 12.sp),
                              ),
                            ),
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, "profilePartner",arguments: {
                                      'id' : LandingMainContentCubit.get(context).guestModel!.data![index].id.toString()
                                    });
                                  },
                                  child: ListTile(
                                      leading: Image.asset("assets/images/landingHome/male.png"),
                                      title: Text(
                                        LandingMainContentCubit.get(context).guestModel!.data![index].name.toString(),
                                      ),
                                      titleTextStyle: TextStyle(color: accentColor, fontWeight: FontWeight.w700, fontSize: 14.sp),
                                      subtitle: Text(
                                        LandingMainContentCubit.get(context).guestModel!.data![index].email.toString(),
                                      ),
                                      subtitleTextStyle: TextStyle(color: accentColor, fontWeight: FontWeight.w400, fontSize: 12.sp)),
                                ),

                                separatorBuilder: (context, index) => SizedBox(
                                      height: 10.h,
                                    ),
                                itemCount: LandingMainContentCubit.get(context).guestModel!.data!.length),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        )
                      ],
                    )),
        ),
      ],
    );
  }
}
