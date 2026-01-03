import 'package:PassPort/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/traveller/homeTravelling/cardBuilder/cardBuilder.dart';
import 'package:PassPort/services/notification/notificationLogic.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/accomadationType_cubit/accomadtion_type_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellingcubit/home_traveller_state.dart';
import 'package:PassPort/services/traveller/homeTravellingcubit/home_travellet_cubit.dart';

import 'cardBuilder2/cardBuilder2.dart';

// Define new colors
const Color backgroundColor = Color(0xFFFBF0E3);
const Color accentColor = Color(0xFF161651);

class HomeTravelling extends StatelessWidget {
  const HomeTravelling({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => HomeTravellerCubit()..load()),
        BlocProvider(create: (context) => AccommodatingCubit())
      ],
      child: BlocConsumer<HomeTravellerCubit, HomeTravellerState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          if (state is getCategoryBlogError) {
            return Image.asset("assets/images/error.png");
          }

          return Scaffold(
            backgroundColor: backgroundColor, // Changed to new background color
            /////

            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  backgroundColor:
                      backgroundColor, // Changed to new background color
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  actions: [
                    SizedBox(
                      width: 0.80.sw,
                      height: 50.h,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.w),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: "search",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                suffixIcon: Container(
                                  height: 1.sh,
                                  decoration: BoxDecoration(
                                    color: orange,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Image.asset(
                                    "assets/images/landingHome/filter.png",
                                    width: 20.w,
                                    height: 20.h,
                                    color: white,
                                  ),
                                ),
                                filled: true,
                                fillColor: white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'travellerSearch');
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //SizedBox(width: 10.w),

                    IconButton(
                      onPressed: () {
                        FirebaseNotification list = FirebaseNotification();
                        Navigator.pushNamed(context, 'travellerNotification',
                            arguments: list.notificationList);
                      },
                      icon: ValueListenableBuilder<bool>(
                        valueListenable: isUserNotification,
                        builder: (context, value, child) {
                          return IconButton(
                            onPressed: () {
                              FirebaseNotification list =
                                  FirebaseNotification();
                              Navigator.pushNamed(
                                  context, 'travellerNotification',
                                  arguments: list.notificationList);
                            },
                            icon: Icon(Icons.notification_add,
                                size: 24.sp,
                                color: value ? white : Colors.green),
                          );
                        },
                      ),
                      // icon: Icon(
                      //   Icons.notification_add,
                      //   size: 24.sp,
                      //   color: Colors.white,
                      // ),
                    ),
                  ],
                  expandedHeight: 500.h,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/auth/home.jpeg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset("assets/images/ard_logo.png")],
                      ),
                    ),
                  ),
                ),
              ],
              body: state is getCategoryBlogLoading ||
                      state is TopRatedLoading ||
                      state is RandomActivityLoading ||
                      state is RandomCampLoading ||
                      state is RandomHotelLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: accentColor, // Changed to accent color
                    ))
                  : ListView(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //    HomeTravellerCubit.get(context).blogCategoryModel!.data!.isNotEmpty ?
                              //
                              //        Column(
                              //   children: [
                              //     Align(
                              //       alignment: Alignment.centerLeft,
                              //       child: Text(
                              //         "Stories",
                              //         style: TextStyle(
                              //           color: black,
                              //           fontSize: 20.sp,
                              //
                              //
                              //           fontWeight: FontWeight.w600,
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(height: 20.h),
                              //
                              //     Container(
                              //       height: 150.h,
                              //       child: ListView.builder(
                              //         scrollDirection: Axis.horizontal,
                              //         itemCount: HomeTravellerCubit.get(context).blogCategoryModel?.data?.length ,
                              //         itemBuilder: (context, index) {
                              //           return Padding(
                              //             padding: EdgeInsets.symmetric(horizontal: 12.w),
                              //             child:
                              //
                              //
                              //             GestureDetector(
                              //               onTap: () {
                              //                 print(HomeTravellerCubit.get(context).blogCategoryModel!.data![index].id.toString());
                              //                 Navigator.pushNamed(context, 'stories',arguments: {
                              //                   'id' : HomeTravellerCubit.get(context).blogCategoryModel?.data![index].id.toString(),
                              //                   'title' : HomeTravellerCubit.get(context).blogCategoryModel?.data![index].name.toString(),
                              //                   'image' : HomeTravellerCubit.get(context).blogCategoryModel?.data![index].image.toString(),
                              //                 });
                              //
                              //               },
                              //               child: Column(
                              //                 children: [
                              //                   Container(
                              //
                              //                     child: ClipRRect(
                              //                       borderRadius: BorderRadius.circular(50.r),
                              //                       child: Image.network(
                              //                         HomeTravellerCubit.get(context).blogCategoryModel!.data![index].image.toString(),
                              //                         fit: BoxFit.cover,height: 100.h,
                              //                       ),
                              //                     ),
                              //                     decoration: BoxDecoration(
                              //                       borderRadius: BorderRadius.circular(30.r),
                              //
                              //                     ),
                              //                   ),
                              //
                              //                   SizedBox(height: 10.h),
                              //                   Text(
                              //                     HomeTravellerCubit.get(context).blogCategoryModel!.data![index].name.toString(),
                              //                     style: TextStyle(
                              //                       color: black,
                              //                       fontSize: 14.sp,
                              //                       fontWeight: FontWeight.w600,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           );
                              //         },
                              //       ),
                              //     ),
                              //
                              //   ],
                              // ) :
                              //
                              //
                              //        SizedBox.shrink(),

                              Text(
                                'travellerHome.categories'.tr(),
                                style: TextStyle(
                                  color: accentColor, // Changed to accent color
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 16.h),

                              Container(
                                height: 170.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 4,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 20.w,
                                  ),
                                  itemBuilder: (context, index) {
                                    var items = [
                                      {
                                        "image":
                                            "assets/images/traveller/home/accommodation.png",
                                        "title": "Camps And Glamps",
                                        "route": "accommodations",
                                      },
                                      {
                                        "image":
                                            "assets/images/traveller/home/trip.png",
                                        "title": "Journey Planner",
                                        "route": "trips",
                                      },
                                      {
                                        "image":
                                            "assets/images/traveller/home/activities.png",
                                        "title": "Adventure",
                                        "route": "activities",
                                      },
                                      {
                                        "image":
                                            "assets/images/traveller/home/product.png",
                                        "title": "Golden Hands",
                                        "route": "product",
                                      },
                                    ];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, items[index]["route"]!);
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            child: Container(
                                              width: 140.w,
                                              height: 150.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(20.r),
                                                  border: Border.all(
                                                      color:
                                                          accentColor)), // Changed border color
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    items[index]["image"]!,
                                                    width: 40.w,
                                                    height: 40.h,
                                                  ), // Keep icon unchanged
                                                  Text(
                                                    items[index]["title"]!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color:
                                                          accentColor, // Changed text color
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              HomeTravellerCubit.get(context)
                                      .ratedModel!
                                      .data!
                                      .isEmpty
                                  ? SizedBox.shrink()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Top Rated',
                                          style: TextStyle(
                                            color:
                                                accentColor, // Changed text color
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        Text(
                                          'travellerHome.topRatedHint'.tr(),
                                          style: TextStyle(
                                            color:
                                                accentColor, // Changed text color
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 12.h),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(
                                              HomeTravellerCubit.get(context)
                                                  .ratedModel!
                                                  .data!
                                                  .length,
                                              (index) => CardBuilder(
                                                type: HomeTravellerCubit.get(
                                                        context)
                                                    .ratedModel!
                                                    .data![index]
                                                    .accomodationType
                                                    .toString(),
                                                name: HomeTravellerCubit.get(
                                                        context)
                                                    .ratedModel!
                                                    .data![index]
                                                    .accomodationName
                                                    .toString(),
                                                location:
                                                    HomeTravellerCubit.get(
                                                            context)
                                                        .ratedModel!
                                                        .data![index]
                                                        .address
                                                        .toString(),
                                                price: HomeTravellerCubit.get(
                                                        context)
                                                    .ratedModel!
                                                    .data![index]
                                                    .price
                                                    .toString(),
                                                image: [
                                                  "${HomeTravellerCubit.get(context).ratedModel!.data![index].imageUrl![0].toString()}",
                                                ],
                                                rate: HomeTravellerCubit.get(
                                                        context)
                                                    .ratedModel!
                                                    .data![index]
                                                    .rate
                                                    .toString(),
                                                function: () {
                                                  if (HomeTravellerCubit.get(
                                                              context)
                                                          .ratedModel!
                                                          .data?[index]
                                                          .isFav ==
                                                      false) {
                                                    context
                                                        .read<
                                                            AccommodatingCubit>()
                                                        .addFavouriteOfAccommodating(
                                                            AccomId: HomeTravellerCubit
                                                                    .get(
                                                                        context)
                                                                .ratedModel!
                                                                .data![index]
                                                                .accomodationId
                                                                .toString());
                                                    HomeTravellerCubit.get(
                                                            context)
                                                        .changeFavRated(
                                                            HomeTravellerCubit
                                                                    .get(
                                                                        context)
                                                                .ratedModel!
                                                                .data![index]
                                                                .isFav,
                                                            index);
                                                  } else {
                                                    context
                                                        .read<
                                                            AccommodatingCubit>()
                                                        .deleteFavouriteOfAccommodating(
                                                            AccomId: HomeTravellerCubit
                                                                    .get(
                                                                        context)
                                                                .ratedModel!
                                                                .data![index]
                                                                .accomodationId
                                                                .toString());
                                                    HomeTravellerCubit.get(
                                                            context)
                                                        .changeFavRated(
                                                            HomeTravellerCubit
                                                                    .get(
                                                                        context)
                                                                .ratedModel!
                                                                .data![index]
                                                                .isFav,
                                                            index);
                                                  }
                                                },
                                                isFavourite:
                                                    HomeTravellerCubit.get(
                                                            context)
                                                        .ratedModel!
                                                        .data![index]
                                                        .isFav as bool,
                                                index: index,
                                                id: HomeTravellerCubit.get(
                                                        context)
                                                    .ratedModel!
                                                    .data![index]
                                                    .accomodationId
                                                    .toString(),
                                                functionCheck: () {
                                                  //print(HomeTravellerCubit.get(context).ratedModel!.data![index].accomodationId.toString());
                                                  Navigator.pushNamed(
                                                      context, "roomInfo",
                                                      arguments: {
                                                        "id": HomeTravellerCubit
                                                                .get(context)
                                                            .ratedModel!
                                                            .data![index]
                                                            .accomodationId
                                                            .toString(),
                                                        "price":
                                                            HomeTravellerCubit
                                                                    .get(
                                                                        context)
                                                                .ratedModel!
                                                                .data![index]
                                                                .price
                                                                .toString()
                                                      });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                              SizedBox(height: 20.h),

                              Text(
                                "Journey Planner",
                                style: TextStyle(
                                  color: accentColor, // Changed text color
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'travellerHome.subtitle1'.tr(),
                                style: TextStyle(
                                  color: accentColor, // Changed text color
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Stack(
                          children: [
                            CarouselSlider(
                              items: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/courser/image7.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          "Discover a unique travel experience with us ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.sp,
                                              color:
                                                  white), // Keep color for contrast
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "trips");
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                accentColor, // Changed button color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.h),
                                          ),
                                          child: Text(
                                            'travellerHome.btn1'.tr(),
                                            style: TextStyle(
                                              color:
                                                  backgroundColor, // Light color on dark button
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 12.r,
                                        offset: Offset(3, 4),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(25.r),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/courser/image2.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          "Discover a unique travel experience with us ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.sp,
                                              color:
                                                  white), // Keep color for contrast
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "trips");
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                accentColor, // Changed button color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.h),
                                          ),
                                          child: Text(
                                            'travellerHome.btn1'.tr(),
                                            style: TextStyle(
                                              color:
                                                  backgroundColor, // Light color on dark button
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/courser/image3.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          "Discover a unique travel experience with us ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.sp,
                                              color:
                                                  white), // Keep color for contrast
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "trips");
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                accentColor, // Changed button color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.h),
                                          ),
                                          child: Text(
                                            'travellerHome.btn1'.tr(),
                                            style: TextStyle(
                                              color:
                                                  backgroundColor, // Light color on dark button
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/courser/image4.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          "Discover a unique travel experience with us ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.sp,
                                              color:
                                                  white), // Keep color for contrast
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "trips");
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                accentColor, // Changed button color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.h),
                                          ),
                                          child: Text(
                                            'travellerHome.btn1'.tr(),
                                            style: TextStyle(
                                              color:
                                                  backgroundColor, // Light color on dark button
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/courser/image5.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          "Discover a unique travel experience with us ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.sp,
                                              color:
                                                  white), // Keep color for contrast
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "trips");
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                accentColor, // Changed button color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.h),
                                          ),
                                          child: Text(
                                            'travellerHome.btn1'.tr(),
                                            style: TextStyle(
                                              color:
                                                  backgroundColor, // Light color on dark button
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/courser/image6.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          "Discover a unique travel experience with us ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.sp,
                                              color:
                                                  white), // Keep color for contrast
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "trips");
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                accentColor, // Changed button color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.h),
                                          ),
                                          child: Text(
                                            'travellerHome.btn1'.tr(),
                                            style: TextStyle(
                                              color:
                                                  backgroundColor, // Light color on dark button
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              options: CarouselOptions(
                                height: 250.h,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                scrollPhysics: NeverScrollableScrollPhysics(),
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                // onPageChanged: callbackFunction,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HomeTravellerCubit.get(context)
                                      .randomModel!
                                      .data!
                                      .isEmpty
                                  ? SizedBox.shrink()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ready For Your Next Adventure Book it Now With Just A Tab",
                                          style: TextStyle(
                                            color:
                                                accentColor, // Changed text color
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(
                                              HomeTravellerCubit.get(context)
                                                  .randomModel!
                                                  .data!
                                                  .length,
                                              (index) => Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w),
                                                child: SizedBox(
                                                  width: 300.w,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              "activitiesDetails",
                                                              arguments: {
                                                                'activityId': HomeTravellerCubit
                                                                        .get(
                                                                            context)
                                                                    .randomModel!
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                'image': HomeTravellerCubit
                                                                        .get(
                                                                            context)
                                                                    .randomModel!
                                                                    .data![
                                                                        index]
                                                                    .image
                                                                    .toString(),
                                                                'des': HomeTravellerCubit
                                                                        .get(
                                                                            context)
                                                                    .randomModel!
                                                                    .data![
                                                                        index]
                                                                    .description
                                                                    .toString(),
                                                                'activityName': HomeTravellerCubit
                                                                        .get(
                                                                            context)
                                                                    .randomModel!
                                                                    .data![
                                                                        index]
                                                                    .activitieName
                                                                    .toString()
                                                              });
                                                        },
                                                        child: Stack(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.r),
                                                              child: Stack(
                                                                alignment: Alignment
                                                                    .center, // Center the loading indicator
                                                                children: [
                                                                  Image.network(
                                                                    HomeTravellerCubit.get(
                                                                            context)
                                                                        .randomModel!
                                                                        .data![
                                                                            index]
                                                                        .image
                                                                        .toString(),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height:
                                                                        400.h,
                                                                    width:
                                                                        300.w,
                                                                    loadingBuilder: (BuildContext
                                                                            context,
                                                                        Widget
                                                                            child,
                                                                        ImageChunkEvent?
                                                                            loadingProgress) {
                                                                      if (loadingProgress ==
                                                                          null) {
                                                                        return child; // Image has finished loading
                                                                      }
                                                                      return Stack(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        children: [
                                                                          child, // Partially loaded image
                                                                          CircularProgressIndicator(
                                                                            color:
                                                                                black,
                                                                            valueColor:
                                                                                AlwaysStoppedAnimation<Color>(Colors.white),
                                                                            value: loadingProgress.expectedTotalBytes != null
                                                                                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                                                : null,
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                    errorBuilder: (context,
                                                                            error,
                                                                            stackTrace) =>
                                                                        Icon(
                                                                      Icons
                                                                          .error,
                                                                      color: Colors
                                                                          .red,
                                                                      size: 50
                                                                          .w, // Adjust size as needed
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            // The text at the bottom-left corner
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          20.h,
                                                                      left:
                                                                          10.w),
                                                              child: Text(
                                                                HomeTravellerCubit
                                                                        .get(
                                                                            context)
                                                                    .randomModel!
                                                                    .data![
                                                                        index]
                                                                    .activitieName
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      25.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(height: 45.h),
                              HomeTravellerCubit.get(context)
                                      .randomModelHotel!
                                      .data!
                                      .isEmpty
                                  ? SizedBox.shrink()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'travellerHome.title2'.tr(),
                                          style: TextStyle(
                                            color:
                                                accentColor, // Changed text color
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        Text(
                                          'travellerHome.subtitle2'.tr(),
                                          style: TextStyle(
                                            color:
                                                accentColor, // Changed text color
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(
                                              HomeTravellerCubit.get(context)
                                                  .randomModelHotel!
                                                  .data!
                                                  .length,
                                              (index) => SizedBox(
                                                width: 270.w,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context, 'roomInfo',
                                                        arguments: {
                                                          'id': HomeTravellerCubit
                                                                  .get(context)
                                                              .randomModelHotel!
                                                              .data![index]
                                                              .accomodationId
                                                              .toString(),
                                                          "price": HomeTravellerCubit
                                                                  .get(context)
                                                              .randomModelHotel!
                                                              .data![index]
                                                              .price
                                                              .toString()
                                                        });
                                                  },
                                                  child: CardBuilder2(
                                                    type:
                                                        HomeTravellerCubit.get(
                                                                context)
                                                            .randomModelHotel!
                                                            .data![index]
                                                            .accomodationType,

                                                    name:
                                                        HomeTravellerCubit.get(
                                                                context)
                                                            .randomModelHotel!
                                                            .data![index]
                                                            .accomodationName
                                                            .toString(),
                                                    location:
                                                        HomeTravellerCubit.get(
                                                                context)
                                                            .randomModelHotel!
                                                            .data![index]
                                                            .address
                                                            .toString(),
                                                    // location: "Luxor",
                                                    price:
                                                        HomeTravellerCubit.get(
                                                                context)
                                                            .randomModelHotel!
                                                            .data![index]
                                                            .price
                                                            .toString(),
                                                    image:
                                                        HomeTravellerCubit.get(
                                                                context)
                                                            .randomModelHotel!
                                                            .data![index]
                                                            .imageUrl![0]
                                                            .toString(),
                                                    rate:
                                                        HomeTravellerCubit.get(
                                                                context)
                                                            .randomModelHotel!
                                                            .data![index]
                                                            .rate
                                                            .toString(),
                                                    AccomId: "",
                                                    perks: [
                                                      "Breakfast",
                                                      "Best Seller",
                                                    ],
                                                    isFavourite: index.isEven
                                                        ? true
                                                        : false,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(height: 20.h),
                              HomeTravellerCubit.get(context)
                                      .modelProduct!
                                      .data!
                                      .isEmpty
                                  ? SizedBox.shrink()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Golden Hands",
                                          style: TextStyle(
                                            color:
                                                accentColor, // Changed text color
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(
                                              HomeTravellerCubit.get(context)
                                                  .modelProduct!
                                                  .data!
                                                  .length,
                                              (index) => Padding(
                                                padding: EdgeInsets.only(
                                                    right: 16.w),
                                                child: SizedBox(
                                                  width: 175.w,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        HomeTravellerCubit.get(
                                                                context)
                                                            .modelProduct!
                                                            .data![index]
                                                            .productName
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: black,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      GestureDetector(
                                                        onTap: () {
                                                          ///
                                                          Navigator.pushNamed(
                                                              context,
                                                              "productDetails1",
                                                              arguments: {
                                                                'productId': HomeTravellerCubit
                                                                        .get(
                                                                            context)
                                                                    .modelProduct!
                                                                    .data![
                                                                        index]
                                                                    .id,
                                                                'name': HomeTravellerCubit
                                                                        .get(
                                                                            context)
                                                                    .modelProduct!
                                                                    .data![
                                                                        index]
                                                                    .productName,
                                                                'amount': HomeTravellerCubit
                                                                        .get(
                                                                            context)
                                                                    .modelProduct!
                                                                    .data![
                                                                        index]
                                                                    .amount,
                                                                'avaliablePices': HomeTravellerCubit
                                                                        .get(
                                                                            context)
                                                                    .modelProduct!
                                                                    .data![
                                                                        index]
                                                                    .avilablePieces,
                                                                'text':
                                                                    "product"
                                                              });
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey, // لون الظل
                                                                spreadRadius:
                                                                    5, // انتشار الظل
                                                                blurRadius: 12
                                                                    .r, // مدى التشويش في الظل
                                                                offset: Offset(
                                                                    0,
                                                                    3), // موقع الظل (x, y)
                                                              ),
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.r),
                                                            child:
                                                                Image.network(
                                                              HomeTravellerCubit
                                                                      .get(
                                                                          context)
                                                                  .modelProduct!
                                                                  .data![index]
                                                                  .image![0]
                                                                  .toString(),
                                                              fit: BoxFit.cover,
                                                              width: 175.w,
                                                              height: 175.h,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20.h),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
