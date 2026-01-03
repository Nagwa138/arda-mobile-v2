import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/screens/add%20service/addServices.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_state.dart';
import 'package:PassPort/version2_module/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckoutInfo extends StatelessWidget {
  const CheckoutInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CardModel> cards =
        ModalRoute.of(context)!.settings.arguments as List<CardModel>;

    return BlocProvider(
      create: (BuildContext context) => ProductCubit(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is MadeOrderSuccessful) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            cards.clear();
            cards.length = 0;
            Navigator.pushNamed(context, "orders");
          } else if (state is MadeOrderError) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: appBackgroundColor,
              title: Text(
                "products.purchasing".tr(),
                style: TextStyle(
                  color: black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              children: <Widget>[
                Text(
                  "products.t1".tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "products.t2".tr(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                textFormFildBuilder(
                  context,
                  title: "trips.phone".tr(),
                  hint: "trips.enterPhone".tr(),
                  inputType: TextInputType.number,
                  controller: ProductCubit.get(context).phoneNumberOrder,
                ),
                Text(
                  "products.address".tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    height: 2.5.h,
                  ),
                ),
                // textFormFildBuilder(
                //   context,
                //   title: "register.governate".tr(),
                //   hint: "Ex. Cairo",
                //   controller: ProductCubit.get(context).government,
                // ),
                textFormFildBuilder(
                  context,
                  title: "addService.1.city".tr(),
                  hint: "Ex. Nasr City",
                  controller: ProductCubit.get(context).city,
                ),
                textFormFildBuilder(
                  context,
                  title: "addService.1.address".tr(),
                  hint: "Ex. 10th Street",
                  controller: ProductCubit.get(context).street,
                ),
                textFormFildBuilder(
                  context,
                  title: "products.build".tr(),
                  hint: "EX: Building No. 5",
                  inputType: TextInputType.number,
                  controller: ProductCubit.get(context).buildNumber,
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  onPressed: () async {
                    // Validate phone number
                    if (ProductCubit.get(context)
                        .phoneNumberOrder
                        .text
                        .trim()
                        .isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please enter phone number",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                      return;
                    }

                    // Validate city
                    if (ProductCubit.get(context).city.text.trim().isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please enter city",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                      return;
                    }

                    // Validate street
                    if (ProductCubit.get(context).street.text.trim().isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please enter street address",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                      return;
                    }

                    // Validate building number
                    if (ProductCubit.get(context)
                        .buildNumber
                        .text
                        .trim()
                        .isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please enter building number",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                      return;
                    }

                    // All validations passed, proceed with order
                    ProductCubit.get(context).madeOrder(cards);
                  },
                  text: 'booking.Continue'.tr(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
