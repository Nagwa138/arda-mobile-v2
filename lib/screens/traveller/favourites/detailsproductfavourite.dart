import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/favourite_cubit/favourite_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/favourite_cubit/favourite_state.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsProductFavourite extends StatelessWidget {
  DetailsProductFavourite({super.key});
  final bool emptyFavourites = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                FavouriteCubit()..getAllFavourite(state: '1')),
        BlocProvider(create: (BuildContext context) => ProductCubit()),
      ],
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is deleteFavouriteOfProductSuccessful) {
            FavouriteCubit.get(context).getAllFavourite(state: "1");
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
                        fit: BoxFit.cover))),
                  Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                    backgroundColor: appBackgroundColor,
                    elevation: 0.0,
                    centerTitle: true,
                    title: Text("Golden Hands",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios))),
                  body: state is GetAllFavouriteLoading
                      ? Center(
                          child: Center(
                              child: CircularProgressIndicator(
                          color: orange)))
                      : FavouriteCubit.get(context).product!.data!.isEmpty
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite_outline,
                                      color: orange,
                                      size: 150.sp),
                                    Text(
                                      textAlign: TextAlign.center,
                                      "You havenâ€™t any Golden Hands Now",
                                      style: TextStyle(
                                        color: accentColor,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w400))
                                  ])))
                          : ListView.separated(
                              //physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print(FavouriteCubit.get(context)
                                            .product!
                                            .data![index]
                                            .id
                                            .toString());
                                        Navigator.pushNamed(
                                            context, "productDetails1",
                                            arguments: {
                                              "productId":
                                                  FavouriteCubit.get(context)
                                                      .product!
                                                      .data![index]
                                                      .id
                                                      .toString(),
                                              'name':
                                                  FavouriteCubit.get(context)
                                                      .product!
                                                      .data![index]
                                                      .productName
                                                      .toString(),
                                              'amount':
                                                  FavouriteCubit.get(context)
                                                      .product!
                                                      .data![index]
                                                      .amount,
                                              'avaliablePices':
                                                  FavouriteCubit.get(context)
                                                      .product!
                                                      .data![index]
                                                      .avilablePieces,
                                              'text': "Favourite"
                                            });
                                      },
                                      child: Container(
                                        width: 380.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(25.r),
                                            color: Color.fromRGBO(
                                                247, 247, 247, 1)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10.w,
                                                  left: 10.w,
                                                  top: 15.h),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.r),
                                                    child: CustomImage(
                                                      FavouriteCubit.get(
                                                              context)
                                                          .product!
                                                          .data![index]
                                                          .image![0],
                                                      width: 99.w,
                                                      height: 114.h,
                                                      fit: BoxFit.fill)),
                                                  SizedBox(
                                                    width: 5.w),
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
                                                              .product!
                                                              .data![index]
                                                              .productName
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  accentColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600))),
                                                      SizedBox(
                                                        height: 5.h),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .home_work_outlined,
                                                                color: orange),
                                                              SizedBox(
                                                                width: 5.w),
                                                              Text(
                                                                  "Egyptian store",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500))
                                                            ]),
                                                          SizedBox(
                                                            width: 10.w),
                                                          Icon(
                                                            Icons
                                                                .star_rate_rounded,
                                                            color: Colors.amber),
                                                          SizedBox(
                                                            width: 50.w,
                                                            child: Text(
                                                                FavouriteCubit.get(
                                                                        context)
                                                                    .product!
                                                                    .data![
                                                                        index]
                                                                    .rate
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color:
                                                                      accentColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)))
                                                        ]),
                                                      SizedBox(
                                                        height: 5.h),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                FavouriteCubit.get(
                                                                            context)
                                                                        .product!
                                                                        .data![
                                                                            index]
                                                                        .price
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
                                                                            .w400)),
                                                            ]),
                                                          SizedBox(
                                                            width: 90.w),
                                                          IconButton(
                                                              onPressed: () {
                                                                ProductCubit.get(context).deleteFavouriteOfProduct(
                                                                    productId: FavouriteCubit.get(
                                                                            context)
                                                                        .product!
                                                                        .data![
                                                                            index]
                                                                        .id
                                                                        .toString());
                                                              },
                                                              icon: Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    Colors.red))
                                                        ])
                                                    ])
                                                ])),
                                          ]))),
                                  ]);
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 15.h),
                              itemCount: FavouriteCubit.get(context)
                                  .product!
                                  .data!
                                  .length)),
                ]);
            });
        }));
  }
}
