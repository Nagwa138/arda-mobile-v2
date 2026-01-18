import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/components/widgets/custom_lodaing_indicator.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewRoomDetailsBooking extends StatelessWidget {
  const ViewRoomDetailsBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(
        create: (BuildContext context) =>
            BookingTravellerCubit()..getRoomDetails(id: arguments['id']),
        child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: appBackgroundColor,
                  appBar: AppBar(
                      backgroundColor: appBackgroundColor,
                      title: Text("Booked room details")),
                  body: state is getRoomDetailsLoading
                      ? const CustomLodaingIndicator()
                      : ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 30.h),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: accentColor),
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                              20.r)),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 20.h),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: 200.h,
                                                child: ListView.separated(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder: (context, indexImage) => ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10.r),
                                                        child: CustomImage(
                                                            BookingTravellerCubit.get(context)
                                                                .getBookingRoomModelDetails!
                                                                .data![index]
                                                                .roomImages![
                                                                    indexImage]
                                                                .toString(),
                                                            width: 200.w,
                                                            fit: BoxFit.cover)),
                                                    separatorBuilder: (context,
                                                            index) =>
                                                        SizedBox(width: 10.w),
                                                    itemCount: BookingTravellerCubit.get(context).getBookingRoomModelDetails!.data![index].roomImages?.length ?? 0)),
                                            SizedBox(height: 10.h),
                                            Row(children: [
                                              Text("Room Number",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Spacer(),
                                              Text(
                                                  BookingTravellerCubit.get(
                                                          context)
                                                      .getBookingRoomModelDetails!
                                                      .data![index]
                                                      .roomNo
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: accentColor,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ]),
                                            SizedBox(height: 10.h),
                                            Row(children: [
                                              Text(
                                                  BookingTravellerCubit.get(
                                                          context)
                                                      .getBookingRoomModelDetails!
                                                      .data![index]
                                                      .roomType
                                                      .toString(),
                                                  //'addService.2.single'.tr(),
                                                  style: TextStyle(
                                                      color: accentColor,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Spacer(),
                                              Text("availableRooms.for".tr(),
                                                  style: TextStyle(
                                                      color: accentColor,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              SizedBox(width: 5.w),
                                              Icon(Icons.person)
                                            ]),
                                            SizedBox(height: 10.h),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text.rich(
                                                      textAlign:
                                                          TextAlign.start,
                                                      TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                '${BookingTravellerCubit.get(context).getBookingRoomModelDetails!.data![index].price.toString()} ${'currency'.tr()} /',
                                                            style: TextStyle(
                                                                color:
                                                                    accentColor,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                        TextSpan(
                                                            text:
                                                                'addService.3.night'
                                                                    .tr(),
                                                            style: TextStyle(
                                                                color:
                                                                    accentColor,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                      ])),
                                                ]),
                                            SizedBox(height: 10.h),
                                            Row(children: [
                                              Text('availableRooms.total'.tr(),
                                                  style: TextStyle(
                                                      color: accentColor,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              Spacer(),
                                              Text(
                                                  BookingTravellerCubit.get(
                                                              context)
                                                          .calculateTotalPrice(
                                                              BookingTravellerCubit
                                                                      .get(
                                                                          context)
                                                                  .getBookingRoomModelDetails!
                                                                  .data![index]
                                                                  .price,
                                                              arguments[
                                                                  'night']) +
                                                      'currency'.tr(),
                                                  style: TextStyle(
                                                      color: accentColor,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ]),
                                            SizedBox(height: 10.h),
                                            BookingTravellerCubit.get(context)
                                                        .getBookingRoomModelDetails!
                                                        .data![index]
                                                        .priceIncludeBreakFast ==
                                                    true
                                                ? Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        "IncludeBreakFast",
                                                        style: TextStyle(
                                                            color: accentColor,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)))
                                                : SizedBox.shrink()
                                          ])))),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20.h),
                          itemCount: BookingTravellerCubit.get(context)
                              .getBookingRoomModelDetails!
                              .data!
                              .length));
            }));
  }
}
