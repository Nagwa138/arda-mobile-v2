import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/background_container.dart';
import 'package:PassPort/screens/partner/profile/help/widgets/help_list_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundContainer(),
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
              SizedBox(height: 16.h),
              HelpListItem(
                title: 'help.item1'.tr(),
                route: 'FAQS',
              ),
              HelpListItem(
                title: 'help.item2'.tr(),
                route: 'termConditions',
              ),
              HelpListItem(
                title: 'help.item3'.tr(),
                route: 'contactUs',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
