import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/cart/cart.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/cart_cubit/cart_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_state.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                ProductCubit()..getAllProductById(id: arguments['id'])),
        BlocProvider(create: (context) => CardCubit())
      ],
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (BuildContext context, ProductState state) {},
        builder: (BuildContext context, ProductState state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
                backgroundColor: appBackgroundColor,
                elevation: 0.0,
                centerTitle: true,
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'cart');
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Icon(Icons.shopping_basket_rounded),
                    ),
                  )
                ],
                title: Text(arguments['category'],
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ))),
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: TextFormField(
                      controller: ProductCubit.get(context).search,
                      enabled: true,
                      onChanged: (value) {
                        ProductCubit.get(context)
                            .getAllProductById(id: arguments['id']);
                      },
                      onFieldSubmitted: (value) {
                        ProductCubit.get(context)
                            .getAllProductById(id: arguments['id']);
                      },
                      decoration: InputDecoration(
                        hintText: "search for product?",
                        hintStyle: TextStyle(
                          color: accentColor,
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: accentColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        filled: true,
                        fillColor: Colors.white54,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: accentColor,
                            width: 0.5.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  state is getAllProductByIdLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: accentColor,
                        ))
                      : ProductCubit.get(context)
                              .allProductByIdModel!
                              .data!
                              .isEmpty
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 180.h,
                                    ),
                                    Image.asset(
                                        "assets/images/landingHome/notificationEmpty.png"),
                                    Text(
                                      textAlign: TextAlign.center,
                                      "You haven’t any Products Now",
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
                          : SizedBox(
                              height: 600.h,
                              child: ListView.separated(
                                  itemBuilder: (context, index) => CustomItem(
                                      context: context,
                                      amount: ProductCubit.get(context)
                                          .allProductByIdModel!
                                          .data![index]
                                          .amount
                                          .toInt(),
                                      id: ProductCubit.get(context)
                                          .allProductByIdModel!
                                          .data![index]
                                          .id
                                          .toString(),
                                      index: index,
                                      store: ProductCubit.get(context)
                                          .allProductByIdModel!
                                          .data![index]
                                          .store
                                          .toString(),
                                      itemId: ProductCubit.get(context)
                                          .allProductByIdModel!
                                          .data![index]
                                          .id
                                          .toString(),
                                      image: ProductCubit.get(context)
                                          .allProductByIdModel!
                                          .data![index]
                                          .image![0]
                                          .toString(),
                                      productType: ProductCubit.get(context)
                                          .allProductByIdModel!
                                          .data![index]
                                          .productType
                                          .toString(),
                                      productName: ProductCubit.get(context)
                                          .allProductByIdModel!
                                          .data![index]
                                          .productName
                                          .toString(),
                                      price: ProductCubit.get(context)
                                          .allProductByIdModel!
                                          .data![index]
                                          .price
                                          .toString(),
                                      rate: ProductCubit.get(context)
                                          .allProductByIdModel!
                                          .data![index]
                                          .rate
                                          .toString(),
                                      pices: ProductCubit.get(context)
                                          .allProductByIdModel!
                                          .data![index]
                                          .avilablePieces
                                          .toInt(),
                                      //colorAdd: ProductCubit.get(context).changeColor,
                                      function: () {
                                        final newCard = CardModel(
                                            title: ProductCubit.get(context)
                                                .allProductByIdModel!
                                                .data![index]
                                                .productName
                                                .toString(),
                                            description:
                                                ProductCubit.get(context)
                                                    .allProductByIdModel!
                                                    .data![index]
                                                    .productType
                                                    .toString(),
                                            image: ProductCubit.get(context)
                                                .allProductByIdModel!
                                                .data![index]
                                                .image![0]
                                                .toString(),
                                            store: ProductCubit.get(context)
                                                .allProductByIdModel!
                                                .data![index]
                                                .store
                                                .toString(),
                                            price: ProductCubit.get(context)
                                                .allProductByIdModel!
                                                .data![index]
                                                .price
                                                .toDouble(),
                                            productId: ProductCubit.get(context)
                                                .allProductByIdModel!
                                                .data![index]
                                                .id
                                                .toString(),
                                            amount: ProductCubit.get(context)
                                                .allProductByIdModel!
                                                .data![index]
                                                .amount,
                                            pices: ProductCubit.get(context)
                                                .allProductByIdModel!
                                                .data![index]
                                                .avilablePieces);
                                        context
                                            .read<CardCubit>()
                                            .addCard(newCard);
                                      }),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 20.h),
                                  itemCount: ProductCubit.get(context)
                                      .allProductByIdModel!
                                      .data!
                                      .length),
                            )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
