import 'package:PassPort/components/color/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class ProfileLanding extends StatelessWidget {
  const ProfileLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/auth/Intersect.png',
                      fit: BoxFit.cover,
                      height: 200.h,
                      width: double.infinity,
                    ),
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/ard_logo.png",
                          height: 200.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          // SizedBox(height: 10.h),
          // listTileBuilder(
          //   context,
          //   title: 'Join Our family and become one of our partners',
          //   icon: Icons.switch_account,
          //   routeName: 'personalProfile',
          //   isGradient: true,
          // ),
          listTileBuilder(
            context,
            title: 'profile.personalProfile'.tr(),
            icon: Icons.person,
            routeName: 'personalProfile',
          ),
          listTileBuilder(
            context,
            title: 'profile.profits'.tr(),
            icon: Icons.monetization_on,
            routeName: 'profits',
          ),

          listTileBuilder(
            context,
            title: 'profile.security'.tr(),
            icon: Icons.security,
            routeName: 'accountSecurity',
          ),
          listTileBuilder(
            context,
            title: 'profile.notification'.tr(),
            icon: Icons.notifications,
            routeName: 'notificationSettings',
          ),
          listTileBuilder(
            context,
            title: 'profile.help'.tr(),
            icon: Icons.help,
            routeName: 'help',
          ),

          //logout
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () async {
              await storage.delete(key: "token");
              await storage.delete(key: "userType");
              Navigator.pushReplacementNamed(context, 'register');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 25.sp,
                ),
                Text(
                  'profile.logout'.tr(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget listTileBuilder(BuildContext context,
      {required String title,
      required IconData icon,
      String? routeName,
      bool isGradient = false}) {
    return ListTile(
      onTap: () {
        if (routeName != null) {
          Navigator.pushNamed(context, routeName);
        }
      },
      leading: isGradient
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: white, size: 25.sp),
            )
          : Icon(icon, color: black, size: 25.sp),
      title: Text(
        title,
        style: TextStyle(
          color: black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: black,
        size: 20.sp,
      ),
    );
  }
}
