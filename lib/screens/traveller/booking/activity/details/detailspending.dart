import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: state is getBookingDetailsLoading
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
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
                                  width: double.infinity.w,
                                  height: 300.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.error,
                                      size: 100.sp,
                                      color: Colors.grey[400],
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.h, right: 10.w, left: 10.w),
                                  child: Container(
                                    width: 83.w,
                                    height: 43.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10.r),
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
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: lightBrown.withValues(alpha: 0.3)),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: lightBrown.withValues(alpha: 0.1),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24.w, vertical: 20.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    detailsBooking(
                                        title: "ProfileGuest.person",
                                        title2:
                                            BookingTravellerCubit.get(context)
                                                .activityModelDetails!
                                                .data!
                                                .noOfPersons
                                                .toString()),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      child: Divider(
                                        color:
                                            lightBrown.withValues(alpha: 0.3),
                                        thickness: 1,
                                      ),
                                    ),
                                    detailsBooking(
                                        title: "ProfileGuest.days",
                                        title2:
                                            BookingTravellerCubit.get(context)
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: lightBrown.withValues(alpha: 0.3)),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: lightBrown.withValues(alpha: 0.1),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24.w, vertical: 20.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      child: Divider(
                                        color:
                                            lightBrown.withValues(alpha: 0.3),
                                        thickness: 1,
                                      ),
                                    ),
                                    Text("booking.IncludingTax".tr(),
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          color: lightText,
                                        )),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      child: Divider(
                                        color:
                                            lightBrown.withValues(alpha: 0.3),
                                        thickness: 1,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "booking.Total".tr(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: accentColor,
                                              fontSize: 16.sp),
                                        ),
                                        Spacer(),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "${BookingTravellerCubit.get(context).activityModelDetails!.data!.totalPrice.toString()} " +
                                              "booking.EGP".tr(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: lightBrown,
                                              fontSize: 16.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                                                      white),
                                              backgroundColor:
                                                  WidgetStateProperty.all<Color>(
                                                      appBackgroundColor),
                                              elevation:
                                                  WidgetStateProperty.all<double>(0.0)),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "cancelReservation",
                                                arguments: {
                                                  "id":
                                                      BookingTravellerCubit.get(
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
                                                  shape: WidgetStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          side: BorderSide(
                                                              color: orange))),
                                                  foregroundColor:
                                                      WidgetStateProperty.all<
                                                          Color>(Colors.white),
                                                  backgroundColor:
                                                      WidgetStateProperty.all<
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
                                                  "booking.CompleteBooking"
                                                      .tr(),
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
                                                          white),
                                                  backgroundColor:
                                                      WidgetStateProperty.all<Color>(
                                                          white),
                                                  elevation:
                                                      WidgetStateProperty.all<double>(0.0)),
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    "cancelReservation",
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                              white),
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(white),
                                                      elevation: WidgetStateProperty.all<double>(0.0)),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        "reviewBooking",
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
                                                          'image': BookingTravellerCubit
                                                                  .get(context)
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
