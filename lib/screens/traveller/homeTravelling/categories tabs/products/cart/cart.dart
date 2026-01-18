import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/widgets/cart_app_bar.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/widgets/cart_background_container.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/widgets/cart_content_view.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/widgets/empty_cart_view.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/cart_cubit/cart_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CardCubit()..loadCards()),
        BlocProvider(create: (context) => AddServiceCubit()),
        BlocProvider(create: (context) => ProductCubit())
      ],
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: CartBackgroundContainer(
              child: Column(
                children: [
                  CartAppBar(),
                  Expanded(
                    child: BlocBuilder<CardCubit, List<CardModel>>(
                      builder: (context, cards) {
                        if (cards.isEmpty) {
                          return EmptyCartView();
                        }
                        return CartContentView(cards: cards);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
