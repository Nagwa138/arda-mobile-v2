import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit()
        ..getAllBooking(state: "2", serviceName: "accommodations"),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is getBookingLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Check if data is empty
          final bookingsCount =
              BookingTravellerCubit.get(context).complete?.data?.length ?? 0;
          if (bookingsCount == 0) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 80.sp,
                      color: Colors.grey[400]),
                    SizedBox(height: 20.h),
                    Text(
                      "No Completed Bookings",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700])),
                    SizedBox(height: 8.h),
                    Text(
                      "You haven't completed any bookings yet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[500])),
                  ])));
          }

          return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(BookingTravellerCubit.get(context)
                            .complete!
                            .data![index]
                            .id
                            .toString());
                        Navigator.pushNamed(context, "detailsBookingCompleted",
                            arguments: {
                              'completedId': BookingTravellerCubit.get(context)
                                  .complete!
                                  .data![index]
                                  .id
                                  .toString(),
                              'serviceesId': BookingTravellerCubit.get(context)
                                  .complete!
                                  .data![index]
                                  .serviceId
                                  .toString()
                            });
                      },
                      child: Container(
                        width: 400.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadiusDirectional.circular(25.r),
                            color: Colors.white54),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomImage(
                                        BookingTravellerCubit.get(context)
                                            .complete!
                                            .data![index]
                                            .image
                                            ?.toString(),
                                        width: 99.w,
                                        height: 107.h,
                                        fit: BoxFit.fill),
                                      SizedBox(
                                        width: 20.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 200.w,
                                            child: Text(
                                              BookingTravellerCubit.get(context)
                                                  .complete!
                                                  .data![index]
                                                  .serviceName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.w600))),
                                          SizedBox(
                                            height: 5.h),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  "assets/images/landingHome/location.png"),
                                              Text(
                                                BookingTravellerCubit.get(
                                                            context)
                                                        .complete!
                                                        .data![index]
                                                        .address
                                                        .toString() +
                                                    "   ",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color.fromRGBO(
                                                        140, 140, 140, 1),
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            ]),
                                          SizedBox(
                                            height: 5.h),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.date_range_outlined,
                                                color: orange,
                                                size: 18.sp),
                                              SizedBox(
                                                width: 130.w,
                                                child: Text(
                                                  BookingTravellerCubit.get(
                                                          context)
                                                      .complete!
                                                      .data![index]
                                                      .bookingDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color.fromRGBO(
                                                          140, 140, 140, 1),
                                                      fontWeight:
                                                          FontWeight.w400))),
                                            ]),
                                          SizedBox(
                                            height: 5.h),
                                          Row(
                                            children: [
                                              Text(
                                                BookingTravellerCubit.get(
                                                            context)
                                                        .complete!
                                                        .data![index]
                                                        .price
                                                        .toString() +
                                                    "booking.EGP".tr(),
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: orange,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                              SizedBox(
                                                width: 3.w),
                                              Text(
                                                "booking.Nigth".tr(),
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: accentColor,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            ]),
                                        ]),
                                    ]),
                                  SizedBox(
                                    height: 5.h),
                                  Divider(
                                    color: Color.fromRGBO(224, 224, 224, 1)),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                shape: WidgetStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10.0),
                                                        side: BorderSide(
                                                            color: orange))),
                                                foregroundColor:
                                                    WidgetStateProperty.all<Color>(
                                                        Colors.white),
                                                backgroundColor:
                                                    WidgetStateProperty.all<Color>(
                                                        white),
                                                elevation:
                                                    WidgetStateProperty.all<double>(0.0)),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, "reviewBooking",
                                                  arguments: {
                                                    'id': BookingTravellerCubit
                                                            .get(context)
                                                        .complete!
                                                        .data![index]
                                                        .serviceId
                                                        .toString(),
                                                    'name':
                                                        BookingTravellerCubit
                                                                .get(context)
                                                            .complete!
                                                            .data![index]
                                                            .serviceName
                                                            .toString(),
                                                    'image':
                                                        BookingTravellerCubit
                                                                .get(context)
                                                            .complete!
                                                            .data![index]
                                                            .image
                                                            .toString(),
                                                    'address':
                                                        BookingTravellerCubit
                                                                .get(context)
                                                            .complete!
                                                            .data![index]
                                                            .address
                                                            .toString()
                                                  });
                                            },
                                            child: Text(
                                              "booking.Review".tr(),
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.w600)))),
                                    ]),
                                  SizedBox(
                                    height: 10.h)
                                ])),
                          ]))),
                    SizedBox(
                      height: 10.h),
                  ]);
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 5.h),
              itemCount:
                  BookingTravellerCubit.get(context).complete!.data!.length);
        }));
  }
}
