import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customButton/customButton.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelActivity extends StatelessWidget {
  CancelActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit()
        ..getAllBooking(state: "3", serviceName: "activities"),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {
          if (state is BookingAgainSuccessful) {
            BookingTravellerCubit.get(context).toggleBooking(0);

            BookingTravellerCubit.get(context)
                .getAllBooking(state: "3", serviceName: "activities");
            BookingTravellerCubit.get(context)
                .getAllBooking(state: "0", serviceName: "activities");
            context.showCustomSnackBar(
              "Successful",
              type: SnackBarType.success,
            );
          } else if (state is BookingAgainError) {
            context.showCustomSnackBar(
              state.error,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is getBookingLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final bookingsCount =
              BookingTravellerCubit.get(context).cancelActivity?.data?.length ??
                  0;
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
                    Text("No Cancelled Activities",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700])),
                    SizedBox(height: 8.h),
                    Text("You don't have any cancelled activity bookings",
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
                    Container(
                      width: 400.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(25.r),
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
                                          .cancelActivity!
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
                                                .cancelActivity!
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
                                              color:
                                                  Color.fromRGBO(0, 86, 79, 1),
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
                                              BookingTravellerCubit.get(context)
                                                  .cancelActivity!
                                                  .data![index]
                                                  .rate
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color.fromRGBO(
                                                      140, 140, 140, 1),
                                                  fontWeight: FontWeight.w400),
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
                                              BookingTravellerCubit.get(context)
                                                      .cancelActivity!
                                                      .data![index]
                                                      .price
                                                      .toString() +
                                                  "booking.EGP".tr(),
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color.fromRGBO(
                                                      0, 86, 79, 1),
                                                  fontWeight: FontWeight.w400),
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
                                                  fontWeight: FontWeight.w600),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomButton(
                        height: 40.h,
                        function: () {
                          BookingTravellerCubit.get(context).bookAgainActivity(
                              id: BookingTravellerCubit.get(context)
                                  .cancelActivity!
                                  .data![index]
                                  .id
                                  .toString());
                        },
                        text: "booking.BookAgain".tr(),
                        width: 303.w),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 5.h,
                  ),
              itemCount: BookingTravellerCubit.get(context)
                      .cancelActivity
                      ?.data!
                      .length ??
                  0);
        },
      ),
    );
  }
}
