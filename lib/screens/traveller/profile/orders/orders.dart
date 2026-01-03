import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Orders extends StatelessWidget {
  final PageController pageController = PageController();

  Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProductCubit()..getAllOrders(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is OrderAgainSuccessful) {
            ProductCubit.get(context).getAllOrders();
            Fluttertoast.showToast(
                msg: "Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is OrderAgainError) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
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
                  elevation: 0,
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
                body: state is getOrderLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: accentColor,
                      ))
                    : ProductCubit.get(context).getAllOrder!.data!.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      "assets/images/landingHome/notificationEmpty.png"),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "You haven’t any Orders Now",
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
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                            child: ListView.separated(
                              itemCount: ProductCubit.get(context)
                                  .getAllOrder!
                                  .data!
                                  .length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 16.h,
                              ),
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  if (ProductCubit.get(context)
                                          .getAllOrder!
                                          .data![index]
                                          .orderStatus ==
                                      "Completed")
                                    Navigator.pushNamed(context, "orderDetails",
                                        arguments: {
                                          'id': ProductCubit.get(context)
                                              .getAllOrder!
                                              .data![index]
                                              .id
                                              .toString()
                                        });
                                },
                                child: cardBuilder(context,
                                    dateBooking: ProductCubit.get(context)
                                        .getAllOrder!
                                        .data![index]
                                        .bookingDate
                                        .toString(),
                                    dateDelivery: ProductCubit.get(context)
                                        .getAllOrder!
                                        .data![index]
                                        .deliveryDate
                                        .toString(),
                                    timeBooking: ProductCubit.get(context)
                                        .getAllOrder!
                                        .data![index]
                                        .bookingTime
                                        .toString(),
                                    timeDelivery: ProductCubit.get(context)
                                        .getAllOrder!
                                        .data![index]
                                        .deliveryTime
                                        .toString(),
                                    price: ProductCubit.get(context)
                                        .getAllOrder!
                                        .data![index]
                                        .totalPrice,
                                    qunatity: ProductCubit.get(context)
                                        .getAllOrder!
                                        .data![index]
                                        .noOfProducts!
                                        .toInt(),
                                    status: ProductCubit.get(context)
                                        .getAllOrder!
                                        .data![index]
                                        .orderStatus
                                        .toString(),
                                    isDelivered: ProductCubit.get(context)
                                        .getAllOrder!
                                        .data![index]
                                        .orderStatus
                                        .toString(),
                                    id: ProductCubit.get(context)
                                        .getAllOrder!
                                        .data![index]
                                        .id
                                        .toString()),
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

  Widget cardBuilder(
    BuildContext context, {
    required String dateBooking,
    required String timeBooking,
    required String dateDelivery,
    required String timeDelivery,
    required int price,
    required int qunatity,
    required String status,
    required String id,
    required String isDelivered,
  }) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white54,
        // color: Colors.red,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "viewRooms.title".tr(),
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(19, 10, 3, 1)),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(
                Icons.date_range,
                color: Color.fromRGBO(0, 86, 79, 1),
                size: 18.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                dateBooking,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: Color(0xFF8C8C8C),
                ),
              ),
              Spacer(),
              Icon(
                Icons.access_time,
                color: Color.fromRGBO(0, 86, 79, 1),
              ),
              Text(
                timeBooking,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: Color(0xFF8C8C8C),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Text(
            "viewRooms.delivery".tr(),
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(19, 10, 3, 1)),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(
                Icons.date_range,
                color: Color.fromRGBO(0, 86, 79, 1),
                size: 18.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                dateDelivery,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: Color(0xFF8C8C8C),
                ),
              ),
              Spacer(),
              Icon(
                Icons.access_time,
                color: Color.fromRGBO(0, 86, 79, 1),
              ),
              Text(
                timeDelivery,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: Color(0xFF8C8C8C),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Text(
                "${qunatity} " + "travellerOrders.pieces".tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: accentColor,
                ),
              ),
              Spacer(),
              isDelivered == "Completed"
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : SizedBox.shrink(),
              SizedBox(width: 10.w),
              Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: accentColor,
                ),
              )
            ],
          ),
          Divider(),
          if (isDelivered == 'Upcoming')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    ProductCubit.get(context).MadeOrderAgain(id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: accentColor,
                        width: 1.w,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
                    child: Text(
                      "travellerOrders.btn2".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                GestureDetector(
                  onTap: () async {
                    ProductCubit.get(context)
                        .startPayment(context: context, id: id, amount: price);
                  },
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: accentColor,
                        width: 1.w,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
                    child: Center(
                      child: Text(
                        "push",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          // else
          //   GestureDetector(
          //     onTap: () {
          //       trackOrder(context);
          //     },
          //     child: Container(
          //       width: 1.sw,
          //       decoration: BoxDecoration(
          //         color: orange,
          //         borderRadius: BorderRadius.circular(8.r),
          //         border: Border.all(
          //           color: orange,
          //           width: 1.w,
          //         ),
          //       ),
          //       padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
          //       child: Center(
          //         child: Text(
          //           "travellerOrders.btn3".tr(),
          //           style: TextStyle(
          //             fontWeight: FontWeight.w600,
          //             fontSize: 12.sp,
          //             color: white,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  trackOrder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "travellerOrders.btn3".tr(),
              style: TextStyle(
                color: accentColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: white,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              trackOrderItemBuilder(
                icon: Icons.repeat_rounded,
                title: "travellerOrders.track1".tr(),
                isActive: false,
              ),
              trackOrderItemBuilder(
                icon: Icons.fire_truck_outlined,
                title: "travellerOrders.track2".tr(),
                isActive: false,
              ),
              trackOrderItemBuilder(
                icon: Icons.check_circle,
                title: "travellerOrders.delivered".tr(),
                isActive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile trackOrderItemBuilder(
      {required String title, required IconData icon, required bool isActive}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      leading: Icon(
        icon,
        color: isActive ? accentColor : Color(0xFF8C8C8C),
        size: 25.sp,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? accentColor : Color(0xFF8C8C8C),
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
