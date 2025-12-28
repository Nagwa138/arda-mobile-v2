import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/activities/activities%20details/details.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/activities/activities%20details/details.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';

class DetailsPendingActivity extends StatelessWidget {
  const DetailsPendingActivity({super.key});
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit()
        ..getBookingDetails(id: arguments['pendingId']),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "booking.Details".tr(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: state is getBookingDetailsLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: accentColor,
                  ))
                : SingleChildScrollView(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 300.h,
                          child: Stack(
                            children: [
                              Image.network(
                                  BookingTravellerCubit.get(context)
                                      .activityModelDetails!
                                      .data!
                                      .image
                                      .toString(),
                                  width: double.infinity.w,
                                  height: 300.h,
                                  fit: BoxFit.cover),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20.h, right: 10.w, left: 10.w),
                                child: Container(
                                  width: 83.w,
                                  height: 43.h,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                              27.r),
                                      color: appBackgroundColor),
                                  child: Center(
                                    child: Text(
                                      BookingTravellerCubit.get(context)
                                          .activityModelDetails!
                                          .data!
                                          .serviceType
                                          .toString(),
                                      // "Services.hotels".tr(),

                                      style: TextStyle(
                                          color: accentColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 330.w, // Add width constraint
                                child: Text(
                                  BookingTravellerCubit.get(context)
                                      .activityModelDetails!
                                      .data!
                                      .title
                                      .toString(),
                                  // "Sonesta St. George Hotel - Convention.",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: true,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.star_rate_rounded,
                                color: Colors.amber,
                              ),
                              Text(
                                BookingTravellerCubit.get(context)
                                    .activityModelDetails!
                                    .data!
                                    .rate
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: accentColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Container(
                            width: 327.w,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(238, 238, 238, 1)),
                                borderRadius:
                                    BorderRadiusDirectional.circular(10.r)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 20.w, top: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  detailsBooking(
                                      title: "ProfileGuest.person",
                                      title2: BookingTravellerCubit.get(context)
                                          .activityModelDetails!
                                          .data!
                                          .noOfPersons
                                          .toString()),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  detailsBooking(
                                      title: "ProfileGuest.days",
                                      title2: BookingTravellerCubit.get(context)
                                          .activityModelDetails!
                                          .data!
                                          .daysCount
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          width: 327.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(238, 238, 238, 1)),
                              borderRadius:
                                  BorderRadiusDirectional.circular(20.r)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "${BookingTravellerCubit.get(context).activityModelDetails!.data!.noOfPersons.toString()}" +
                                          " " +
                                          "ProfileGuest.person".tr() +
                                          " /" +
                                          " person",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: accentColor,
                                          fontSize: 14.sp),
                                    ),
                                    Spacer(),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "${BookingTravellerCubit.get(context).activityModelDetails!.data!.pricePerPerson.toString()}" +
                                          "booking.EGP".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: accentColor,
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text("booking.IncludingTax".tr(),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    )),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "booking.Total".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: accentColor,
                                          fontSize: 14.sp),
                                    ),
                                    Spacer(),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "${BookingTravellerCubit.get(context).activityModelDetails!.data!.totalPrice.toString()} " +
                                          "booking.EGP".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: accentColor,
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        arguments['state'] == "Pending"
                            ? Column(
                                children: [
                                  Container(
                                    width: 327.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                20.r),
                                        color:
                                            Color.fromRGBO(249, 239, 233, 1)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.w, right: 20.w, top: 10.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                  "assets/images/traveller/warining.png"),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 230.w,
                                                    child: Text(
                                                        "booking.t1".tr(),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  SizedBox(
                                                    width: 250.w,
                                                    child: Text(
                                                        "booking.t2".tr(),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 327.w,
                                    height: 55.h,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    side: BorderSide(
                                                        color: orange))),
                                            foregroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    white),
                                            backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    appBackgroundColor),
                                            elevation:
                                                MaterialStateProperty.all<double>(0.0)),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "cancelReservation",
                                              arguments: {
                                                "id": BookingTravellerCubit.get(
                                                        context)
                                                    .activityModelDetails!
                                                    .data!
                                                    .id
                                                    .toString(),
                                              });
                                        },
                                        child: Text(
                                          "booking.CancelBooking".tr(),
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: accentColor,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              )
                            : arguments['state'] == "Upcoming"
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        child: SizedBox(
                                          height: 50.h,
                                          width: double.infinity,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        side: BorderSide(
                                                            color: orange))),
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(orange),
                                              ),
                                              onPressed: () {
                                                BookingTravellerCubit.get(
                                                        context)
                                                    .startPaymentActivity(
                                                        context: context,
                                                        id: BookingTravellerCubit
                                                                .get(context)
                                                            .activityModelDetails!
                                                            .data!
                                                            .id
                                                            .toString(),
                                                        amount: BookingTravellerCubit
                                                                .get(context)
                                                            .activityModelDetails!
                                                            .data!
                                                            .totalPrice);
                                              },
                                              child: Text(
                                                "booking.CompleteBooking".tr(),
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        width: 327.w,
                                        height: 55.h,
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
                                                        white),
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        white),
                                                elevation:
                                                    MaterialStateProperty.all<double>(0.0)),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, "cancelReservation",
                                                  arguments: {
                                                    "id": BookingTravellerCubit
                                                            .get(context)
                                                        .activityModelDetails!
                                                        .data!
                                                        .id
                                                        .toString(),
                                                  });
                                            },
                                            child: Text(
                                              "booking.CancelBooking".tr(),
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ),
                                    ],
                                  )
                                : arguments['state'] == "Completed"
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            width: 327.w,
                                            height: 55.h,
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
                                                            white),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(white),
                                                    elevation: MaterialStateProperty.all<double>(0.0)),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, "reviewBooking",
                                                      arguments: {
                                                        'id': BookingTravellerCubit
                                                                .get(context)
                                                            .activityModelDetails!
                                                            .data!
                                                            .id
                                                            .toString(),
                                                        'name': BookingTravellerCubit
                                                                .get(context)
                                                            .activityModelDetails!
                                                            .data!
                                                            .title
                                                            .toString(),
                                                        'image':
                                                            BookingTravellerCubit
                                                                    .get(
                                                                        context)
                                                                .activityModelDetails!
                                                                .data!
                                                                .image
                                                                .toString(),
                                                        'address': "Egypt",
                                                      });
                                                },
                                                child: Text(
                                                  "booking.Review".tr(),
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: accentColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                          ),
                                        ],
                                      )
                                    : SizedBox.shrink()
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}

Widget detailsBooking({required String title, required String title2}) {
  return Row(
    children: [
      Text(
        overflow: TextOverflow.ellipsis,
        title.tr(),
        style: TextStyle(
            fontWeight: FontWeight.w700, color: accentColor, fontSize: 16.sp),
      ),
      Spacer(),
      SizedBox(
        child: Text(
          overflow: TextOverflow.ellipsis,
          title2.tr(),
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(5, 10, 42, 1),
              fontSize: 16.sp),
        ),
      ),
    ],
  );
}
