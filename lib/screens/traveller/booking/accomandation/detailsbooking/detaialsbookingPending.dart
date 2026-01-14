import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBookingPending extends StatelessWidget {
  const DetailsBookingPending({super.key});
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
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: GestureDetector(
                onTap: () {
                  print(arguments['pendingId']);
                },
                child: Text(
                  "booking.Details".tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600)))),
            body: state is getBookingDetailsLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: accentColor))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 300.h,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: BookingTravellerCubit.get(context)
                                  .accomandationDetailsModel!
                                  .data!
                                  .roomImages
                                  ?.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Stack(
                                    children: [
                                      CustomImage(
                                          BookingTravellerCubit.get(context)
                                              .accomandationDetailsModel!
                                              .data!
                                              .roomImages![index],
                                          width: 250.w,
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
                                                  BorderRadiusDirectional
                                                      .circular(27.r),
                                              color: white),
                                          child: Center(
                                            child: Text(
                                              BookingTravellerCubit.get(context)
                                                  .accomandationDetailsModel!
                                                  .data!
                                                  .accomodationType
                                                  .toString(),
                                              // "Services.hotels".tr(),

                                              style: TextStyle(
                                                  color: accentColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700),
                                              overflow: TextOverflow.ellipsis)))),
                                      Positioned(
                                        bottom: 5,
                                        right: 2,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 20.h,
                                              right: 10.w,
                                              left: 10.w),
                                          child: Container(
                                            width: 45.w,
                                            height: 33.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(27.r),
                                                color: white),
                                            child: Center(
                                              child: Text(
                                                "${index + 1}/${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.roomImages?.length}",
                                                style: TextStyle(
                                                    color: accentColor,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w700))))))
                                    ]))),
                        SizedBox(
                          height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                              BookingTravellerCubit.get(context)
                                  .accomandationDetailsModel!
                                  .data!
                                  .serviceName
                                  .toString(),
                              // "Sonesta St. George Hotel - Convention.",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600))),
                        SizedBox(
                          height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            children: [
                              Image.asset(
                                  "assets/images/landingHome/location.png"),
                              SizedBox(
                                width: 5),
                              Text(
                                "${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.location}",
                                // "booking.Luxor".tr() + "   ",

                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color.fromRGBO(140, 140, 140, 1),
                                    fontWeight: FontWeight.w400)),
                              SizedBox(
                                width: 20.w),
                              Text(
                                "booking.Egypt".tr(),
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color.fromRGBO(140, 140, 140, 1),
                                    fontWeight: FontWeight.w400)),
                              Spacer(),
                              Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 20.sp),
                              Text(
                                "${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.rate}",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: accentColor,
                                  fontWeight: FontWeight.w500)),
                            ])),
                        SizedBox(
                          height: 10.h),
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
                                // Text("booking.HostDetails".tr(),
                                //     style: TextStyle(
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.w600,
                                //     )),
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                // Row(
                                //   children: [
                                //     Image.asset(
                                //         "assets/images/traveller/location.png"),
                                //     SizedBox(
                                //       width: 5.w,
                                //     ),
                                //     SizedBox(
                                //       width: 250.w,
                                //       child: Text(
                                //           BookingTravellerCubit.get(context)
                                //               .accomandationDetailsModel!
                                //               .data!
                                //               .location
                                //               .toString(),
                                //           // "23 Abbas El Aqqad st - Naser city - Cairo",
                                //           style: TextStyle(
                                //             fontSize: 16,
                                //             fontWeight: FontWeight.w400,
                                //           )),
                                //     )
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                // Row(
                                //   children: [
                                //     Image.asset(
                                //         "assets/images/traveller/call.png"),
                                //     SizedBox(
                                //       width: 5.w,
                                //     ),
                                //     SizedBox(
                                //       width: 250.w,
                                //       child: Text(
                                //           "Call the Host through +${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.phone.toString()}",
                                //           style: TextStyle(
                                //             fontSize: 16,
                                //             fontWeight: FontWeight.w400,
                                //           )),
                                //     )
                                //   ],
                                // ),
                                SizedBox(
                                  height: 10.h),
                              ]))),
                        SizedBox(
                          height: 10.h),
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
                                detailsBooking(
                                    title: "ProfileGuest.checkIn",
                                    title2: BookingTravellerCubit.get(context)
                                        .accomandationDetailsModel!
                                        .data!
                                        .checkIn
                                        .toString()),
                                SizedBox(
                                  height: 5.h),
                                detailsBooking(
                                    title: "ProfileGuest.checkOut",
                                    title2: BookingTravellerCubit.get(context)
                                        .accomandationDetailsModel!
                                        .data!
                                        .checkOut
                                        .toString()),
                                SizedBox(
                                  height: 5.h),
                                detailsBooking(
                                    title: "ProfileGuest.numberGuests",
                                    title2: BookingTravellerCubit.get(context)
                                        .accomandationDetailsModel!
                                        .data!
                                        .guestNo
                                        .toString()),
                                SizedBox(
                                  height: 5.h),
                                ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(BookingTravellerCubit.get(
                                                    context)
                                                .accomandationDetailsModel!
                                                .data!
                                                .roomType![index]
                                                .roomType
                                                .toString()),
                                            Text(BookingTravellerCubit.get(
                                                    context)
                                                .accomandationDetailsModel!
                                                .data!
                                                .roomType![index]
                                                .count
                                                .toString()),
                                          ]),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 5.h),
                                    itemCount:
                                        BookingTravellerCubit.get(context)
                                            .accomandationDetailsModel!
                                            .data!
                                            .roomType!
                                            .length),
                                SizedBox(
                                  height: 10.h),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "getRoomDetails",
                                        arguments: {
                                          "id":
                                              BookingTravellerCubit.get(context)
                                                  .accomandationDetailsModel!
                                                  .data!
                                                  .id
                                                  .toString(),
                                          "night":
                                              BookingTravellerCubit.get(context)
                                                  .accomandationDetailsModel!
                                                  .data!
                                                  .totalNight
                                        });
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "View  Rooms Details",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600)))),
                                SizedBox(
                                  height: 10.h),
                              ]))),
                        SizedBox(
                          height: 10.h),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.totalNight.toString()} " +
                                          "booking.Nigth".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp)),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.pricePerNight.toString()}" +
                                          "booking.EGP".tr() +
                                          "/" +
                                          "Night",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          //color: Color.fromRGBO(5, 10, 42, 1),
                                          fontSize: 14.sp)),
                                  ]),
                                SizedBox(
                                  height: 10.h),
                                Text("booking.IncludingTax".tr(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                                SizedBox(
                                  height: 20.h),
                                Row(
                                  children: [
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "booking.Total".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp)),
                                    Spacer(),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.totalPrice.toString()} " +
                                          "booking.EGP".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp)),
                                  ]),
                                SizedBox(
                                  height: 20.h),
                              ]))),
                        SizedBox(
                          height: 20.h),
                        Container(
                          width: 327.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(20.r),
                              color: Color.fromRGBO(249, 239, 233, 1)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                        "assets/images/traveller/warining.png"),
                                    SizedBox(
                                      width: 10.w),
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 230.w,
                                          child: Text("booking.t1".tr(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700))),
                                        SizedBox(
                                          height: 10.h),
                                        SizedBox(
                                          width: 250.w,
                                          child: Text("booking.t2".tr(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400)))
                                      ])
                                  ]),
                                SizedBox(
                                  height: 20.h)
                              ]))),
                        SizedBox(
                          height: 20.h),
                        SizedBox(
                          width: 327.w,
                          height: 55.h,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side:
                                              BorderSide(color: accentColor))),
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(white),
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(white),
                                  elevation:
                                      WidgetStateProperty.all<double>(0.0)),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, "cancelReservation",
                                    arguments: {
                                      "id": BookingTravellerCubit.get(context)
                                          .accomandationDetailsModel!
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
                                    fontWeight: FontWeight.w600)))),
                        SizedBox(
                          height: 20.h),
                      ])));
        }));
  }
}

Widget detailsBooking({required String title, required String title2}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        overflow: TextOverflow.ellipsis,
        title.tr(),
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp)),
      Text(
        overflow: TextOverflow.ellipsis,
        title2.tr(),
        style: TextStyle(
            fontWeight: FontWeight.w500,
            //color: Color.fromRGBO(5, 10, 42, 1),
            fontSize: 14.sp)),
    ]);
}
