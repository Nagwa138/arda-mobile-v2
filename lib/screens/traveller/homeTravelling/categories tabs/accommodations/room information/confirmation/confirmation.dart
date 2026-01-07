import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit(),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {
          if (state is CreateBookingRoomSuccessful) {
            Navigator.pushNamed(context, 'pending', arguments: {
              "single": arguments['Guset'],
              "date": arguments['date']
            });
            context.showCustomSnackBar(
              "Successful",
              type: SnackBarType.success,
            );
          } else if (state is CreateBookingRoomError) {
            context.showCustomSnackBar(
              state.error,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "confirmation.title".tr(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.calendar_month,
                    color: accentColor,
                    size: 36.sp,
                  ),
                  title: Text(
                    'confirmation.t1'.tr(),
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text(
                      'confirmation.sub1'.tr(),
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.report_problem_sharp,
                    color: accentColor,
                    size: 36.sp,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'roomInfo.title6'.tr(),
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'roomInfo.subtitle6-1'.tr(),
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'roomInfo.subtitle6-2'.tr(),
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          side: BorderSide(
                            color: accentColor,
                          ),
                        ),
                        leading: Icon(
                          Icons.info,
                          color: accentColor,
                        ),
                        title: Text(
                          'roomInfo.title7'.tr(),
                          style: TextStyle(
                            color: black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Text(
                              'roomInfo.subtitle7-1'.tr(),
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'roomInfo.subtitle7-2'.tr(),
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Container(
                height: 50.h,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(orange),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    print("phone ${arguments['phone']}");
                    print("specialRequests ${arguments['specialRequests']}");
                    print("date ${arguments['date']}");
                    print("endDate ${arguments['endDate']}");
                    print("Adult ${arguments['Adult']}");
                    print("child ${arguments['child']}");
                    print("roomId ${arguments['roomId']}");
                    print("nationalityType ${arguments['nationalityType']}");
                    print("night ${arguments['night']}");
                    print(arguments['night'].runtimeType);
                    BookingTravellerCubit.get(context).bookRoom(
                      context: context,
                        start: arguments['date'],
                        end: arguments['endDate'],
                        phone: arguments['phone'],
                        specialRequests: arguments['specialRequests'],
                        numberOfAdult: arguments['Adult'],
                        numberOfChildern: arguments['child'],
                        nationalityType: arguments['nationalityType'],
                        room: arguments['roomId']);

                    // print("object");
                  },
                  child: Text(
                    "booking.Continue".tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
