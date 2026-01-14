import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/models/traveller/randomProduct/random_product.dart'
    as product_model;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.onTap});
  final product_model.Data product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 270.w,
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          color: lightBeige,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.15 * 255).toInt()),
              spreadRadius: 0,
              blurRadius: 30,
              offset: const Offset(0, 10)),
          ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageSection(product: product),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductName(product: product),
                  SizedBox(height: 8.h),
                  ProductStoreInfo(product: product),
                  SizedBox(height: 10.h),
                  ProductPriceRow(product: product),
                ])),
          ])));
  }
}

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({super.key, required this.product});
  final product_model.Data product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r)),
          child: Container(
            height: 220.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFD4C4B0)),
            child: CustomImage(
              product.image,
              fit: BoxFit.cover,
              height: 220.h,
              width: double.infinity,
              placeholder: Center(
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 50.sp,
                  color: const Color(0xFF9B6B4A)))))),
        Positioned(
          top: 16.h,
          left: 16.w,
          right: 16.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductBadge(
                text: product.productType!),
              if (product.rate != null && product.rate! > 0)
                ProductRatingBadge(rating: product.rate!),
            ])),
      ]);
  }
}

class ProductBadge extends StatelessWidget {
  const ProductBadge({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5E3C), Color(0xFF9B6B4A)]),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5E3C).withAlpha((0.4 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 3)),
        ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.gesture_rounded,
            size: 13.sp,
            color: const Color(0xFFFAF5F0)),
          SizedBox(width: 5.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFFAF5F0),
              letterSpacing: 0.2)),
        ]));
  }
}

class ProductRatingBadge extends StatelessWidget {
  const ProductRatingBadge({super.key, required this.rating});
  final num rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5F0).withAlpha((0.95 * 255).toInt()),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5E3C).withAlpha((0.2 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 3)),
        ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            color: const Color(0xFFFFD700),
            size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF5A3D2B),
              letterSpacing: 0.2)),
        ]));
  }
}

class ProductName extends StatelessWidget {
  const ProductName({super.key, required this.product});
  final product_model.Data product;

  @override
  Widget build(BuildContext context) {
    return Text(
      product.productName ?? 'Golden Hands',
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF3D2817),
        height: 1.3,
        letterSpacing: -0.2),
      maxLines: 2,
      overflow: TextOverflow.ellipsis);
  }
}

class ProductStoreInfo extends StatelessWidget {
  const ProductStoreInfo({super.key, required this.product});
  final product_model.Data product;

  @override
  Widget build(BuildContext context) {
    if (product.store == null || product.store!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5F0).withAlpha((0.6 * 255).toInt()),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFD4C4B0).withAlpha((0.5 * 255).toInt()),
          width: 1)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.store_outlined,
            size: 16.sp,
            color: const Color(0xFF8B5E3C)),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              product.store!,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF5A3D2B),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2),
              maxLines: 1,
              overflow: TextOverflow.ellipsis)),
        ]));
  }
}

class ProductPriceRow extends StatelessWidget {
  const ProductPriceRow({super.key, required this.product});
  final product_model.Data product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProductPrice(price: product.price ?? 0),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: const Color(0xFF9B6B4A),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7D5737).withAlpha((0.4 * 255).toInt()),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 3)),
            ]),
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 20.sp,
            color: const Color(0xFFFAF5F0))),
      ]);
  }
}

class ProductPrice extends StatelessWidget {
  const ProductPrice({super.key, required this.price});
  final num price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: const Color(0xFF9B6B4A),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7D5737).withAlpha((0.4 * 255).toInt()),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 3)),
        ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$price',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFFAF5F0),
              height: 1)),
          SizedBox(width: 4.w),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              'EGP',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFAF5F0).withAlpha((0.85 * 255).toInt())))),
        ]));
  }
}
