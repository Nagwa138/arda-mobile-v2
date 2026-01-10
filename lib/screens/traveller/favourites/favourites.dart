import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/favourite_cubit/favourite_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/favourite_cubit/favourite_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FavouriteCubit(),
      child: BlocConsumer<FavouriteCubit, FavouriteState>(
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
                  elevation: 5.0,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Text("booking.favorite".tr(),
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
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                // FavouriteCubit.get(context).getAllFavourite(state: '0');
                                Navigator.pushNamed(context, "detailsFavorite");
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.asset(
                                          height: 150,
                                          fit: BoxFit.fitWidth,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          "assets/images/accomodtion2.jpg")),
                                  Text("Camps And Glamps",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                      ))
                                ],
                              )),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                              onTap: () {
                                //FavouriteCubit.get(context).getAllFavourite(state: '1');

                                Navigator.pushNamed(
                                    context, "detailsFavoriteProduct");
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.asset(
                                          height: 150,
                                          fit: BoxFit.fitWidth,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          "assets/images/products2.jpeg")),
                                  Text("Golden Hands",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                      ))
                                ],
                              )),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                              onTap: () {
                                FavouriteCubit.get(context)
                                    .getAllFavourite(state: '2');

                                Navigator.pushNamed(
                                    context, "detailsFavoriteTrips");
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.asset(
                                        height: 150,
                                        fit: BoxFit.fitWidth,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        "assets/images/trips2.jpeg"),
                                  ),
                                  Text("Journey Planner",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                      ))
                                ],
                              )),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                              onTap: () {
                                FavouriteCubit.get(context)
                                    .getAllFavourite(state: '3');

                                Navigator.pushNamed(
                                    context, "detailsFavoriteActivity");
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.asset(
                                        height: 150,
                                        fit: BoxFit.fitWidth,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        "assets/images/activity2.jpeg"),
                                  ),
                                  Text("Adventure",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                      ))
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
