import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemsList extends StatelessWidget {
  final List<CardModel> cards;

  const CartItemsList({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cards.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return CartItemCard(
          card: cards[index],
          index: index,
          currentAmount: cards[index].amount,
        );
      },
    );
  }
}
