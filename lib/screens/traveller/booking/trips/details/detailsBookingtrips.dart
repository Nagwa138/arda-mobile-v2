import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';

class DetailsBookingTrips extends StatelessWidget {
  const DetailsBookingTrips({super.key});
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
                    color: black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
              ),
              body: state is getBookingDetailsLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: orange,
                    ))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                "${BookingTravellerCubit.get(context).tripsDetailsModel?.data?.image.toString()}",
                                width: double.infinity,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: double.infinity,
                                    height: 200.h,
                                    color: Colors.grey[300],
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.broken_image,
                                          color: Colors.grey[600],
                                          size: 50.sp,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          "Image not available",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                  (BookingTravellerCubit.get(context)
                                          .tripsDetailsModel
                                          ?.data
                                          ?.tripName
                                          ?.toString()) ??
                                      'N/A',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: white,
                                    fontWeight: FontWeight.w700,
                                  ))
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            width: 380.w,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(238, 238, 238, 1)),
                                borderRadius:
                                    BorderRadiusDirectional.circular(20.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("trips.From".tr(),
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: Color.fromRGBO(
                                                      140, 140, 140, 1),
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                  (BookingTravellerCubit.get(
                                                              context)
                                                          .tripsDetailsModel
                                                          ?.data
                                                          ?.from
                                                          ?.toString()) ??
                                                      'N/A',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color.fromRGBO(
                                                          19, 10, 3, 1),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                  textAlign: TextAlign.start,
                                                  (BookingTravellerCubit.get(
                                                              context)
                                                          .tripsDetailsModel
                                                          ?.data
                                                          ?.startDate
                                                          ?.toString()) ??
                                                      'N/A',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Image.asset(
                                            "assets/images/traveller/loadtrips.png"),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("trips.To".tr(),
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: Color.fromRGBO(
                                                      140, 140, 140, 1),
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                  (BookingTravellerCubit.get(
                                                              context)
                                                          .tripsDetailsModel
                                                          ?.data
                                                          ?.to
                                                          ?.toString()) ??
                                                      'N/A',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                  (BookingTravellerCubit.get(
                                                              context)
                                                          .tripsDetailsModel
                                                          ?.data
                                                          ?.endDate
                                                          ?.toString()) ??
                                                      'N/A',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            width: 380.w,
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
                                        "${BookingTravellerCubit.get(context).tripsDetailsModel?.data?.noOfPersons?.toString() ?? '0'}" +
                                            " " +
                                            "ProfileGuest.person".tr() +
                                            " /" +
                                            " person",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: black,
                                            fontSize: 16.sp),
                                      ),
                                      Spacer(),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        "${BookingTravellerCubit.get(context).tripsDetailsModel?.data?.pricePerPersone?.toString() ?? '0'}" +
                                            "booking.EGP".tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: orange,
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text("booking.IncludingTax".tr(),
                                      style: TextStyle(
                                        fontSize: 16,
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
                                            color: black,
                                            fontSize: 16.sp),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          print(arguments['state']);
                                        },
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          "${BookingTravellerCubit.get(context).tripsDetailsModel?.data?.totalPrice?.toString() ?? '0'} " +
                                              "booking.EGP".tr(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: orange,
                                              fontSize: 16.sp),
                                        ),
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
                          SizedBox(height: 20.h),
                          arguments['state'] == "Pending"
                              ? Column(
                                  children: [
                                    Container(
                                      width: 380.w,
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
                                      width: 380.w,
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
                                                      white),
                                              elevation:
                                                  MaterialStateProperty.all<double>(0.0)),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "cancelReservation",
                                                arguments: {
                                                  "id":
                                                      BookingTravellerCubit.get(
                                                                  context)
                                                              .tripsDetailsModel
                                                              ?.data
                                                              ?.id
                                                              ?.toString() ??
                                                          '',
                                                });
                                          },
                                          child: Text(
                                            "booking.CancelBooking".tr(),
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: black,
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
                                              horizontal: 10.w),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 60.h,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              side: BorderSide(
                                                                  color:
                                                                      orange))),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(orange),
                                                ),
                                                onPressed: () async {
                                                  //BookingTravellerCubit.get(context).addProfit(bookingId: BookingTravellerCubit.get(context).pendingTrips!.data![index].id.toString(), amount: 23.5);
                                                  BookingTravellerCubit.get(context).startPayment(
                                                      context: context,
                                                      id: BookingTravellerCubit
                                                                  .get(context)
                                                              .tripsDetailsModel
                                                              ?.data
                                                              ?.id
                                                              ?.toString() ??
                                                          '',
                                                      amount: BookingTravellerCubit
                                                                  .get(context)
                                                              .tripsDetailsModel
                                                              ?.data
                                                              ?.totalPrice ??
                                                          0);
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
                                          height: 20.h,
                                        ),
                                        SizedBox(
                                          width: 380.w,
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
                                                          white),
                                                  elevation:
                                                      MaterialStateProperty.all<double>(0.0)),
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    "cancelReservation",
                                                    arguments: {
                                                      "id": BookingTravellerCubit
                                                                  .get(context)
                                                              .tripsDetailsModel
                                                              ?.data
                                                              ?.id
                                                              ?.toString() ??
                                                          '',
                                                    });
                                              },
                                              child: Text(
                                                "booking.CancelBooking".tr(),
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ],
                                    )
                                  : arguments['state'] == "Completed"
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              width: 380.w,
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
                                                                      orange))),
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.white),
                                                      backgroundColor:
                                                          MaterialStateProperty.all<Color>(white),
                                                      elevation: MaterialStateProperty.all<double>(0.0)),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        "reviewBooking",
                                                        arguments: {
                                                          "id": BookingTravellerCubit
                                                                      .get(
                                                                          context)
                                                                  .tripsDetailsModel
                                                                  ?.data
                                                                  ?.id
                                                                  ?.toString() ??
                                                              '',
                                                          'name': BookingTravellerCubit
                                                                      .get(
                                                                          context)
                                                                  .tripsDetailsModel
                                                                  ?.data
                                                                  ?.tripName
                                                                  ?.toString() ??
                                                              'N/A',
                                                          'image': BookingTravellerCubit
                                                                      .get(
                                                                          context)
                                                                  .tripsDetailsModel
                                                                  ?.data
                                                                  ?.image
                                                                  ?.toString() ??
                                                              '',
                                                          'address': "Place"
                                                        });
                                                  },
                                                  child: Text(
                                                    "booking.Review".tr(),
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: orange,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink()
                        ],
                      ),
                    ));
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
            fontWeight: FontWeight.w700, color: black, fontSize: 16.sp),
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
