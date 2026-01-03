import 'package:PassPort/components/color/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            backgroundColor: appBackgroundColor,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'help.title'.tr(),
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
          ),
          body: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 20.w,
                ),
                title: Text(
                  'help.item1'.tr(),
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
                  Navigator.pushNamed(context, 'FAQS');
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 20.w,
                ),
                title: Text(
                  'help.item2'.tr(),
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
                  Navigator.pushNamed(context, 'termConditions');
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 20.w,
                ),
                title: Text(
                  'help.item3'.tr(),
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
                  Navigator.pushNamed(context, 'contactUs');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
