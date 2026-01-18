import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/traveller/booking/activity/cancel/cancel.dart';
import 'package:PassPort/screens/traveller/booking/activity/pending/pending.dart';
import 'package:PassPort/screens/traveller/booking/activity/upcomming/upcoming.dart';
import 'package:PassPort/screens/traveller/booking/widgets/booking_tab_button.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'complete/complete.dart';

class BookingActivity extends StatelessWidget {
  BookingActivity({super.key});
  final PageController controllerBooking = PageController();

  @override
  Widget build(BuildContext context) {
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
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
              title: Text(
                "booking.booking".tr(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BookingTabButton(
                          isSelected:
                              BookingTravellerCubit.get(context).toggle == 0,
                          title: "booking.Pending",
                          onTap: () {
                            BookingTravellerCubit.get(context).toggleBooking(0);
                            controllerBooking.animateToPage(0,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                        ),
                        BookingTabButton(
                          isSelected:
                              BookingTravellerCubit.get(context).toggle == 1,
                          title: "booking.Upcoming",
                          onTap: () {
                            BookingTravellerCubit.get(context).toggleBooking(1);
                            controllerBooking.animateToPage(1,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                        ),
                        BookingTabButton(
                          isSelected:
                              BookingTravellerCubit.get(context).toggle == 2,
                          title: "booking.Completed",
                          onTap: () {
                            BookingTravellerCubit.get(context).toggleBooking(2);
                            controllerBooking.animateToPage(2,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                        ),
                        BookingTabButton(
                          isSelected:
                              BookingTravellerCubit.get(context).toggle == 3,
                          title: "booking.Cancelled",
                          onTap: () {
                            BookingTravellerCubit.get(context).toggleBooking(3);
                            controllerBooking.animateToPage(3,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                            if (state is BookingAgainSuccessful) {
                              BookingTravellerCubit.get(context).getAllBooking(
                                  state: "3", serviceName: "activities");
                            }
                          },
                        ),
                      ],
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
                    children: [
                      PendingActivity(),
                      UpcomingActivity(),
                      CompleteActivity(),
                      CancelActivity(),
                    ],
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
