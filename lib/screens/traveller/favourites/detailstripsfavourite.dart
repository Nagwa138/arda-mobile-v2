import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/favourite_cubit/favourite_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/favourite_cubit/favourite_state.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/trips_cubit/trips_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/trips_cubit/trips_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTripsFavourite extends StatelessWidget {
  DetailsTripsFavourite({super.key});

  final bool emptyFavourites = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  FavouriteCubit()..getAllFavourite(state: "2")),
          BlocProvider(create: (context) => TripsCubit())
        ],
        child:
            BlocConsumer<TripsCubit, TripsStates>(listener: (context, state) {
          if (state is deleteFavouriteOfTripsSuccessful) {
            FavouriteCubit.get(context).getAllFavourite(state: "2");
          }
        }, builder: (context, state) {
          return BlocConsumer<FavouriteCubit, FavouriteState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Stack(children: [
                  Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/background.jpeg"),
                              fit: BoxFit.cover))),
                  Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                          backgroundColor: appBackgroundColor,
                          elevation: 0.0,
                          centerTitle: true,
                          // leading: IconButton(onPressed: (){
                          //   Navigator.pushNamed(context, "travellerNavBar");
                          //
                          // }, icon: Icon(Icons.arrow_back)),
                          title: Text("Journey Planner",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          leading: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios))),
                      body: state is GetAllFavouriteLoading
                          ? Center(
                              child: Center(
                                  child:
                                      CircularProgressIndicator(color: orange)))
                          : FavouriteCubit.get(context).trip!.data!.isEmpty
                              ? Center(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.favorite_outline,
                                                color: orange, size: 150.sp),
                                            Text(
                                                textAlign: TextAlign.center,
                                                "You haven't any Journey Planner Now",
                                                style: TextStyle(
                                                    color: accentColor,
                                                    fontSize: 22.sp,
                                                    fontWeight:
                                                        FontWeight.w400))
                                          ])))
                              : ListView.separated(
                                  //physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "detailsTrips",
                                                arguments: {
                                                  'id': FavouriteCubit.get(
                                                          context)
                                                      .trip!
                                                      .data![index]
                                                      .id
                                                      .toString(),
                                                  'text': "Favourite"
                                                });
                                          },
                                          child: Container(
                                              width: 380.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(25.r),
                                                  color: Colors.white54),
                                              child: Column(children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10.w,
                                                        left: 10.w,
                                                        top: 15.h,
                                                        bottom: 15.h),
                                                    child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.r),
                                                              child: CustomImage(
                                                                  FavouriteCubit
                                                                          .get(
                                                                              context)
                                                                      .trip!
                                                                      .data![
                                                                          index]
                                                                      .imageName
                                                                      .toString(),
                                                                  width: 99.w,
                                                                  height: 114.h,
                                                                  fit: BoxFit
                                                                      .fill)),
                                                          SizedBox(width: 5.w),
                                                          Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                    width:
                                                                        200.w,
                                                                    child: Text(
                                                                        FavouriteCubit.get(context)
                                                                            .trip!
                                                                            .data![
                                                                                index]
                                                                            .name
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: 16
                                                                                .sp,
                                                                            color:
                                                                                accentColor,
                                                                            fontWeight:
                                                                                FontWeight.w600))),
                                                                SizedBox(
                                                                    height:
                                                                        5.h),
                                                                Row(children: [
                                                                  Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .calendar_month,
                                                                            color:
                                                                                orange),
                                                                        SizedBox(
                                                                            width:
                                                                                10.w),
                                                                        SizedBox(
                                                                            width:
                                                                                120.w,
                                                                            child: Text(FavouriteCubit.get(context).trip!.data![index].date.toString(), style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)))
                                                                      ]),
                                                                  SizedBox(
                                                                      width:
                                                                          30.w),
                                                                  Icon(
                                                                      Icons
                                                                          .star_rate_rounded,
                                                                      color: Colors
                                                                          .amber),
                                                                  Text(
                                                                      FavouriteCubit.get(
                                                                              context)
                                                                          .trip!
                                                                          .data![
                                                                              index]
                                                                          .rate
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              accentColor,
                                                                          fontWeight:
                                                                              FontWeight.w500))
                                                                ]),
                                                                SizedBox(
                                                                    height:
                                                                        5.h),
                                                                Row(children: [
                                                                  SizedBox(
                                                                      width:
                                                                          120.w,
                                                                      child: Text(
                                                                          FavouriteCubit.get(context).trip!.data![index].pricePerPerson.toString() +
                                                                              "booking.EGP"
                                                                                  .tr() +
                                                                              " /indvidul",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              color: accentColor,
                                                                              fontWeight: FontWeight.w400))),
                                                                  SizedBox(
                                                                      width:
                                                                          55),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        TripsCubit.get(context).deleteFavouriteOfTrips(
                                                                            tripId:
                                                                                FavouriteCubit.get(context).trip!.data![index].id.toString());
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .favorite,
                                                                          color:
                                                                              Colors.red))
                                                                ])
                                                              ])
                                                        ])),
                                              ]))),
                                    ]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 15.h),
                                  itemCount: FavouriteCubit.get(context)
                                      .trip!
                                      .data!
                                      .length)),
                ]);
              });
        }));
  }
}
