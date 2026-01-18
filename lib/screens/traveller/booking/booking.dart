import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/traveller/booking/widgets/booking_app_bar.dart';
import 'package:PassPort/screens/traveller/booking/widgets/booking_tab_bar.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'accomandation/cancelled/cancelled.dart';
import 'accomandation/complete/completed.dart';
import 'accomandation/pending/pending.dart';
import 'accomandation/upcomming/upcomming.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controllerBooking = PageController();

    final List<BookingTab> tabs = [
      BookingTab(title: "booking.Pending", page: Pending()),
      BookingTab(title: "booking.Upcoming", page: UpComing()),
      BookingTab(title: "booking.Completed", page: Completed()),
      BookingTab(title: "booking.Cancelled", page: Cancelled()),
    ];

    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit(),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: const BookingAppBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingTabBar(
                  controller: controllerBooking,
                  tabs: tabs,
                ),
                Divider(
                  color: const Color(0xFFD9D9D9),
                  height: 1,
                ),
                Expanded(
                  child: ExpandablePageView(
                    controller: controllerBooking,
                    physics: const NeverScrollableScrollPhysics(),
                    children: tabs.map((tab) => tab.page).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
