import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/widgets/cart_footer_section.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/widgets/cart_items_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartContentView extends StatelessWidget {
  final List<CardModel> cards;

  const CartContentView({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView(
        children: [
          CartItemsList(cards: cards),
          if (cards.isNotEmpty) CartFooterSection(cards: cards),
        ],
      ),
    );
  }
}
