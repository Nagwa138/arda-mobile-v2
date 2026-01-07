import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/color/color.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({
    super.key,
    required this.images,
    this.height,
    this.showGradient = true,
    this.placeholderImage = 'assets/images/ard_logo.png',
  });

  final List<String> images;
  final double? height;
  final bool showGradient;
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
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return _buildImageItem(displayImages[index]);
          },
        ),

        // Gradient Overlay
        if (widget.showGradient)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.4),
                  ],
                ),
              ),
            ),
          ),

        // Numbered Indicators
        if (displayImages.length > 1)
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: _buildNumberedIndicators(displayImages.length),
          ),
      ],
    );
  }

  Widget _buildImageItem(String imageUrl) {
    final bool isNetworkImage = imageUrl.startsWith('http');

    return isNetworkImage
        ? Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                    color: accentColor,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[100],
              child: Center(
                child: Image.asset(
                  widget.placeholderImage,
                  fit: BoxFit.contain,
                  width: 150.w,
                ),
              ),
            ),
          )
        : Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[100],
              child: Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 80.r,
                  color: Colors.grey[400],
                ),
              ),
            ),
          );
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
          width: isActive ? 10.w : 8.w,
          height: isActive ? 10.h : 8.h,
          decoration: BoxDecoration(
            color: isActive ? white : white.withValues(alpha: 0.5),
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
