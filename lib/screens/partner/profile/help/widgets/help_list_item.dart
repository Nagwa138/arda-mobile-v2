import 'package:PassPort/components/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpListItem extends StatelessWidget {
  final String title;
  final String route;

  const HelpListItem({
    super.key,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white.withOpacity(0.7),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: 5.h,
              horizontal: 20.w,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: accentColor,
              size: 20.sp,
            ),
            onTap: () {
              Navigator.pushNamed(context, route);
            },
          ),
        ),
    );
  }
}
