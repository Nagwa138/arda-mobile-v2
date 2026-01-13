// removed unused easy_localization import
import 'package:PassPort/components/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'menu_item.dart';

class MenuDrawer extends StatelessWidget {
  final Function(String)? onMenuItemSelected;

  const MenuDrawer({super.key, this.onMenuItemSelected});

  Future<void> _handleSwitchToTraveller(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Switch to Traveller',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: appTextColor,
            ),
          ),
          content: Text(
            'Are you sure you want to switch to traveller mode?',
            style: TextStyle(
              fontSize: 14.sp,
              color: appTextColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: appTextColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close drawer

                // Update userType to traveller (0)
                const storage = FlutterSecureStorage();
                await storage.write(key: "userType", value: "0");

                // Navigate to traveller interface
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'travellerNavBar',
                  (route) => false,
                );
              },
              child: Text(
                'Switch',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: appTextColor,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontSize: 14.sp,
              color: appTextColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: appTextColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close drawer

                // Clear stored data
                const storage = FlutterSecureStorage();
                await storage.delete(key: "token");
                await storage.delete(key: "userName");
                await storage.delete(key: "email");
                await storage.delete(key: "userType");

                // Navigate to login/register screen
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'register',
                  (route) => false,
                );
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFBF0E3),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'The ARD Dashboard',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: appTextColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: appTextColor,
                        size: 24.sp,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                // Menu Section
                Text(
                  'MENU',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 1.2,
                  ),
                ),

                SizedBox(height: 20.h),

                // Menu Items
                MenuItem(
                  icon: Icons.add_business,
                  title: 'Add Service',
                  isSelected: true,
                  onTap: () {
                    onMenuItemSelected?.call('Add Service');
                  },
                ),

                MenuItem(
                  icon: Icons.home_work,
                  title: 'My Services',
                  onTap: () {
                    onMenuItemSelected?.call('My Services');
                  },
                ),

                MenuItem(
                  icon: Icons.book_online,
                  title: 'My Bookings',
                  onTap: () {
                    onMenuItemSelected?.call('My Bookings');
                  },
                ),

                MenuItem(
                  icon: Icons.notifications,
                  title: 'Notification',
                  onTap: () {
                    onMenuItemSelected?.call('Notification');
                  },
                ),

                SizedBox(height: 30.h),

                // Others Section
                Text(
                  'OTHERS',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 1.2,
                  ),
                ),

                SizedBox(height: 20.h),

                // MenuItem(
                //   icon: Icons.settings,
                //   title: 'Settings',
                //   onTap: () {
                //     onMenuItemSelected?.call('Settings');
                //   },
                // ),

                MenuItem(
                  icon: Icons.monetization_on,
                  title: 'Earnings',
                  onTap: () {
                    onMenuItemSelected?.call('Partner Dashboard');
                  },
                ),

                // MenuItem(
                //   icon: Icons.swap_horiz,
                //   title: 'Switch to Traveller',
                //   onTap: () {
                //     _handleSwitchToTraveller(context);
                //   },
                // ),

                SizedBox(height: 40.h),

                // Logout Button
                GestureDetector(
                  onTap: () => _handleLogout(context),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
