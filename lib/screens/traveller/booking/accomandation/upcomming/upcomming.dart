import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpComing extends StatelessWidget {
  const UpComing({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit()
        ..getAllBooking(state: "1", serviceName: "accommodations"),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          if (state is getBookingLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Check if data is empty
          final bookingsCount =
              BookingTravellerCubit.get(context).upComing?.data?.length ?? 0;
          if (bookingsCount == 0) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upcoming_outlined,
                      size: 80.sp,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "No Upcoming Bookings",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "You don't have any upcoming bookings",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[500],
                      ),
                    ),
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
                        Navigator.pushNamed(context, "detailsBookingUpComing",
                            arguments: {
                              'upComingId': BookingTravellerCubit.get(context)
                                  .upComing!
                                  .data?[index]
                                  .id
                                  .toString(),
                              'wantedPrice': BookingTravellerCubit.get(context)
                                  .upComing!
                                  .data?[index]
                                  .wantedPrice
                            }
                            //'id' : BookingTravellerCubit.get(context).getBookingModel!.data?[index].id.toString()
                            );
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
                              child: Row(
                                children: [
                                  Image.network(
                                    BookingTravellerCubit.get(context)
                                            .upComing
                                            ?.data?[index]
                                            .image
                                            ?.toString() ??
                                        "N/M",
                                    width: 99.w,
                                    height: 107.h,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          BookingTravellerCubit.get(context)
                                              .upComing!
                                              .data![index]
                                              .serviceName
                                              .toString(),
                                          //BookingTravellerCubit.get(context).getBookingModel!.data![index].serviceName.toString(),
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: accentColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                              "assets/images/landingHome/location.png"),
                                          SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              BookingTravellerCubit.get(context)
                                                  .upComing!
                                                  .data![index]
                                                  .address
                                                  .toString(),
                                              //BookingTravellerCubit.get(context).getBookingModel!.data![index].address.toString() + "   ",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color.fromRGBO(
                                                      140, 140, 140, 1),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              BookingTravellerCubit.get(context)
                                                  .upComing!
                                                  .data![index]
                                                  .address
                                                  .toString(),
                                              //BookingTravellerCubit.get(context).getBookingModel!.data![index].address.toString(),
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color.fromRGBO(
                                                      140, 140, 140, 1),
                                                  fontWeight: FontWeight.w400),
                                            ),
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
                                              //formatDuration(BookingTravellerCubit.get(context).getBookingModel!.data![index].bookingDate.toString())
                                              BookingTravellerCubit.get(context)
                                                  .upComing!
                                                  .data![index]
                                                  .bookingDate
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color.fromRGBO(
                                                      140, 140, 140, 1),
                                                  fontWeight: FontWeight.w400),
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
                                            BookingTravellerCubit.get(context)
                                                .upComing!
                                                .data![index]
                                                .price
                                                .toString(),
                                            //BookingTravellerCubit.get(context).getBookingModel!.data![index].price.toString() + "booking.EGP".tr() ,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: accentColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(
                                            " / " + "booking.Nigth".tr(),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: accentColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: SizedBox(
                                      width: double.infinity,
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
                                                      appBackgroundColor),
                                              backgroundColor:
                                                  WidgetStateProperty.all<Color>(
                                                      appBackgroundColor),
                                              elevation:
                                                  WidgetStateProperty.all<double>(0.0)),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "cancelReservation",
                                                arguments: {
                                                  'id':
                                                      BookingTravellerCubit.get(
                                                              context)
                                                          .upComing
                                                          ?.data![index]
                                                          .id
                                                          .toString()
                                                });
                                          },
                                          child: Text(
                                            "booking.cancel".tr(),
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: accentColor,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.h),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 50.h,
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
                                          onPressed: () {
                                            BookingTravellerCubit.get(context)
                                                .startPaymentAccomandtion(
                                                    context: context,
                                                    id: BookingTravellerCubit
                                                            .get(context)
                                                        .upComing!
                                                        .data![index]
                                                        .id
                                                        .toString(),
                                                    amount:
                                                        BookingTravellerCubit
                                                                .get(context)
                                                            .upComing!
                                                            .data![index]
                                                            .wantedPrice);
                                          },
                                          child: Text(
                                            "booking.CompleteBooking".tr(),
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: white,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
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
                  BookingTravellerCubit.get(context).upComing!.data!.length);
        },
      ),
    );
  }
}
