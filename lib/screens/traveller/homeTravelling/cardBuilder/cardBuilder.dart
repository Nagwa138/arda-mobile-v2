import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

// Define new colors
const Color backgroundColor = Color(0xFFFBF0E3);
const Color accentColor = Color(0xFF161651);

class CardBuilder extends StatefulWidget {
  final String type;
  final String name;
  final String location;
  final String price;
  final List image;
  final String rate;
  final int index;
  final VoidCallback function;
  final String id;
  final VoidCallback functionCheck;

  final bool isFavourite;
  const CardBuilder(
      {super.key,
      required this.type,
      required this.name,
      required this.location,
      required this.price,
      required this.index,
      required this.function,
      required this.functionCheck,
      required this.id,
      required this.image,
      required this.rate,
      required this.isFavourite});

  @override
  State<CardBuilder> createState() => _CardBuilderState();
}

class _CardBuilderState extends State<CardBuilder> {
  PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.w),
      width: 230.w,
      decoration: ShapeDecoration(
        color: backgroundColor, // Changed to new background color
        shadows: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 12.r,
            offset: Offset(3, 4),
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 200.h,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: widget.image.length,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    child: Image.network(
                      widget.image[index]!,
                      height: 200.h,
                      width: 1.sw,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 190.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 14.h),
                      child: Row(
                        children: [
                          Opacity(
                            opacity: 0.70,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 3.h),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                widget.type,
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: widget.function,
                            child: Icon(
                              Icons.favorite,
                              color: widget.isFavourite
                                  ? Colors.red
                                  : Colors.white,
                              size: 22.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.image.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          width: 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPage == index ? white : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 140.w,
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          color: accentColor, // Using accent color
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 16.sp,
                    ),
                    Text(
                      widget.rate,
                      style: TextStyle(
                        color: accentColor, // Changed to accent color
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: accentColor, // Changed to accent color
                      size: 16.sp,
                    ),
                    Text(
                      '${widget.location}, Egypt',
                      style: TextStyle(
                        color: accentColor, // Changed to accent color
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  '${widget.price} ${context.locale.languageCode == 'ar' ? "جنيه / ليلة" : "EGP / Night"}',
                  style: TextStyle(
                    color: accentColor, // Changed to accent color
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: widget.functionCheck,
            child: Container(
              height: 38.h,
              width: 1.sw,
              decoration: BoxDecoration(
                color: accentColor, // Changed to accent color
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1E000000),
                    blurRadius: 35.r,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Center(
                child: Text(
                  'travellerHome.check'.tr(),
                  style: TextStyle(
                    color:
                        backgroundColor, // Changed to background color for contrast
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
