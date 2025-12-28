import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';

class Pending extends StatelessWidget {
  const Pending({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit()
        ..getAllBooking(state: "0", serviceName: "accommodations"),
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
                        Navigator.pushNamed(context, "detailsBookingPending",
                            arguments: {
                              'pendingId': BookingTravellerCubit.get(context)
                                  .pending!
                                  .data![index]
                                  .id
                            });
                      },
                      child: Container(
                        width: 327.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadiusDirectional.circular(25.r),
                            color: appBackgroundColor),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        BookingTravellerCubit.get(context)
                                                .pending
                                                ?.data?[index]
                                                ?.image
                                                .toString() ??
                                            "N/M",
                                        width: 70.w,
                                        height: 107.h,
                                        fit: BoxFit.cover,
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
                                                  .pending!
                                                  .data![index]
                                                  .serviceName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: black,
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
                                                  "assets/images/landingHome/location.png"),
                                              Text(
                                                BookingTravellerCubit.get(
                                                            context)
                                                        .pending!
                                                        .data![index]
                                                        .address
                                                        .toString() +
                                                    "   ",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color.fromRGBO(
                                                        140, 140, 140, 1),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "booking.Egypt".tr(),
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color.fromRGBO(
                                                        140, 140, 140, 1),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.date_range_outlined,
                                                color: accentColor,
                                                size: 18.sp,
                                              ),
                                              SizedBox(
                                                width: 130.w,
                                                child: Text(
                                                  BookingTravellerCubit.get(
                                                          context)
                                                      .pending!
                                                      .data![index]
                                                      .bookingDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color.fromRGBO(
                                                          140, 140, 140, 1),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                BookingTravellerCubit.get(
                                                            context)
                                                        .pending!
                                                        .data![index]
                                                        .price
                                                        .toString() +
                                                    "booking.EGP".tr(),
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: accentColor,
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
                                                    color: black,
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
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10.0),
                                                        side: BorderSide(
                                                            color:
                                                                accentColor))),
                                                foregroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        Colors.white),
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        white),
                                                elevation: MaterialStateProperty.all<double>(0.0)),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, "cancelReservation",
                                                  arguments: {
                                                    'id': BookingTravellerCubit
                                                            .get(context)
                                                        .pending!
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
              itemCount:
                  BookingTravellerCubit.get(context).pending?.data!.length ??
                      0);
        },
      ),
    );
  }
}
