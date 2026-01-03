import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelReservation extends StatelessWidget {
  CancelReservation({super.key});

  final String? question = null;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit(),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: appBackgroundColor,
              appBar: AppBar(),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("booking.cancel".tr(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(height: 30.0),
                    Text("booking.whyCancel".tr(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("booking.answer1".tr(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                      value: BookingTravellerCubit.get(context).cancelReason[0],
                      groupValue: BookingTravellerCubit.get(context).cancelre,
                      onChanged: (value) {
                        BookingTravellerCubit.get(context).cancelre =
                            value.toString();
                        BookingTravellerCubit.get(context)
                            .replaceCancelReason(value);
                        print(BookingTravellerCubit.get(context).cancelre);
                      },
                    ),
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("booking.answer2".tr(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                      value: BookingTravellerCubit.get(context).cancelReason[1],
                      groupValue: BookingTravellerCubit.get(context).cancelre,
                      onChanged: (value) {
                        BookingTravellerCubit.get(context).cancelre =
                            value.toString();
                        BookingTravellerCubit.get(context)
                            .replaceCancelReason(value);
                        print(BookingTravellerCubit.get(context).cancelre);
                      },
                    ),
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("booking.answer3".tr(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                      value: BookingTravellerCubit.get(context).cancelReason[2],
                      groupValue: BookingTravellerCubit.get(context).cancelre,
                      onChanged: (value) {
                        BookingTravellerCubit.get(context).cancelre =
                            value.toString();
                        BookingTravellerCubit.get(context)
                            .replaceCancelReason(value);
                        print(BookingTravellerCubit.get(context).cancelre);
                      },
                    ),
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("booking.answer4".tr(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                      value: BookingTravellerCubit.get(context).cancelReason[3],
                      groupValue: BookingTravellerCubit.get(context).cancelre,
                      onChanged: (value) {
                        BookingTravellerCubit.get(context).cancelre =
                            value.toString();
                        BookingTravellerCubit.get(context)
                            .replaceCancelReason(value);
                        print(BookingTravellerCubit.get(context).cancelre);
                      },
                    ),
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("booking.answer5".tr(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                      value: BookingTravellerCubit.get(context).cancelReason[4],
                      groupValue: BookingTravellerCubit.get(context).cancelre,
                      onChanged: (value) {
                        BookingTravellerCubit.get(context).cancelre =
                            value.toString();
                        BookingTravellerCubit.get(context)
                            .replaceCancelReason(value);
                        print(BookingTravellerCubit.get(context).cancelre);
                      },
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
                            print(BookingTravellerCubit.get(context).cancelre);
                            Navigator.pushNamed(
                                context, "confirmCancel", arguments: {
                              "id": arguments['id'],
                              'reasson':
                                  BookingTravellerCubit.get(context).cancelre
                            });
                          },
                          child: Text(
                            "booking.Continue".tr(),
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: white,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
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
