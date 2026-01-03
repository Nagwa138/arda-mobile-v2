import 'package:PassPort/models/traveller/randomProduct/random_product.dart'
    as product_model;
import 'package:PassPort/version2_module/features/home/view/screens/products_list_page.dart';
import 'package:PassPort/version2_module/features/home/view/widget/product_card.dart';
import 'package:PassPort/version2_module/features/home/view/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../components/color/color.dart';
import '../../view_model/products_cubit.dart';
import '../../view_model/products_state.dart';

class GoldenHandsSection extends StatelessWidget {
  const GoldenHandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsSuccess) {
          if (state.products.isEmpty) {
            return const SizedBox.shrink();
          }
          return _buildSection(
            context: context,
            title: 'Golden Hands',
            subtitle: 'Handcrafted treasures that reflect Egypt\'s soul',
            products: state.products,
          );
        }

        if (state is ProductsError) {
          return _buildErrorState(state.message);
        }

        return _buildLoadingSection(
          title: 'Golden Hands',
          subtitle: '',
        );
      },
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required String subtitle,
    required List products,
  }) {
    // Limit to 5 items for home screen
    final displayProducts = products.take(5).toList();

    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header with See More
          SectionHeader(
            title: 'Golden Hands',
            onSeeMoreTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsListPage(products: products),
                ),
              );
            },
          ),

          SizedBox(height: 20.h),

          // Horizontal Scroll List like Activities
          SizedBox(
            height: 370.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: displayProducts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: ProductCard(
                    product: displayProducts[index],
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        'productDetails1',
                        arguments: displayProducts[index].id,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSection({
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: accentColor,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // Skeleton Grid - Fixed dummy data
          Skeletonizer(
            enabled: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  // Create dummy product with proper String image
                  return ProductCard(
                    product: product_model.Data(
                      productName: 'Loading Product',
                      price: 100,
                      rate: 4.5,
                      store: 'Store Name',
                      image: '', // Empty string instead of null
                      productType: 'Type',
                      isFav: false,
                      avilablePieces: 10,
                      amount: 1,
                      id: 'loading-$index',
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade700, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
