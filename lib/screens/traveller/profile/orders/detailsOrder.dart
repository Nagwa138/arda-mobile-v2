import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_state.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(

      create: (BuildContext context)=>ProductCubit()..getDetailsOrder(arguments['id']),
      child: BlocConsumer<ProductCubit,ProductState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
              backgroundColor: appBackgroundColor,

              appBar: AppBar(
                backgroundColor: appBackgroundColor,
                elevation: 0.0,

                centerTitle: true,
                title: Text(
                  'travellerOrders.title'.tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

              ),
              body:
              state is GetDetailsLoading ? Center(child: CircularProgressIndicator(color: accentColor,)) :
              ListView.separated(itemBuilder: (context,index)=>Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Container(
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
                              ProductCubit.get(context).orderDetails!.data![index].image.toString(),
                              width: 1.sw,
                              height: 200.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(ProductCubit.get(context).orderDetails!.data![index].category.toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ProductCubit.get(context).orderDetails!.data![index].productName.toString(),
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
                                    ProductCubit.get(context).orderDetails!.data![index].rate.toString(),
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
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("products.amount".tr(),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Row(
                                children: [
                                  Text(
                                    ProductCubit.get(context).orderDetails!.data![index].payedAmount.toString(),
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
                            height: 10.h,
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
                                  Text(ProductCubit.get(context).orderDetails!.data![index].store.toString(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ))
                                ],
                              ),
                              Text(ProductCubit.get(context).orderDetails!.data![index].price.toString() + "booking.EGP".tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: accentColor,
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
                                  backgroundColor: MaterialStateProperty.all<Color>(accentColor),
                                ),
                                onPressed: (){
                                  Navigator.pushNamed(context, 'reviewBooking',arguments: {
                                    'id' : ProductCubit.get(context).orderDetails!.data![index].id.toString(),
                                    'name' : ProductCubit.get(context).orderDetails!.data![index].productName.toString(),
                                    'image' : ProductCubit.get(context).orderDetails!.data![index].image.toString(),
                                    'address' :ProductCubit.get(context).orderDetails!.data![index].store.toString(),
                                  });

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      "travellerOrders.btn1".tr(),
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
                  ],
                ),
              ), separatorBuilder: (context,index)=>SizedBox(height: 10.h,), itemCount: ProductCubit.get(context).orderDetails!.data!.length)
          );
        },

      ),
    );
  }
}
