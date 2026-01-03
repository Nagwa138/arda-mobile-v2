import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/version2_module/core/enums/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../cubit/partner_dashboard_cubit.dart';
import '../cubit/partner_dashboard_state.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/statistics_card.dart';
import 'partner_bookings_screen.dart';
import 'partner_services_screen.dart';

class PartnerMobileDashboardScreen extends StatefulWidget {
  const PartnerMobileDashboardScreen({super.key});

  @override
  State<PartnerMobileDashboardScreen> createState() =>
      _PartnerMobileDashboardScreenState();
}

class _PartnerMobileDashboardScreenState
    extends State<PartnerMobileDashboardScreen> {
  String userName = 'Partner';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    try {
      const storage = FlutterSecureStorage();
      final storedUserName = await storage.read(key: "userName");
      if (storedUserName != null && storedUserName.isNotEmpty) {
        setState(() {
          userName = storedUserName;
        });
      }
    } catch (e) {
      print('Error loading username: $e');
      // Keep default username if error occurs
    }
  }

  // Method to get partner type from storage and navigate to appropriate service form
  Future<void> _navigateToAddService(BuildContext context) async {
    try {
      final storage = FlutterSecureStorage();
      final userTypeString = await storage.read(key: "userType");

      if (userTypeString != null) {
        final userTypeId = int.parse(userTypeString.toString());
        final userType = UserType.fromId(userTypeId);

        // Check if user type is accommodation
        if (userType == UserType.accommodation) {
          print(
              'Accommodation user type detected, navigating to addAccommodation');
          Navigator.pushNamed(context, 'addAccommodation');
          // Navigator.pushNamed(context, 'dynamicForm',
          //     arguments: {'partnerType': userType.partnerTypeKey});
        } else {
          print(
              'Non-accommodation user type detected, navigating to dynamicForm');
          Navigator.pushNamed(context, 'dynamicForm',
              arguments: {'partnerType': userType.partnerTypeKey});
        }
      } else {
        // Default navigation if no user type found
        print('No user type found, defaulting to dynamicForm');
        Navigator.pushNamed(context, 'dynamicForm');
      }
    } catch (e) {
      print('Error in _navigateToAddService: $e');
      // Error handling - default to dynamicForm
      Navigator.pushNamed(context, 'dynamicForm',
          arguments: {'partnerType': UserType.accommodation.partnerTypeKey});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartnerDashboardCubit()..loadDashboardData(),
      child: BlocConsumer<PartnerDashboardCubit, PartnerDashboardState>(
        listener: (context, state) {
          if (state is MenuItemSelected) {
            _handleMenuSelection(context, state.selectedItem);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFF2C8B8B),
            appBar: AppBar(
              backgroundColor: const Color(0xFF2C8B8B),
              elevation: 0,
              centerTitle: false,
              title: Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'travellerNotification');
                  },
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout, size: 20.sp, color: Colors.red),
                          SizedBox(width: 8.w),
                          Text('Logout', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    _handlePopupMenuSelection(context, value);
                  },
                ),
              ],
            ),
            drawer: MenuDrawer(
              onMenuItemSelected: (menuItem) {
                context.read<PartnerDashboardCubit>().selectMenuItem(menuItem);
                Navigator.pop(context); // Close drawer after selection
              },
            ),
            body: _buildMobileBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildMobileBody(BuildContext context, PartnerDashboardState state) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFBF0E3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            _buildWelcomeSection(),

            SizedBox(height: 30.h),

            // Quick Actions
            _buildQuickActions(context),

            SizedBox(height: 30.h),

            // Statistics
            Expanded(
              child: _buildMobileStatistics(context, state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            appTextColor.withValues(alpha: 0.1),
            appTextColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi $userName 👋',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: appTextColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Welcome back to your dashboard',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: appTextColor.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 25.r,
            backgroundColor: appTextColor,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: appTextColor,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Add Service',
                Icons.add_business,
                () => _navigateToAddService(context),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildActionCard(
                'My Services',
                Icons.home_work,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PartnerServicesScreen(),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildActionCard(
                'Bookings',
                Icons.book_online,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PartnerBookingsScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: appTextColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: appTextColor,
                size: 20.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: appTextColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileStatistics(
      BuildContext context, PartnerDashboardState state) {
    if (state is DashboardLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: appTextColor,
        ),
      );
    }

    Map<String, dynamic> stats = {};
    if (state is DashboardLoaded) {
      stats = state.stats;
    } else {
      // Default stats for initial load
      stats = {
        'totalEarnings': 'Soon',
        'totalBookings': 'Soon',
        'confirmed': 'Soon',
        'rejected': 'Soon',
        'pending': 'Soon',
      };
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Statistics',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: appTextColor,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                context.read<PartnerDashboardCubit>().refreshDashboard();
              },
              icon: Icon(Icons.refresh, size: 16.sp),
              label: Text(
                'Refresh',
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Statistics Grid - Mobile optimized
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.1,
            children: [
              StatisticsCard(
                title: 'Total\nEarnings',
                // value: stats['totalEarnings'] ?? 'Soon',
                value: 'Soon',
                backgroundColor: const Color(0xFFE6B87D),
              ),
              StatisticsCard(
                title: 'Total\nBookings',
                // value: stats['totalBookings'] ?? 'Soon',
                value: 'Soon',
                backgroundColor: const Color(0xFFD9A7A7),
              ),
              StatisticsCard(
                title: 'Confirmed',
                // value: stats['confirmed'] ?? 'Soon',
                value: 'Soon',

                backgroundColor: const Color(0xFFA7D9A7),
              ),
              StatisticsCard(
                title: 'Rejected',
                // value: stats['rejected'] ?? 'Soon',
                value: 'Soon',

                backgroundColor: const Color(0xFFB0B0B0),
              ),
            ],
          ),
        ),

        // Pending Card (full width)
        // Container(
        //   width: double.infinity,
        //   height: 80.h,
        //   child: StatisticsCard(
        //     title: 'Pending Requests',
        //     value: stats['pending'] ?? '0',
        //     backgroundColor: const Color(0xFFE6A07D),
        //   ),
        // ),
      ],
    );
  }

  void _handleMenuSelection(BuildContext context, String selectedItem) {
    switch (selectedItem.toLowerCase()) {
      case 'add service':
        _navigateToAddService(context);
        break;
      case 'my services':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PartnerServicesScreen(),
          ),
        );
        break;
      case 'my bookings':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PartnerBookingsScreen(),
          ),
        );
        break;
      case 'notification':
        Navigator.pushNamed(context, 'travellerNotification');
        break;
      case 'settings':
        // Navigate to settings
        break;
      case 'earnings':
        // Navigate to earnings
        break;
      // case 'support':
      //   // Navigate to support
      //   break;
    }
  }

  void _handlePopupMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'logout':
        // Handle logout
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
                    Navigator.pop(context);

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
        break;
    }
  }
}
