import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';

class PendingActivity extends StatelessWidget {
  const PendingActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit()
        ..getAllBooking(state: "0", serviceName: "activities"),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is getBookingLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "detailsBookingActivity",
                            arguments: {
                              'pendingId': BookingTravellerCubit.get(context)
                                  .pendingActivity!
                                  .data![index]
                                  .id
                                  .toString(),
                              'state': BookingTravellerCubit.get(context)
                                  .pendingActivity!
                                  .data![index]
                                  .status
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
                                      Image.network(
                                        BookingTravellerCubit.get(context)
                                            .pendingActivity!
                                            .data![index]
                                            .image
                                            .toString(),
                                        width: 99.w,
                                        height: 107.h,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              BookingTravellerCubit.get(context)
                                                  .pendingActivity!
                                                  .data![index]
                                                  .activityName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            width: 150.w,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/landingHome/location.png",
                                                color: Color.fromRGBO(
                                                    0, 86, 79, 1),
                                              ),
                                              SizedBox(
                                                width: 90.w,
                                                child: Text(
                                                  "booking.Luxor".tr() + "   ",
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color.fromRGBO(
                                                          140, 140, 140, 1),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 90.w,
                                                child: Text(
                                                  "booking.Egypt".tr(),
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color.fromRGBO(
                                                          140, 140, 140, 1),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Text(
                                                BookingTravellerCubit.get(
                                                        context)
                                                    .pendingActivity!
                                                    .data![index]
                                                    .rate
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color.fromRGBO(
                                                        140, 140, 140, 1),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 16.sp,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                BookingTravellerCubit.get(
                                                            context)
                                                        .pendingActivity!
                                                        .data![index]
                                                        .price
                                                        .toString() +
                                                    "booking.EGP".tr(),
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color.fromRGBO(
                                                        0, 86, 79, 1),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                "booking.Nigth".tr(),
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color.fromRGBO(
                                                        0, 86, 79, 1),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(224, 224, 224, 1),
                                  ),
                                  Row(
                                    children: [
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
                                                            color:
                                                                accentColor))),
                                                foregroundColor:
                                                    WidgetStateProperty.all<Color>(
                                                        Colors.white),
                                                backgroundColor:
                                                    WidgetStateProperty.all<Color>(
                                                        white),
                                                elevation: WidgetStateProperty.all<double>(0.0)),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, "cancelReservation",
                                                  arguments: {
                                                    'id': BookingTravellerCubit
                                                            .get(context)
                                                        .pendingActivity!
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
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  )
                                ],
                              ),
                            ),
                          ],
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
                      .pendingActivity
                      ?.data!
                      .length ??
                  0);
        },
      ),
    );
  }
}
