import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/cart_cubit/cart_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_cubit.dart';

Widget CustomItem({
  required BuildContext context,
  required String id,
  required int index,
  required String image,
  required String productType,
  required String itemId,
  required String productName,
  //required VoidCallback addCard,
  var price,
  var rate,
  required final VoidCallback function,
  required String store,
  required int amount,
  required int pices

  // required bool colorAdd



}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Column(
      children: [
        GestureDetector(

          onTap: () {
            //print(arguments['id']);
            Navigator.pushNamed(context, "productDetails1",arguments: {
              'productId' : id,
              'name' : productName,
              'amount' : amount,
              'avaliablePices' : pices,
              'text' : "product"

            });
          },
          child: Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Color(0xFFF7F7F7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network(
                    image,
                    width: 1.sw,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(productType,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(productName,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        )),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(
                          rate,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.home_work_outlined,
                          color: orange,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(store,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ))
                      ],
                    ),
                    Text(price + "booking.EGP".tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: orange,
                          fontWeight: FontWeight.w600,
                        ))
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: 350.w,
                  height: 55.h,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: orange))),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(orange),
                      ),
                      onPressed: function,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/traveller/recycle.png",
                            color: white,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "products.AddCard".tr(),
                            style: TextStyle(fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
