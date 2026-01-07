import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmCancel extends StatelessWidget {
  const ConfirmCancel({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit(),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {
          if (state is CancelBookingSuccessful) {
            context.showCustomSnackBar(
              "Successful",
              type: SnackBarType.success,
            );
            if (state.data == "Activity") {
              Navigator.pushNamed(context, "bookingActivity");
            } else if (state.data == "Trip") {
              Navigator.pushNamed(context, "bookingTrips");
            } else if (state.data == "Accomodation") {
              // Navigator.pushNamed(context, "booking");
              BookingTravellerCubit.get(context)
                  .getAllBooking(state: "0", serviceName: "accommodations");
              BookingTravellerCubit.get(context)
                  .getAllBooking(state: "2", serviceName: "accommodations");
            }
          } else if (state is CancelBookingError) {
            context.showCustomSnackBar(
              state.error,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: appBackgroundColor,
              appBar: AppBar(),
              body:

                  ///
                  Padding(
                padding: EdgeInsets.only(right: 20.w, top: 10.h, left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("booking.cancel".tr(),
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(
                      height: 50.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/traveller/warining.png"),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("booking.Policy".tr(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: accentColor,
                                      fontWeight: FontWeight.w700,
                                    )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text("booking.refundable".tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: accentColor,
                                      fontWeight: FontWeight.w700,
                                    )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  width: 250.w,
                                  child: Text("booking.t2".tr(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
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
                    Spacer(),
                    SizedBox(
                      width: 327.w,
                      height: 55.h,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(color: accentColor))),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                WidgetStateProperty.all<Color>(accentColor),
                          ),
                          onPressed: () {
                            print(arguments['id']);
                            print(arguments['reasson']);

                            BookingTravellerCubit.get(context).cancelBooking(
                                id: arguments['id'],
                                reason: arguments['reasson']);
                          },
                          child: Text(
                            "booking.confirm".tr(),
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: white,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // SizedBox(
                    //   width: 327.w,
                    //   height: 55.h,
                    //   child: ElevatedButton(
                    //       style: ButtonStyle(
                    //           shape: MaterialStateProperty.all<
                    //                   RoundedRectangleBorder>(
                    //               RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(10.0),
                    //                   side: BorderSide(color: orange))),
                    //           foregroundColor:
                    //               MaterialStateProperty.all<Color>(Colors.white),
                    //           backgroundColor:
                    //               MaterialStateProperty.all<Color>(white),
                    //           elevation: MaterialStateProperty.all<double>(0.0)),
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //       child: Text(
                    //         "booking.keep".tr(),
                    //         style: TextStyle(
                    //             fontSize: 16.sp,
                    //             color: black,
                    //             fontWeight: FontWeight.w600),
                    //       )),
                    // ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
