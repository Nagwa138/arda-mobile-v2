import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/activity_cubit/activity_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/activity_cubit/activity_stata.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/favourite_cubit/favourite_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/favourite_cubit/favourite_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsActivityFavourite extends StatelessWidget {
  DetailsActivityFavourite({super.key});

  final bool emptyFavourites = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                FavouriteCubit()..getAllFavourite(state: "3")),
        BlocProvider(create: (BuildContext context) => ActivityCubit())
      ],
      child: BlocProvider(
        create: (BuildContext context) => ActivityCubit(),
        child: BlocConsumer<ActivityCubit, ActivityState>(
          listener: (context, state) {
            if (state is deleteFavouriteOfActivitySuccessful) {
              FavouriteCubit.get(context).getAllFavourite(state: "3");
            }
          },
          builder: (context, state) {
            return BlocConsumer<FavouriteCubit, FavouriteState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/background.jpeg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        backgroundColor: appBackgroundColor,
                        elevation: 0.0,
                        centerTitle: true,
                        title: Text("Adventure",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            )),
                        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                      ),
                      body: state is GetAllFavouriteLoading
                          ? Center(
                              child: Center(
                                  child: CircularProgressIndicator(
                              color: orange,
                            )))
                          : FavouriteCubit.get(context).activity!.data!.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.favorite_outline,
                                          color: orange,
                                          size: 150.sp,
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          "You haven’t any Adventure Now",
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
                              : ListView.separated(
                                  //physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "activitiesDetails",
                                                arguments: {
                                                  "activityId":
                                                      FavouriteCubit.get(
                                                              context)
                                                          .activity!
                                                          .data![index]
                                                          .id
                                                          .toString(),
                                                  "image": FavouriteCubit.get(
                                                          context)
                                                      .activity!
                                                      .data![index]
                                                      .image
                                                      .toString(),
                                                  "activityName":
                                                      FavouriteCubit.get(
                                                              context)
                                                          .activity!
                                                          .data![index]
                                                          .activitieName
                                                          .toString(),
                                                  "des": FavouriteCubit.get(
                                                          context)
                                                      .activity!
                                                      .data![index]
                                                      .description
                                                      .toString(),
                                                  "text": "Fav"
                                                });
                                          },
                                          child: Container(
                                            width: 380.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(25.r),
                                                color: Colors.white54),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10.w,
                                                      left: 10.w,
                                                      top: 15.h),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.r),
                                                        child: Image.network(
                                                          FavouriteCubit.get(
                                                                  context)
                                                              .activity!
                                                              .data![index]
                                                              .image
                                                              .toString(),
                                                          width: 99.w,
                                                          height: 114.h,
                                                          fit: BoxFit.fill,
                                                          color: accentColor
                                                              .withValues(
                                                                  alpha: 0.2),
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Container(
                                                              width: 99.w,
                                                              height: 114.h,
                                                              color: Colors
                                                                  .grey[300],
                                                              child: Icon(
                                                                Icons
                                                                    .broken_image,
                                                                color: Colors
                                                                    .grey[600],
                                                                size: 40.sp,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 200.w,
                                                            child: Text(
                                                              FavouriteCubit.get(
                                                                      context)
                                                                  .activity!
                                                                  .data![index]
                                                                  .activitieName
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp,
                                                                  color:
                                                                      accentColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
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
                                                                width: 60.w,
                                                                child: Text(
                                                                  "booking.Luxor"
                                                                          .tr() +
                                                                      "   ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Color.fromRGBO(
                                                                          140,
                                                                          140,
                                                                          140,
                                                                          1),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 60.w,
                                                                child: Text(
                                                                  "booking.Egypt"
                                                                      .tr(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Color.fromRGBO(
                                                                          140,
                                                                          140,
                                                                          140,
                                                                          1),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 30.w,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .star_rate_rounded,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              Text(
                                                                  FavouriteCubit
                                                                          .get(
                                                                              context)
                                                                      .activity!
                                                                      .data![
                                                                          index]
                                                                      .rate
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color:
                                                                        accentColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ))
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 115.w,
                                                                child: Text(
                                                                  FavouriteCubit.get(
                                                                              context)
                                                                          .activity!
                                                                          .data![
                                                                              index]
                                                                          .pricePerPerson
                                                                          .toString() +
                                                                      "booking.EGP"
                                                                          .tr(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color:
                                                                          accentColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 55,
                                                              ),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    ActivityCubit.get(context).deleteFavouriteOfActivity(
                                                                        activityId: FavouriteCubit.get(context)
                                                                            .activity!
                                                                            .data![index]
                                                                            .id
                                                                            .toString());
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .red,
                                                                  ))
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                  itemCount: FavouriteCubit.get(context)
                                      .activity!
                                      .data!
                                      .length),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
