import 'package:PassPort/components/color/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingTabButton extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback onTap;

  const BookingTabButton({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    lightBrown.withOpacity(0.2),
                    lightBrown.withOpacity(0.05),
                    Colors.transparent,
                  ],
                )
              : null,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? lightBrown : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          title.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? lightBrown : Colors.grey,
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
