import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/trips_cubit/trips_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/trips_cubit/trips_state.dart';

class Trips extends StatelessWidget {
  const Trips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TripsCubit()..getAllTrips(),
      child: BlocConsumer<TripsCubit, TripsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "Journey Planner",
                style: TextStyle(
                  color: accentColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            floatingActionButton: SizedBox(
              height: 60.h,
              width: 60.w,
              child: FittedBox(
                child: FloatingActionButton(
                    shape: CircleBorder(),
                    onPressed: () {
                      Navigator.pushNamed(context, "addTripe");
                    },
                    backgroundColor: accentColor,
                    child: Icon(
                      Icons.add,
                      color: white,
                      size: 30.sp,
                    )),
              ),
            ),
            body: state is GetTripsLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: orange,
                  ))
                : TripsCubit.get(context).tripsModel!.data!.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  "assets/images/landingHome/notificationEmpty.png"),
                              Text(
                                textAlign: TextAlign.center,
                                "You haven’t any Journey Planner Now",
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ListView.separated(
                            itemBuilder: (context, index) => Container(
                                  width: 327.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(24.r),
                                    border: Border.all(color: accentColor),
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadiusDirectional.only(
                                          topEnd: Radius.circular(24.r),
                                          topStart: Radius.circular(24.r),
                                        ),
                                        child: Image.network(
                                          TripsCubit.get(context)
                                              .tripsModel!
                                              .data![index]
                                              .image
                                              .toString(),
                                          height: 300.h,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: black,
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          (loadingProgress
                                                                  .expectedTotalBytes ??
                                                              1)
                                                      : null,
                                                ),
                                              );
                                            }
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Center(
                                            child: Icon(
                                              Icons.error,
                                              color: Colors.red,
                                              size: 50.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.h, left: 20.w, right: 20.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                TripsCubit.get(context)
                                                    .tripsModel!
                                                    .data![index]
                                                    .name
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            // SizedBox(height: 10.h,),
                                            // Divider(color: Color.fromRGBO(238, 238, 238, 1),),
                                            // SizedBox(height: 10.h,),
                                            // Row(
                                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //   children: [
                                            //     Column(
                                            //       crossAxisAlignment: CrossAxisAlignment.start,
                                            //       children: [
                                            //         Text(
                                            //             "trips.From".tr(),
                                            //             style: TextStyle(
                                            //               fontSize: 8.sp,
                                            //               color: Color.fromRGBO(140, 140, 140, 1),
                                            //               fontWeight: FontWeight.w500,
                                            //             )
                                            //         ),
                                            //         SizedBox(height: 5.h,),
                                            //         Text(
                                            //             TripsCubit.get(context).tripsModel!.data![index].from.toString(),
                                            //             //"trips.Alexanderia".tr(),
                                            //             style: TextStyle(
                                            //               fontSize: 12.sp,
                                            //               fontWeight: FontWeight.w500,
                                            //             )
                                            //         )
                                            //       ],
                                            //     ),
                                            //
                                            //     Image.asset("assets/images/traveller/loadtrips.png"),
                                            //
                                            //     Column(
                                            //       crossAxisAlignment: CrossAxisAlignment.start,
                                            //       children: [
                                            //         Text(
                                            //             "trips.To".tr(),
                                            //             style: TextStyle(
                                            //               fontSize: 8.sp,
                                            //               color: Color.fromRGBO(140, 140, 140, 1),
                                            //               fontWeight: FontWeight.w500,
                                            //             )
                                            //         ),
                                            //         SizedBox(height: 5.h,),
                                            //         Text(
                                            //             TripsCubit.get(context).tripsModel!.data![index].to.toString(),
                                            //             //"trips.Cairo".tr(),
                                            //             style: TextStyle(
                                            //               fontSize: 12.sp,
                                            //               fontWeight: FontWeight.w500,
                                            //             )
                                            //         )
                                            //       ],
                                            //     ),
                                            //
                                            //
                                            //
                                            //
                                            //   ],
                                            // ),
                                            // SizedBox(height: 10.h,),
                                            Divider(
                                              color: Colors.white54,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        "assets/images/traveller/time.png"),
                                                    SizedBox(width: 10.w),
                                                    Text(
                                                        TripsCubit.get(context)
                                                            .tripsModel!
                                                            .data![index]
                                                            .time
                                                            .toString(),
                                                        //"5:00 am",
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        "assets/images/traveller/date.png"),
                                                    SizedBox(width: 10.w),
                                                    Text(
                                                        TripsCubit.get(context)
                                                            .tripsModel!
                                                            .data![index]
                                                            .date
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ))
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Divider(
                                              color: Colors.white54,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        "assets/images/traveller/person.png"),
                                                    SizedBox(width: 10.w),
                                                    Text(
                                                        "${TripsCubit.get(context).tripsModel!.data![index].availableSeats.toString()}  " +
                                                            "trips.person".tr(),
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ))
                                                  ],
                                                ),
                                                Text(
                                                    "${TripsCubit.get(context).tripsModel!.data![index].pricePerPerson.toString()} " +
                                                        "booking.EGP".tr() +
                                                        " / " +
                                                        "trips.person".tr(),
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color: accentColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 40.h,
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            side: BorderSide(
                                                                color:
                                                                    accentColor))),
                                                    foregroundColor:
                                                        WidgetStateProperty
                                                            .all<Color>(
                                                                Colors.white),
                                                    backgroundColor:
                                                        WidgetStateProperty
                                                            .all<Color>(
                                                                accentColor),
                                                  ),
                                                  onPressed: () {
                                                    print(
                                                        TripsCubit.get(context)
                                                            .tripsModel!
                                                            .data![index]
                                                            .id
                                                            .toString());
                                                    Navigator.pushNamed(
                                                        context, "detailsTrips",
                                                        arguments: {
                                                          'id': TripsCubit.get(
                                                                  context)
                                                              .tripsModel!
                                                              .data![index]
                                                              .id
                                                              .toString(),
                                                          'text': "trips",
                                                          "num": TripsCubit.get(
                                                                  context)
                                                              .tripsModel!
                                                              .data![index]
                                                              .availableSeats
                                                        });
                                                  },
                                                  child: Text(
                                                    "trips.BookNow".tr(),
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                            itemCount: TripsCubit.get(context)
                                .tripsModel!
                                .data!
                                .length),
                      )),
          );
        },
      ),
    );
  }
}

String formatDuration(String duration) {
  DateTime utcDateTime = DateTime.parse(duration);

  // Convert the DateTime to local time
  DateTime localDateTime = utcDateTime.toLocal().subtract(Duration(hours: 2));

  Duration difference = DateTime.now().difference(localDateTime);

  DateTime time =
      localDateTime.add(Duration(hours: DateTime.now().timeZoneOffset.inHours));

  if (time.difference(DateTime.now()).inDays > 0) {
    return DateFormat('dd/MM hh:mm a').format(time);
  }

  return DateFormat('hh:mm a').format(time);
}
