import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/models/traveller/products/get_one_product_by_id.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/cart_cubit/cart_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_state.dart';
import 'package:PassPort/version2_module/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails1 extends StatelessWidget {
  const ProductDetails1({super.key});

  static const String _placeholderImage = 'assets/images/ard_logo.png';

  @override
  Widget build(BuildContext context) {
    final id = (ModalRoute.of(context)?.settings.arguments) as String;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              ProductCubit()..getOneProductById(id: id),
        ),
        BlocProvider(create: (context) => CardCubit())
      ],
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          final GetProductOneById? item =
              ProductCubit.get(context).getProductOneById;
          final productData = item?.data;

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: state is getProductByIdLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: orange,
                        ),
                      )
                    : productData == null
                        ? Center(
                            child: Text(
                              "No products available",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          )
                        : CustomScrollView(
                            slivers: [
                              // Modern App Bar with image background
                              SliverAppBar(
                                expandedHeight: 400.h,
                                pinned: true,
                                backgroundColor: appBackgroundColor,
                                leading: Container(
                                  margin: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.black87,
                                      size: 20.r,
                                    ),
                                  ),
                                ),
                                flexibleSpace: FlexibleSpaceBar(
                                  background: _buildMainImage(productData),
                                ),
                              ),

                              // Product Details
                              SliverToBoxAdapter(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: appBackgroundColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.r),
                                      topRight: Radius.circular(30.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(24.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Product Name & Type
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                productData.productName ??
                                                    "N/A",
                                                style: TextStyle(
                                                  fontSize: 28.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            if (productData.productType != null)
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                  vertical: 6.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: accentColor.withValues(
                                                      alpha: 0.15),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                                child: Text(
                                                  productData.productType!,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: accentColor,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),

                                        SizedBox(height: 16.h),

                                        // Store Info
                                        if (productData.store != null &&
                                            productData.store!.isNotEmpty)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                              vertical: 12.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: accentColor.withValues(
                                                  alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.store_outlined,
                                                  color: accentColor,
                                                  size: 22.r,
                                                ),
                                                SizedBox(width: 12.w),
                                                Expanded(
                                                  child: Text(
                                                    productData.store!,
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: accentColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                        SizedBox(height: 24.h),

                                        // Price and Availability Row
                                        Row(
                                          children: [
                                            // Price
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(16.w),
                                                decoration: BoxDecoration(
                                                  color: accentColor.withValues(
                                                      alpha: 0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Price",
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.grey[600],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 6.h),
                                                    Text(
                                                      "${productData.price ?? 0} ${"booking.EGP".tr()}",
                                                      style: TextStyle(
                                                        fontSize: 24.sp,
                                                        color: accentColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 12.w),

                                            // Available Pieces
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(16.w),
                                                decoration: BoxDecoration(
                                                  color: Colors.green
                                                      .withValues(alpha: 0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Category",
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.grey[600],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 6.h),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .inventory_2_outlined,
                                                          color:
                                                              Colors.green[700],
                                                          size: 20.r,
                                                        ),
                                                        SizedBox(width: 6.w),
                                                        Text(
                                                          "${productData.productType ?? "Unknown"}",
                                                          style: TextStyle(
                                                            fontSize: 24.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .green[700],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        // Delivery Info
                                        if (productData.isDeliveryAvailable !=
                                            null)
                                          Padding(
                                            padding: EdgeInsets.only(top: 16.h),
                                            child: Container(
                                              padding: EdgeInsets.all(16.w),
                                              decoration: BoxDecoration(
                                                color: productData
                                                        .isDeliveryAvailable!
                                                    ? Colors.blue
                                                        .withValues(alpha: 0.1)
                                                    : Colors.red
                                                        .withValues(alpha: 0.1),
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    productData.isDeliveryAvailable!
                                                        ? Icons
                                                            .local_shipping_outlined
                                                        : Icons
                                                            .delivery_dining_outlined,
                                                    color: productData
                                                            .isDeliveryAvailable!
                                                        ? Colors.blue[700]
                                                        : Colors.red[700],
                                                    size: 24.r,
                                                  ),
                                                  SizedBox(width: 12.w),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          productData
                                                                  .isDeliveryAvailable!
                                                              ? "Delivery Available"
                                                              : "Pickup Only",
                                                          style: TextStyle(
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: productData
                                                                    .isDeliveryAvailable!
                                                                ? Colors
                                                                    .blue[700]
                                                                : Colors
                                                                    .red[700],
                                                          ),
                                                        ),
                                                        if (productData
                                                                .isDeliveryAvailable! &&
                                                            productData
                                                                    .shippingCost !=
                                                                null)
                                                          Text(
                                                            "Shipping: ${productData.shippingCost} EGP",
                                                            style: TextStyle(
                                                              fontSize: 13.sp,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                        SizedBox(height: 24.h),

                                        // Description
                                        if (productData.description != null &&
                                            productData.description!.isNotEmpty)
                                          _buildInfoSection(
                                            icon: Icons.description_outlined,
                                            title: "Description",
                                            content: productData.description!,
                                          ),

                                        // Important Information
                                        if (productData.importantInformation !=
                                                null &&
                                            productData.importantInformation!
                                                .isNotEmpty)
                                          _buildInfoSection(
                                            icon: Icons.info_outline,
                                            title: "Important Information",
                                            content: productData
                                                .importantInformation!,
                                            isWarning: true,
                                          ),

                                        // Rules and Cancellation
                                        if (productData
                                                    .rulesAndCancellationPolicy !=
                                                null &&
                                            productData
                                                .rulesAndCancellationPolicy!
                                                .isNotEmpty)
                                          _buildInfoSection(
                                            icon: Icons.rule_outlined,
                                            title:
                                                "Rules & Cancellation Policy",
                                            content: productData
                                                .rulesAndCancellationPolicy!,
                                          ),

                                        SizedBox(height: 100.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                bottomNavigationBar: productData != null
                    //  &&
                    //         (productData.availablePieces ?? 0) > 0
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 16.h,
                            ),
                            child: CustomButton(
                              text: "products.AddCard".tr(),
                              onPressed: () {
                                final newCard = CardModel(
                                  title: productData.productName ?? "N/A",
                                  description: productData.productType ?? "N/A",
                                  image:
                                      (productData.image?.isNotEmpty ?? false)
                                          ? productData.image!
                                          : _placeholderImage,
                                  store: productData.store ?? "Unknown Store",
                                  price: productData.price?.toDouble() ?? 0.0,
                                  productId: productData.id ?? "",
                                  pices: productData.availablePieces ?? 0,
                                  amount: 1,
                                );

                                context.read<CardCubit>().addCard(newCard);

                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Row(
                                //       children: [
                                //         Icon(
                                //           Icons.check_circle,
                                //           color: Colors.white,
                                //         ),
                                //         SizedBox(width: 12.w),
                                //         Text(
                                //           "Product added to cart",
                                //           style: TextStyle(
                                //             fontWeight: FontWeight.w600,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //     backgroundColor: accentColor,
                                //     behavior: SnackBarBehavior.floating,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(12.r),
                                //     ),
                                //     margin: EdgeInsets.all(16.w),
                                //     duration: const Duration(seconds: 2),
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String content,
    bool isWarning = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isWarning ? Colors.orange[700] : accentColor,
                size: 22.r,
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isWarning
                  ? Colors.orange.withValues(alpha: 0.05)
                  : Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isWarning
                    ? Colors.orange.withValues(alpha: 0.3)
                    : Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainImage(dynamic productData) {
    final imageUrl = productData.image;
    final bool hasValidImage =
        imageUrl != null && imageUrl.isNotEmpty && imageUrl.startsWith('http');

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: hasValidImage
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[100],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 80.r,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "No Image Available",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[100],
                  child: Center(
                    child: CircularProgressIndicator(
                      color: orange,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            )
          : Container(
              color: Colors.grey[100],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 80.r,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "No Image Available",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
