import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/cart_cubit/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartProductDetails extends StatelessWidget {
  final CardModel card;
  final int index;

  const CartProductDetails({
    super.key,
    required this.card,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductHeader(
          description: card.description,
          index: index,
        ),
        SizedBox(height: 6.h),
        ProductTitle(title: card.title),
        SizedBox(height: 8.h),
        StoreInfo(storeName: card.store),
        SizedBox(height: 8.h),
        ProductPrice(price: card.price),
      ],
    );
  }
}

class ProductHeader extends StatelessWidget {
  final String description;
  final int index;

  const ProductHeader({
    super.key,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              color: accentColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 8.w),
        RemoveButton(index: index),
      ],
    );
  }
}

class RemoveButton extends StatelessWidget {
  final int index;

  const RemoveButton({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<CardCubit>().removeCard(index),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.close,
          color: Colors.red,
          size: 18.sp,
        ),
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  final String title;

  const ProductTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class StoreInfo extends StatelessWidget {
  final String storeName;

  const StoreInfo({
    super.key,
    required this.storeName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.store_outlined,
          color: accentColor.withValues(alpha: 0.7),
          size: 16.sp,
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            storeName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class ProductPrice extends StatelessWidget {
  final double price;

  const ProductPrice({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        "$price ${"currency".tr()}",
        style: TextStyle(
          color: accentColor,
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
