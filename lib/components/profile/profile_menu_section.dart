import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/profile/profile_menu_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appBackgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          ProfileMenuItem(
            title: 'profile.personalProfile'.tr(),
            icon: Icons.person_outline_rounded,
            routeName: 'travellerPersonalInfo',
            isFirst: true,
          ),
          buildDivider(),
          ProfileMenuItem(
            title: 'profile.order'.tr(),
            icon: Icons.receipt_long_outlined,
            routeName: 'orders',
          ),
          buildDivider(),
          ProfileMenuItem(
            title: 'profile.security'.tr(),
            icon: Icons.shield_outlined,
            routeName: 'accountSecurity',
          ),
          buildDivider(),
          ProfileMenuItem(
            title: 'profile.notification'.tr(),
            icon: Icons.notifications_outlined,
            routeName: 'notificationSettings',
          ),
          buildDivider(),
          ProfileMenuItem(
            title: 'profile.help'.tr(),
            icon: Icons.help_outline_rounded,
            routeName: 'help',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.shade200,
      ),
    );
  }
}
