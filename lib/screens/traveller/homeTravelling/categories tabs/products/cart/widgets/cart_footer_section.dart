import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartFooterSection extends StatelessWidget {
  final List<CardModel> cards;

  const CartFooterSection({
    super.key,
    required this.cards,
  });

  double get subtotal => cards
      .map((e) => e.price * e.amount)
      .reduce((value, element) => value + element);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        AddMoreProductsButton(),
        SizedBox(height: 24.h),
        PaymentSummaryCard(subtotal: subtotal, total: subtotal),
        SizedBox(height: 24.h),
        CheckoutButton(cards: cards),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class AddMoreProductsButton extends StatelessWidget {
  const AddMoreProductsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'travellerNavBar'),
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
            borderRadius: BorderRadius.circular(12.r),
          ),
          shadows: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}

class PaymentSummaryCard extends StatelessWidget {
  final double subtotal;
  final double total;

  const PaymentSummaryCard({
    super.key,
    required this.subtotal,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaymentSummaryHeader(),
          Divider(height: 24.h, thickness: 1),
          PaymentRow(
            label: 'products.Subtotal'.tr(),
            value: "$subtotal ${"currency".tr()}",
            isTotal: false,
          ),
          Divider(height: 24.h, thickness: 1),
          PaymentRow(
            label: 'products.total'.tr(),
            value: "$total ${"currency".tr()}",
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class PaymentSummaryHeader extends StatelessWidget {
  const PaymentSummaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class PaymentRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const PaymentRow({
    super.key,
    required this.label,
    required this.value,
    required this.isTotal,
  });

  @override
  Widget build(BuildContext context) {
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

class CheckoutButton extends StatelessWidget {
  final List<CardModel> cards;

  const CheckoutButton({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        'checkoutInfo',
        arguments: cards,
      ),
      child: Container(
        height: 56.h,
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
        child: Center(
          child: Text(
            'products.check'.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
