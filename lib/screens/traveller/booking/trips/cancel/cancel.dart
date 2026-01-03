import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customButton/customButton.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CancelTrips extends StatelessWidget {
  const CancelTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit()
        ..getAllBooking(state: "3", serviceName: "trips"),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {
          if (state is BookingAgainTripsSuccessful) {
            BookingTravellerCubit.get(context).toggleBooking(0);

            BookingTravellerCubit.get(context)
                .getAllBooking(state: "3", serviceName: "trips");
            BookingTravellerCubit.get(context)
                .getAllBooking(state: "0", serviceName: "trips");
            Fluttertoast.showToast(
                msg: "Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is BookingAgainTripsError) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          if (state is getBookingLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final bookingsCount =
              BookingTravellerCubit.get(context).cancelTrips?.data?.length ?? 0;
          if (bookingsCount == 0) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cancel_outlined,
                        size: 80.sp, color: Colors.grey[400]),
                    SizedBox(height: 20.h),
                    Text("No Cancelled Trips",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700])),
                    SizedBox(height: 8.h),
                    Text("You don't have any cancelled trip bookings",
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
                            .cancelTrips!
                            .data![index]
                            .status
                            .toString());
                        Navigator.pushNamed(context, "bookingDetailsTrips",
                            arguments: {
                              'pendingId': BookingTravellerCubit.get(context)
                                  .cancelTrips!
                                  .data![index]
                                  .id
                                  .toString(),
                              'state': BookingTravellerCubit.get(context)
                                  .cancelTrips!
                                  .data![index]
                                  .status
                                  .toString()
                            });
                      },
                      child: Container(
                        width: 370.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadiusDirectional.circular(20.r),
                            color: Colors.white54),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  BookingTravellerCubit.get(context)
                                      .cancelTrips!
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
                                      "${BookingTravellerCubit.get(context).cancelTrips!.data![index].from.toString()}" +
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
                                      "${BookingTravellerCubit.get(context).cancelTrips!.data![index].to.toString()}" +
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
                                              .cancelTrips!
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
                                              .cancelTrips!
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
                                              .cancelTrips!
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
                                          .cancelTrips!
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
                              CustomButton(
                                  height: 40.h,
                                  function: () {
                                    BookingTravellerCubit.get(context)
                                        .bookAgainTrips(
                                            id: BookingTravellerCubit.get(
                                                    context)
                                                .cancelTrips!
                                                .data![index]
                                                .id
                                                .toString());
                                  },
                                  text: "booking.BookAgain".tr(),
                                  width: 303.w),
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
                      .cancelTrips
                      ?.data!
                      .length ??
                  0);
        },
      ),
    );
  }
}
