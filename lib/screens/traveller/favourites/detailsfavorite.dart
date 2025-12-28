import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/accomadationType_cubit/accomadtion_type_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/accomadationType_cubit/acommedtion_type_state.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/favourite_cubit/favourite_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/favourite_cubit/favourite_state.dart';

class DetailsFavorite extends StatelessWidget {
  DetailsFavorite({super.key});

  bool emptyFavourites = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                FavouriteCubit()..getAllFavourite(state: '0')),
        BlocProvider(create: (context) => AccommodatingCubit())
      ],
      child: BlocConsumer<AccommodatingCubit, AccommodatingState>(
        listener: (context, state) {
          if (state is deleteFavouriteOfAccomandationSuccessful) {
            FavouriteCubit.get(context).getAllFavourite(state: '0');
          }
        },
        builder: (context, state) {
          return BlocConsumer<FavouriteCubit, FavouriteState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: appBackgroundColor,
                  appBar: AppBar(
                    backgroundColor: appBackgroundColor,
                    elevation: 0.0,
                    centerTitle: true,
                    // leading: IconButton(onPressed: (){
                    //   Navigator.pushNamed(context, "travellerNavBar");
                    //
                    // }, icon: Icon(Icons.arrow_back)),
                    title: Text("Camps And Glamps",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        )),
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                  ),
                  body: emptyFavourites
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  "assets/images/landingHome/notificationEmpty.png"),
                              Text(
                                textAlign: TextAlign.center,
                                "booking.favoriteEmpty".tr(),
                                style: TextStyle(
                                  color: const Color.fromRGBO(21, 11, 61, 1),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        )
                      : state is GetAllFavouriteLoading
                          ? Center(
                              child: Center(
                                  child: CircularProgressIndicator(
                              color: orange,
                            )))
                          : FavouriteCubit.get(context)
                                  .accomandation!
                                  .data!
                                  .isEmpty
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
                                          "You haven’t any Camps And Glamps  Now",
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
                                                context, "roomInfo",
                                                arguments: {
                                                  "id": FavouriteCubit.get(
                                                          context)
                                                      .accomandation!
                                                      .data![index]
                                                      .id
                                                      .toString(),
                                                  "price": FavouriteCubit.get(
                                                          context)
                                                      .accomandation!
                                                      .data![index]
                                                      .reservationPrice
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
                                                              .accomandation!
                                                              .data![index]
                                                              .coverPhotoUrl
                                                              .toString(),
                                                          width: 99.w,
                                                          height: 114.h,
                                                          fit: BoxFit.fill,
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
                                                                  .accomandation!
                                                                  .data![index]
                                                                  .serviceName
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
                                                                  FavouriteCubit.get(
                                                                              context)
                                                                          .accomandation!
                                                                          .data![
                                                                              index]
                                                                          .city
                                                                          .toString() +
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
                                                                  FavouriteCubit
                                                                          .get(
                                                                              context)
                                                                      .accomandation!
                                                                      .data![
                                                                          index]
                                                                      .government
                                                                      .toString(),
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
                                                                      .accomandation!
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
                                                                width: 65.w,
                                                                child: Text(
                                                                  FavouriteCubit.get(
                                                                              context)
                                                                          .accomandation!
                                                                          .data![
                                                                              index]
                                                                          .reservationPrice
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
                                                                width: 3.w,
                                                              ),
                                                              SizedBox(
                                                                width: 65.w,
                                                                child: Text(
                                                                  "/" +
                                                                      "booking.Nigth"
                                                                          .tr(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color:
                                                                          accentColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 30,
                                                              ),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    print(FavouriteCubit.get(
                                                                            context)
                                                                        .accomandation!
                                                                        .data![
                                                                            index]
                                                                        .id
                                                                        .toString());
                                                                    AccommodatingCubit.get(context).deleteFavouriteOfAccommodating(
                                                                        AccomId: FavouriteCubit.get(context)
                                                                            .accomandation!
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
                                      .accomandation!
                                      .data!
                                      .length));
            },
          );
        },
      ),
    );
  }
}
// /*
// Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Sonesta St. George \n Hotel - Convention",
//                                           style: TextStyle(
//                                               fontSize: 16.sp,
//                                               color: black,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                         SizedBox(
//                                           height: 5.h,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Image.asset(
//                                                 "assets/images/landingHome/location.png"),
//                                             Text(
//                                               "booking.Luxor".tr() + "   ",
//                                               style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   color: Color.fromRGBO(
//                                                       140, 140, 140, 1),
//                                                   fontWeight: FontWeight.w400),
//                                             ),
//                                             Text(
//                                               "booking.Egypt".tr(),
//                                               style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   color: Color.fromRGBO(
//                                                       140, 140, 140, 1),
//                                                   fontWeight: FontWeight.w400),
//                                             ),
//                                             SizedBox(
//                                               width: 10.w,
//                                             ),
//                                             Icon(
//                                               Icons.star_rate_rounded,
//                                               color: Colors.amber,
//                                             ),
//                                             Text("4.8",
//                                                 style: TextStyle(
//                                                   fontSize: 14,
//                                                   color: black,
//                                                   fontWeight: FontWeight.w500,
//                                                 ))
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 5.h,
//                                         ),
//                                         product
//                                             ? Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.date_range_outlined,
//                                                     color: orange,
//                                                     size: 18.sp,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 130.w,
//                                                     child: Text(
//                                                       "13 Jun 2024",
//                                                       style: TextStyle(
//                                                           fontSize: 14.sp,
//                                                           color: Color.fromRGBO(
//                                                               140, 140, 140, 1),
//                                                           fontWeight:
//                                                               FontWeight.w400),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                             : SizedBox.shrink(),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "3000 " + "booking.EGP".tr(),
//                                               style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   color: orange,
//                                                   fontWeight: FontWeight.w400),
//                                             ),
//                                             SizedBox(
//                                               width: 3.w,
//                                             ),
//                                             Text(
//                                               "/" + "booking.Nigth".tr(),
//                                               style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   color: black,
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                             SizedBox(
//                                               width: 8,
//                                             ),
//                                             IconButton(
//                                                 onPressed: () {},
//                                                 icon: Icon(
//                                                   Icons.favorite,
//                                                   color: Colors.red,
//                                                 ))
//                                           ],
//                                         )
//                                       ],
//                                     ),
//  */
