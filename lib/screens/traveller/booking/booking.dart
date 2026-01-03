import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:expandable_page_view/expandable_page_view.dart';

import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';

import 'accomandation/cancelled/cancelled.dart';
import 'accomandation/complete/completed.dart';
import 'accomandation/pending/pending.dart';
import 'accomandation/upcomming/upcomming.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controllerBooking = PageController();

    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit(),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              centerTitle: true,
              title: Text(
                "booking.booking".tr(),
                style: TextStyle(
                  color: black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          bookingHost(
                              context: context,
                              index: 0,
                              title: "booking.Pending",
                              function: () {
                                BookingTravellerCubit.get(context)
                                    .toggleBooking(0);
                                controllerBooking.animateToPage(0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                                //BookingTravellerCubit.get(context).getAllBooking(state: "0", serviceName: "accommodations");
                              }),
                          SizedBox(
                            width: 20.w,
                          ),
                          bookingHost(
                              context: context,
                              index: 1,
                              title: "booking.Upcoming",
                              function: () {
                                BookingTravellerCubit.get(context)
                                    .toggleBooking(1);
                                controllerBooking.animateToPage(1,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                                // BookingTravellerCubit.get(context).getAllBooking(state: "1", serviceName: "accommodations");
                              }),
                          SizedBox(
                            width: 20.w,
                          ),
                          bookingHost(
                              context: context,
                              index: 2,
                              title: "booking.Completed",
                              function: () {
                                BookingTravellerCubit.get(context)
                                    .toggleBooking(2);
                                controllerBooking.animateToPage(2,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                                // BookingTravellerCubit.get(context).getAllBooking(state: "2", serviceName: "accommodations");
                              }),
                          SizedBox(
                            width: 20.w,
                          ),
                          bookingHost(
                              context: context,
                              index: 3,
                              title: "booking.Cancelled",
                              function: () {
                                BookingTravellerCubit.get(context)
                                    .toggleBooking(3);
                                controllerBooking.animateToPage(3,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                                //BookingTravellerCubit.get(context).getAllBooking(state: "3", serviceName: "accommodations");
                              }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Divider(
                    color: Color.fromRGBO(217, 217, 217, 1),
                  ),
                  ExpandablePageView(
                    controller: controllerBooking,
                    physics: NeverScrollableScrollPhysics(),
                    children: [Pending(), UpComing(), Completed(), Cancelled()],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget bookingHost(
    {required context,
    required int index,
    required String title,
    required VoidCallback function}) {
  return GestureDetector(
    onTap: function,
    child: Container(
      width: 110.w,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(30.r),
        border: Border.all(
            color: BookingTravellerCubit.get(context).toggle == index
                ? black
                : Color.fromRGBO(238, 238, 238, 1)),
      ),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          title.tr(),
          style: TextStyle(
            color: black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}
