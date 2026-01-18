import 'package:PassPort/components/color/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBackgroundColor,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Navigator.maybePop(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: black,
          size: 20.sp,
        ),
      ),
      centerTitle: true,
      title: Text(
        "booking.booking".tr(),
        style: TextStyle(
          color: black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
