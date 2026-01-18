import 'package:PassPort/components/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptyCartIcon(),
          SizedBox(height: 24.h),
          EmptyCartTitle(),
          SizedBox(height: 12.h),
          EmptyCartSubtitle(),
          SizedBox(height: 32.h),
          StartShoppingButton(),
        ],
      ),
    );
  }
}

class EmptyCartIcon extends StatelessWidget {
  const EmptyCartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40.w),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.shopping_cart_outlined,
        size: 120.sp,
        color: accentColor.withValues(alpha: 0.6),
      ),
    );
  }
}

class EmptyCartTitle extends StatelessWidget {
  const EmptyCartTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Your Cart is Empty",
      style: TextStyle(
        color: accentColor,
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class EmptyCartSubtitle extends StatelessWidget {
  const EmptyCartSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class StartShoppingButton extends StatelessWidget {
  const StartShoppingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'travellerNavBar'),
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
              color: accentColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
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
    );
  }
}
