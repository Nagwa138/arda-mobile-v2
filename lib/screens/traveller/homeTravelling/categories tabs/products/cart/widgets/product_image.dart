import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          ? CustomImage(
              imageUrl,
              width: 85.w,
              height: 110.h,
              fit: BoxFit.cover,
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
