import 'package:PassPort/screens/traveller/booking/widgets/booking_tab_button.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:flutter/material.dart';

class BookingTabBar extends StatelessWidget {
  final PageController controller;
  final List<BookingTab> tabs;

  const BookingTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => BookingTabButton(
            isSelected: BookingTravellerCubit.get(context).toggle == index,
            title: tabs[index].title,
            onTap: () {
              BookingTravellerCubit.get(context).toggleBooking(index);
              controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ),
    );
  }
}

class BookingTab {
  final String title;
  final Widget page;

  BookingTab({
    required this.title,
    required this.page,
  });
}
