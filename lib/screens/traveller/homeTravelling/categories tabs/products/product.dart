import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_state.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProductCubit()..getAllProduct(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "Golden Hands",
                style: TextStyle(
                  color: accentColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'cart');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Icon(Icons.shopping_basket_rounded),
                  ),
                )
              ],
            ),
            body: state is getProductLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: accentColor,
                  ))
                : GridView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                    itemCount:
                        ProductCubit.get(context).productModel?.data?.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.w,
                      mainAxisSpacing: 15.h,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        print(ProductCubit.get(context)
                            .productModel!
                            .data?[index]
                            .id);
                        Navigator.pushNamed(context, "productDetails",
                            arguments: {
                              'id': ProductCubit.get(context)
                                  .productModel!
                                  .data?[index]
                                  .id,
                              'category': ProductCubit.get(context)
                                  .productModel!
                                  .data?[index]
                                  .name
                            });
                      },
                      child: Container(
                        width: 155.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadiusDirectional.circular(15.r)),
                        child: Card(
                          color: accentColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                ProductCubit.get(context)
                                    .productModel!
                                    .data![index]
                                    .imageName
                                    .toString(),
                                width: 200.w,
                                height: 120.h,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 20.h, left: 10.w, top: 0.h),
                                child: Text(
                                  [
                                    ProductCubit.get(context)
                                        .productModel!
                                        .data?[index]
                                        .name
                                        .toString(),
                                    ProductCubit.get(context)
                                        .productModel!
                                        .data?[index]
                                        .name
                                        .toString(),
                                    ProductCubit.get(context)
                                        .productModel!
                                        .data?[index]
                                        .name
                                        .toString(),
                                    ProductCubit.get(context)
                                        .productModel!
                                        .data?[index]
                                        .name
                                        .toString(),
                                    ProductCubit.get(context)
                                        .productModel!
                                        .data?[index]
                                        .name
                                        .toString(),
                                    ProductCubit.get(context)
                                        .productModel!
                                        .data?[index]
                                        .name
                                        .toString(),
                                  ][index]!
                                      .tr(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
