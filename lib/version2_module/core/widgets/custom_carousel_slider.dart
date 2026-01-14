import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/color/color.dart';
import '../../../components/widgets/custom_image.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({
    super.key,
    required this.images,
    this.height,
    this.placeholderImage = 'assets/images/ard_logo.png',
  });

  final List<String> images;
  final double? height;
  final String placeholderImage;

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    // Use dummy images if provided list is empty
    final List<String> displayImages = widget.images.isEmpty
        ? [
            'https://zadnaeg.com/wp-content/uploads/2017/06/wood-blog-placeholder.jpg',
            'https://zadnaeg.com/wp-content/uploads/2017/06/wood-blog-placeholder.jpg',
            'https://zadnaeg.com/wp-content/uploads/2017/06/wood-blog-placeholder.jpg',
          ]
        : widget.images;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Carousel Slider
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: displayImages.length,
          options: CarouselOptions(
            height: widget.height ?? double.infinity,
            viewportFraction: 1.0,
            enlargeCenterPage: true,
            // scrollPhysics: const BouncingScrollPhysics(),
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: displayImages.length > 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            }),
          itemBuilder: (context, index, realIndex) {
            return _buildImageItem(displayImages[index]);
          }),

        // Numbered Indicators
        if (displayImages.length > 1)
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: _buildNumberedIndicators(displayImages.length)),

        // Magnifier Icon
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: GestureDetector(
            onTap: () => _showImageZoom(context, displayImages[_currentIndex]),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2)),
                ]),
              child: Icon(
                Icons.zoom_in,
                color: Colors.white,
                size: 25.sp)))),
      ]);
  }

  void _showImageZoom(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Center(
                child: CustomImage(
                  imageUrl,
                  fit: BoxFit.contain))),
            Positioned(
              top: 40.h,
              right: 16.w,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12.r),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.2))),
                  child: Icon(Icons.close, color: Colors.white, size: 22.sp)))),
          ])));
  }

  Widget _buildImageItem(String imageUrl) {
    return CustomImage(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      errorWidget: Container(
        color: Colors.grey[100],
        child: Center(
          child: CustomImage(
            widget.placeholderImage,
            fit: BoxFit.contain,
            width: 150.w))));
  }

  Widget _buildNumberedIndicators(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final bool isActive = index == _currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 12.w : 8.w,
          height: isActive ? 12.h : 8.h,
          decoration: BoxDecoration(
            color: isActive ? white : white.withValues(alpha: 0.5),
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 1)),
                  ]
                : null));
      }));
  }
}
