import 'package:PassPort/components/color/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class ProfileTravelller extends StatelessWidget {
  const ProfileTravelller({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              // Modern App Bar with Image
              SliverAppBar(
                expandedHeight: 280.h,
                pinned: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/home2.jpeg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              appBackgroundColor,
                            ],
                            stops: [0.6, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),

                      // Title
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Manage your account and preferences',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Partner Invitation Card
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'partnerRegisterV2');
                        },
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF4A90E2),
                                Color(0xFF357ABD),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF4A90E2).withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.handshake_outlined,
                                  color: Colors.white,
                                  size: 28.sp,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Become a Partner',
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Join our family and grow with us',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Colors.white.withValues(alpha: 0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 28.h),

                      // Menu Items Container
                      Container(
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
                            listTileBuilder(
                              context,
                              title: 'profile.personalProfile'.tr(),
                              icon: Icons.person_outline_rounded,
                              routeName: 'travellerPersonalInfo',
                              isFirst: true,
                            ),
                            _buildDivider(),
                            listTileBuilder(
                              context,
                              title: 'profile.order'.tr(),
                              icon: Icons.receipt_long_outlined,
                              routeName: 'orders',
                            ),
                            _buildDivider(),
                            listTileBuilder(
                              context,
                              title: 'profile.security'.tr(),
                              icon: Icons.shield_outlined,
                              routeName: 'accountSecurity',
                            ),
                            _buildDivider(),
                            listTileBuilder(
                              context,
                              title: 'profile.notification'.tr(),
                              icon: Icons.notifications_outlined,
                              routeName: 'notificationSettings',
                            ),
                            _buildDivider(),
                            listTileBuilder(
                              context,
                              title: 'profile.help'.tr(),
                              icon: Icons.help_outline_rounded,
                              routeName: 'help',
                              isLast: true,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Logout Button
                      GestureDetector(
                        onTap: () async {
                          // Show confirmation dialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: accentColor,
                                ),
                              ),
                              content: Text(
                                'Are you sure you want to logout?',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await storage.delete(key: "token");
                                    await storage.delete(key: "userType");
                                    Navigator.pushReplacementNamed(
                                        context, 'login');
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.red.shade200,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                color: Colors.red.shade600,
                                size: 24.sp,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'profile.logout'.tr(),
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.shade200,
      ),
    );
  }

  Widget listTileBuilder(
    BuildContext context, {
    required String title,
    required IconData icon,
    String? routeName,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: () {
        if (routeName != null) {
          Navigator.pushNamed(context, routeName);
        }
      },
      borderRadius: BorderRadius.vertical(
        top: isFirst ? Radius.circular(20.r) : Radius.zero,
        bottom: isLast ? Radius.circular(20.r) : Radius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: accentColor,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Arrow
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black38,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
