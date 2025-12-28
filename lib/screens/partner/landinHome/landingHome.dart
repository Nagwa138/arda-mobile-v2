// ignore_for_file: must_be_immutable


import 'package:PassPort/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:PassPort/services/notification/notificationLogic.dart';
import 'package:PassPort/services/partner/landingMainContentCubit/landingMainContentCubit.dart';
import 'package:PassPort/services/partner/landingMainContentCubit/landingMainContentStates.dart';
import '../../../components/color/color.dart';
import 'arriveGuest/arriveGuests.dart';
import 'cancel_guest/cancel_guest.dart';
import 'exitGuests/exitGuests.dart';
import 'guestsHost/guestHost.dart';

class LandingHome extends StatelessWidget {
  LandingHome({super.key});

  PageController servicesController = PageController();

   Color appBackgroundColor = Color(0xFFFBF0E3); // Light beige background

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandingMainContentCubit()..load(),
      child: BlocConsumer<LandingMainContentCubit, LandingMainContentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(alignment: Alignment.center, children: [
                    Image.asset(
                      "assets/images/auth/intersect.jpeg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 350.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          Text(
                            "homeLanding.welcome".tr() + "",
                            style: TextStyle(color: white, fontWeight: FontWeight.w700, fontSize: 26.sp),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                FirebaseNotification list = FirebaseNotification();
                                Navigator.pushNamed(context, 'travellerNotification',arguments:list.notificationList );
                              },
                            icon: ValueListenableBuilder<bool>(
                              valueListenable: isUserNotification,
                              builder: (context,value,child){
                                return IconButton(
                                  onPressed: () {
                                    FirebaseNotification list = FirebaseNotification();
                                    Navigator.pushNamed(context, 'travellerNotification',arguments:list.notificationList );
                                  },
                                  icon: Icon(
                                      Icons.notification_add,
                                      size: 24.sp,
                                      color:
                                      value ?
                                      white : Colors.green
                                  ),
                                );
                              },

                            ),
                              // icon: Icon(
                              //   Icons.notification_add,
                              //   color: white,
                              // )

                          )
                        ],
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "addAccommodation");
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        dashPattern: const [10.5, 8.3, 5, 8],
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        radius: Radius.circular(20.r),
                        color: accentColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "homeLanding.addService".tr(),
                                style: TextStyle(color: accentColor, fontWeight: FontWeight.w600, fontSize: 18.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Text(
                      "homeLanding.booking".tr(),
                      style: TextStyle(color: accentColor, fontWeight: FontWeight.w600, fontSize: 24.sp),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              bookingHost(
                                  context: context,
                                  index: 0,
                                  title: "booking.Pending".tr(),
                                  function: () {
                                    LandingMainContentCubit.get(context).toggleServices(0);
                                    servicesController.animateToPage(0, duration: Duration(microseconds: 300), curve: Curves.easeIn);
                                  }),
                              SizedBox(
                                width: 10.w,
                              ),
                              bookingHost(
                                  context: context,
                                  index: 1,
                                  title: "booking.Upcoming".tr(),
                                  function: () {
                                    LandingMainContentCubit.get(context).toggleServices(1);
                                    servicesController.animateToPage(1, duration: Duration(microseconds: 300), curve: Curves.easeIn);
                                  }),
                              SizedBox(
                                width: 10.w,
                              ),
                              bookingHost(
                                  context: context,
                                  index: 2,
                                  title: "booking.Completed".tr(),
                                  function: () {
                                    LandingMainContentCubit.get(context).toggleServices(2);
                                    servicesController.animateToPage(2, duration: Duration(microseconds: 300), curve: Curves.easeIn);
                                  }),
                              SizedBox(
                                width: 10.w,
                              ),
                              bookingHost(
                                  context: context,
                                  index: 3,
                                  title: "booking.Cancelled".tr(),
                                  function: () {
                                    LandingMainContentCubit.get(context).toggleServices(3);
                                    servicesController.animateToPage(3, duration: Duration(microseconds: 300), curve: Curves.easeIn);
                                  }),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h,),
                 state is getAllGuestLoadingState   ? Center(child: CircularProgressIndicator(color: orange,)) :  SizedBox(
                    height: 350.h,
                    child: PageView(
                      controller: servicesController,
                      physics: NeverScrollableScrollPhysics(),
                      children: const [
                        GuestsHosts(),
                        UpComingGuests(),
                        CompleteGuests(),
                        CancelGuests(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "connect");
                      },
                      child: Container(
                        width: 330.w,
                        //height: 135.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(16.r),
                          border: Border.all(
                            color: Color(0xFFB2BBC6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  "assets/images/landingHome/support.png",
                                  width: 36.w,
                                  height: 36.h,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "homeLanding.connect".tr(),
                                      style: TextStyle(color: accentColor, fontWeight: FontWeight.w700, fontSize: 16.sp),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "homeLanding.connectDetails".tr(),
                                      style: TextStyle(color: Color(0xFF7E7E7E), fontWeight: FontWeight.w400, fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget bookingHost({required context, required int index, required String title, required VoidCallback function}) {
  return GestureDetector(
    onTap: function,
    child: Container(
      width: 130.w,
      height: 50.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(16.r),
          border: Border.all(color: LandingMainContentCubit.get(context).toggle == index ? orange : const Color.fromRGBO(163, 173, 187, 1))),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: accentColor, fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
      ),
    ),
  );
}
