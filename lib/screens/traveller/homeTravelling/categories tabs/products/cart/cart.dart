import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';
import 'package:PassPort/services/partner/profile/profile_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/cart_cubit/cart_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_state.dart';
import 'package:PassPort/version2_module/core/widgets/custom_button.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  // دالة للتحقق من صحة رابط الصورة
  bool isValidImageUrl(String url) {
    if (url.isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => CardCubit()..loadCards()),
        BlocProvider(create: (context) => AddServiceCubit()),
        BlocProvider(create: (context) => ProductCubit())
      ],
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              title: Text(
                "products.cart".tr(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            body: BlocBuilder<CardCubit, List<CardModel>>(
              builder: (context, cards) {
                if (cards.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(40.w),
                          decoration: BoxDecoration(
                            color: accentColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 120.sp,
                            color: accentColor.withOpacity(0.6),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "Your Cart is Empty",
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Text(
                            "Add products to your cart to see them here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'travellerNavBar');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 32.w,
                              vertical: 14.h,
                            ),
                            decoration: BoxDecoration(
                              color: accentColor,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: accentColor.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "Start Shopping",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ListView(
                    children: [
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cards.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                        itemBuilder: (context, index) {
                          final card = cards[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.w, vertical: 8.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        child: isValidImageUrl(card.image)
                                            ? Image.network(
                                                card.image,
                                                width: 85.w,
                                                height: 110.h,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    width: 85.w,
                                                    height: 110.h,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.grey[200]!,
                                                          Colors.grey[300]!,
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r),
                                                    ),
                                                    child: Icon(
                                                      Icons.image_not_supported,
                                                      color: Colors.grey[600],
                                                      size: 40.sp,
                                                    ),
                                                  );
                                                },
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Container(
                                                    width: 85.w,
                                                    height: 110.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r),
                                                    ),
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                        strokeWidth: 2,
                                                        color: accentColor,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            : Container(
                                                width: 85.w,
                                                height: 110.h,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.grey[200]!,
                                                      Colors.grey[300]!,
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                ),
                                                child: Icon(
                                                  Icons.shopping_bag,
                                                  color: Colors.grey[600],
                                                  size: 40.sp,
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    card.description,
                                                    style: TextStyle(
                                                      color: accentColor,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<CardCubit>()
                                                        .removeCard(index);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(4.w),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.1),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                      size: 18.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6.h),
                                            Text(
                                              card.title,
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.store_outlined,
                                                  color: accentColor
                                                      .withOpacity(0.7),
                                                  size: 16.sp,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    card.store,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8.h),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 6.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: accentColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: Text(
                                                "${card.price} " +
                                                    "currency".tr(),
                                                style: TextStyle(
                                                  color: accentColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 24.h, thickness: 1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'products.amount'.tr(),
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: accentColor.withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(25.r),
                                          border: Border.all(
                                            color: accentColor.withOpacity(0.2),
                                            width: 1,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 4.h,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<CardCubit>()
                                                    .decrementQuantity(index);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(4.w),
                                                decoration: BoxDecoration(
                                                  color:
                                                      cards[index].amount <= 1
                                                          ? Colors.grey[300]
                                                          : accentColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 18.sp,
                                                  color:
                                                      cards[index].amount <= 1
                                                          ? Colors.grey[500]
                                                          : Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 12.w),
                                            Text(
                                              cards[index].amount.toString(),
                                              style: TextStyle(
                                                color: accentColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(width: 12.w),
                                            GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<CardCubit>()
                                                    .incrementQuantity(index);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(4.w),
                                                decoration: BoxDecoration(
                                                  color: accentColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 18.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      cards.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'travellerNavBar');
                                  },
                                  child: Container(
                                    height: 56.h,
                                    width: 1.sw,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 2.w,
                                          color: accentColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: accentColor.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_shopping_cart,
                                            color: accentColor,
                                            size: 20.sp,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            'products.addCart'.tr(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: accentColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24.h),
                                Container(
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.receipt_long,
                                            color: accentColor,
                                            size: 22.sp,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            'products.payment'.tr(),
                                            style: TextStyle(
                                              color: accentColor,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(height: 24.h, thickness: 1),
                                      _buildPaymentRow(
                                        'products.Subtotal'.tr(),
                                        "${cards.map((e) => e.price * e.amount).reduce((value, element) => value + element)} " +
                                            "currency".tr(),
                                        false,
                                      ),
                                      Divider(height: 24.h, thickness: 1),
                                      _buildPaymentRow(
                                        'products.total'.tr(),
                                        '${cards.map((e) => e.price * e.amount).reduce((value, element) => value + element)} ' +
                                            "currency".tr(),
                                        true,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                CustomButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'checkoutInfo',
                                        arguments: cards);
                                  },
                                  text: 'products.check'.tr(),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? accentColor : Colors.grey[600],
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: accentColor,
            fontSize: isTotal ? 17.sp : 15.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

ListTile roomNumBuilder({
  required VoidCallback function,
  required VoidCallback functionAdd,
  required String title,
  required int number,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
      title,
      style: TextStyle(
        color: accentColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
    trailing: SizedBox(
      width: 90.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: function,
            child: Icon(
              Icons.remove_circle_outline,
              size: 24.sp,
              color: accentColor,
            ),
          ),
          Text(
            number.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: accentColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: functionAdd,
            child: Icon(
              Icons.add_circle_outline,
              size: 24.sp,
              color: accentColor,
            ),
          ),
        ],
      ),
    ),
  );
}
