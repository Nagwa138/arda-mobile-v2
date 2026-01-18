import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/widgets/cart_product_details.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/widgets/product_image.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/widgets/quantity_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemCard extends StatelessWidget {
  final CardModel card;
  final int index;
  final int currentAmount;

  const CartItemCard({
    super.key,
    required this.card,
    required this.index,
    required this.currentAmount,
  });

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.h),
      child: Container(
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
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            Row(
              children: [
                ProductImage(
                  imageUrl: card.image,
                  isValid: isValidImageUrl(card.image),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: CartProductDetails(
                    card: card,
                    index: index,
                  ),
                ),
              ],
            ),
            Divider(height: 24.h, thickness: 1),
            QuantityControl(
              index: index,
              currentAmount: currentAmount,
            ),
          ],
        ),
      ),
    );
  }
}
