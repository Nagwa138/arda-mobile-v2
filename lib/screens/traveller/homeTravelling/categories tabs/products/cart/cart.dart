import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/cart_cubit/cart_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class CartBackgroundContainer extends StatelessWidget {
  final Widget child;

  const CartBackgroundContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        "products.cart".tr(),
        style: TextStyle(
          color: accentColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

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

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final bool isValid;

  const ProductImage({
    super.key,
    required this.imageUrl,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: isValid
          ? Image.network(
              imageUrl,
              width: 85.w,
              height: 110.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return PlaceholderImage(
                  icon: Icons.image_not_supported,
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return LoadingImage(loadingProgress: loadingProgress);
              },
            )
          : PlaceholderImage(icon: Icons.shopping_bag),
    );
  }
}

class PlaceholderImage extends StatelessWidget {
  final IconData icon;

  const PlaceholderImage({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
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
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Icon(
        icon,
        color: Colors.grey[600],
        size: 40.sp,
      ),
    );
  }
}

class LoadingImage extends StatelessWidget {
  final ImageChunkEvent loadingProgress;

  const LoadingImage({
    super.key,
    required this.loadingProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      height: 110.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
          strokeWidth: 2,
          color: accentColor,
        ),
      ),
    );
  }
}

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
