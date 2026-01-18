import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/cart_cubit/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityControl extends StatelessWidget {
  final int index;
  final int currentAmount;

  const QuantityControl({
    super.key,
    required this.index,
    required this.currentAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            color: accentColor.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.2),
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
              QuantityButton(
                onTap: () => context.read<CardCubit>().decrementQuantity(index),
                icon: Icons.remove,
                isEnabled: currentAmount > 1,
              ),
              SizedBox(width: 12.w),
              Text(
                currentAmount.toString(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 12.w),
              QuantityButton(
                onTap: () => context.read<CardCubit>().incrementQuantity(index),
                icon: Icons.add,
                isEnabled: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuantityButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final bool isEnabled;

  const QuantityButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: isEnabled ? accentColor : Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: isEnabled ? Colors.white : Colors.grey[500],
        ),
      ),
    );
  }
}
