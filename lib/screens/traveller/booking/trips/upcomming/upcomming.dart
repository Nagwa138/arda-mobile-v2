import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcomingTrips extends StatelessWidget {
  const UpcomingTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit()
        ..getAllBooking(state: "1", serviceName: "trips"),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is getBookingLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final bookingsCount =
              BookingTravellerCubit.get(context).upComingTrips?.data?.length ??
                  0;
          if (bookingsCount == 0) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upcoming_outlined,
                        size: 80.sp, color: Colors.grey[400]),
                    SizedBox(height: 20.h),
                    Text("No Upcoming Trips",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700])),
                    SizedBox(height: 8.h),
                    Text("You don't have any upcoming trip bookings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.sp, color: Colors.grey[500])),
                  ],
                ),
              ),
            );
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
                            .upComingTrips!
                            .data![index]
                            .status
                            .toString());
                        Navigator.pushNamed(context, "bookingDetailsTrips",
                            arguments: {
                              'pendingId': BookingTravellerCubit.get(context)
                                  .upComingTrips!
                                  .data![index]
                                  .id
                                  .toString(),
                              'state': BookingTravellerCubit.get(context)
                                  .upComingTrips!
                                  .data![index]
                                  .status
                                  .toString()
                            });
                      },
                      child: Container(
                        width: 370.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20.r),
                          color: Colors.white54,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  BookingTravellerCubit.get(context)
                                      .upComingTrips!
                                      .data![index]
                                      .tripName
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: accentColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                width: 150.w,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/landingHome/location.png",
                                    color: orange,
                                  ),
                                  SizedBox(
                                    width: 90.w,
                                    child: Text(
                                      "${BookingTravellerCubit.get(context).upComingTrips!.data![index].from.toString()}" +
                                          "   ",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color:
                                              Color.fromRGBO(140, 140, 140, 1),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90.w,
                                    child: Text(
                                      "To",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color:
                                              Color.fromRGBO(140, 140, 140, 1),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/landingHome/location.png",
                                    color: orange,
                                  ),
                                  SizedBox(
                                    width: 90.w,
                                    child: Text(
                                      "${BookingTravellerCubit.get(context).upComingTrips!.data![index].to.toString()}" +
                                          "   ",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color:
                                              Color.fromRGBO(140, 140, 140, 1),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                          "assets/images/traveller/time.png",
                                          color: orange),
                                      SizedBox(width: 10.w),
                                      Text(
                                          BookingTravellerCubit.get(context)
                                              .upComingTrips!
                                              .data![index]
                                              .startDate
                                              .toString(),
                                          //"5:00 am",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  140, 140, 140, 1)))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/traveller/time.png",
                                        color: orange,
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                          BookingTravellerCubit.get(context)
                                              .upComingTrips!
                                              .data![index]
                                              .endDate
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  140, 140, 140, 1)))
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      BookingTravellerCubit.get(context)
                                              .upComingTrips!
                                              .data![index]
                                              .price
                                              .toString() +
                                          " " +
                                          "booking.EGP".tr() +
                                          " / " +
                                          "person",
                                      //"5:00 am",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: accentColor)),
                                  Text(
                                      BookingTravellerCubit.get(context)
                                          .upComingTrips!
                                          .data![index]
                                          .serviceType
                                          .toString(),
                                      //"5:00 am",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: accentColor)),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
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
                                                context, "cancelReservation",
                                                arguments: {
                                                  'id':
                                                      BookingTravellerCubit.get(
                                                              context)
                                                          .upComingTrips!
                                                          .data![index]
                                                          .id
                                                          .toString()
                                                });
                                          },
                                          child: Text(
                                            "booking.CancelBooking".tr(),
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: accentColor,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  side: BorderSide(
                                                      color: accentColor))),
                                          foregroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  accentColor),
                                        ),
                                        onPressed: () async {
                                          //BookingTravellerCubit.get(context).addProfitTrips(bookingId: BookingTravellerCubit.get(context).upComingTrips!.data![index].id.toString(), amount: 23.5);
                                          BookingTravellerCubit.get(context)
                                              .startPayment(
                                                  context: context,
                                                  id: BookingTravellerCubit.get(
                                                          context)
                                                      .upComingTrips!
                                                      .data![index]
                                                      .id
                                                      .toString(),
                                                  amount:
                                                      BookingTravellerCubit.get(
                                                              context)
                                                          .upComingTrips!
                                                          .data![index]
                                                          .price
                                                          .toDouble());
                                        },
                                        child: Text(
                                          "booking.CompleteBooking".tr(),
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: white,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 5.h,
                  ),
              itemCount: BookingTravellerCubit.get(context)
                      .upComingTrips
                      ?.data!
                      .length ??
                  0);
        },
      ),
    );
  }
}
