import 'dart:async';
import 'dart:convert';

import 'package:PassPort/version2_module/core/const/app_colors.dart';
import 'package:PassPort/version2_module/core/enums/user_type.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customText.dart';
import 'package:PassPort/main.dart';
import 'package:PassPort/screens/auth/registration/register.dart';
import 'package:PassPort/screens/onBoarding/onboarding.dart';
import 'package:page_transition/page_transition.dart';
import 'package:PassPort/screens/partner/landinHome/landingHome.dart';
import 'package:PassPort/screens/traveller/homeTravellingNavBar/homeTravellingNavBar.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';
import 'package:PassPort/consts/api/api.dart';

final storage = new FlutterSecureStorage();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _showLogo = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      // Dramatic and slower animation
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      // Even smoother curve
      curve: Curves.easeInOutCubic,
    ));

    // Longer initial delay before showing the logo
    Future.delayed(Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _showLogo = true;
        });
        // Start the animation cycle
        _animationController.forward(from: 0.0);
      }
    });

    // Setup animation cycle
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Hold the fully visible state for a moment
        Future.delayed(Duration(milliseconds: 800), () {
          if (mounted) _animationController.reverse(from: 1.0);
        });
      } else if (status == AnimationStatus.dismissed) {
        // Hold the completely invisible state for a moment
        Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) _animationController.forward(from: 0.0);
        });
      }
    });

    Timer(const Duration(seconds: 5), () async {
      _animationController.stop();
      await _handleNavigation();
    });
  }

  Future<void> _handleNavigation() async {
    try {
      print('DEBUG: _handleNavigation started');
      print('DEBUG: Current userType: $userType');
      print('DEBUG: Current token: ${token?.substring(0, 20)}...');

      if (userType == '' || token == null) {
        print('DEBUG: No userType or token, navigating to login');
        Navigator.pushReplacementNamed(context, 'login');
        return;
      }

      // تحقق من كل أنواع الشركاء
      if (['1', '3', '4', '5', '6'].contains(userType)) {
        print('DEBUG: User is a partner type, calling _getPartnerInfo');
        final partnerInfo = await _getPartnerInfo();

        if (partnerInfo != null) {
          print('DEBUG: Partner info received: $partnerInfo');
          final generalStatus = partnerInfo['genralStatus'];
          final userTypeFromApi = partnerInfo['userType'];
          final tokenFromApi = partnerInfo['token'];

          print('DEBUG: generalStatus: $generalStatus');
          print('DEBUG: userTypeFromApi: $userTypeFromApi');
          print('DEBUG: tokenFromApi: ${tokenFromApi?.substring(0, 20)}...');

          // تحديث الـ userType في storage لو اتغير
          if (userTypeFromApi != null &&
              userTypeFromApi.toString() != userType) {
            print(
                'DEBUG: Updating userType from $userType to $userTypeFromApi');
            await storage.write(
                key: "userType", value: userTypeFromApi.toString());
            userType = userTypeFromApi.toString();
          }

          // تحديث التوكين لو فيه جديد
          if (tokenFromApi != null &&
              tokenFromApi.toString().isNotEmpty &&
              tokenFromApi != token) {
            print('DEBUG: Updating token');
            await storage.write(key: "token", value: tokenFromApi.toString());
            token = tokenFromApi.toString();
          }

          // لو الشريك مفعل
          if (generalStatus == 0) {
            print(
                'DEBUG: Partner is active (status: 0), calling _navigateBasedOnUserType');
            _navigateBasedOnUserType(userTypeFromApi);
          } else  {
            print(
                'DEBUG: Partner is not active (status: $generalStatus), navigating to traveller');
            Navigator.pushReplacementNamed(context, 'travellerNavBar');
          }
          return;
        } else {
          print('DEBUG: Partner info is null, using fallback navigation');
        }
      }

      // fallback: لو Traveler أو أي حالة أخرى
      print('DEBUG: Using fallback navigation logic');
      if (userType == '0') {
        print('DEBUG: User is traveller, navigating to travellerNavBar');
        Navigator.pushReplacementNamed(context, 'travellerNavBar');
      } else if (userType == '2') {
        print('DEBUG: User is admin, navigating to homeAdmin');
        Navigator.pushReplacementNamed(context, 'homeAdmin');
      } else {
        print('DEBUG: Unknown user type, navigating to login');
        Navigator.pushReplacementNamed(context, 'login');
      }
    } catch (e) {
      print('Error in navigation: $e');
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  Future<Map<String, dynamic>?> _getPartnerInfo() async {
    try {
      print('DEBUG: Calling PartenerInfo API...');
      final response = await ApiConsumer().get(
        uri: "${Api.API_URL}Accounts",
        token: token,
      );

      print('DEBUG: API Response Status: ${response.statusCode}');
      print('DEBUG: API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('DEBUG: Parsed API Response: $data');

        // Check if response has wrapper structure or direct data
        if (data['statusCode'] == 200 && data['data'] != null) {
          print(
              'DEBUG: Wrapper structure detected, returning data: ${data['data']}');
          return data['data'];
        } else {
          // Direct response structure (no wrapper)
          print(
              'DEBUG: Direct response structure detected, returning data directly');
          return data;
        }
      } else {
        print('DEBUG: API call failed with status: ${response.statusCode}');
      }
      return null;
    } catch (e) {
      print('Error getting partner info: $e');
      return null;
    }
  }

  void _navigateBasedOnUserType(int userTypeId) {
    try {
      print(
          'DEBUG: _navigateBasedOnUserType called with userTypeId: $userTypeId');
      print('DEBUG: userTypeId type: ${userTypeId.runtimeType}');

      // Handle different partner types
      switch (userTypeId) {
        case 1:
          print(
              'DEBUG: General partner detected (userType=1), navigating to partnerMobileDashboard');
          Navigator.pushReplacementNamed(context, 'partnerMobileDashboard');
          break;
        case 3:
          print(
              'DEBUG: Accommodation partner detected (userType=3), navigating to partnerMobileDashboard');
          Navigator.pushReplacementNamed(context, 'partnerMobileDashboard');
          break;
        case 4:
          print(
              'DEBUG: Activity partner detected (userType=4), navigating to partnerMobileDashboard');
          Navigator.pushReplacementNamed(context, 'partnerMobileDashboard');
          break;
        case 5:
          print(
              'DEBUG: Trip partner detected (userType=5), navigating to partnerMobileDashboard');
          Navigator.pushReplacementNamed(context, 'partnerMobileDashboard');
          break;
        case 6:
          print(
              'DEBUG: Product partner detected (userType=6), navigating to partnerMobileDashboard');
          Navigator.pushReplacementNamed(context, 'partnerMobileDashboard');
          break;
        default:
          print(
              'DEBUG: Unknown user type ($userTypeId), navigating to traveller');
          Navigator.pushReplacementNamed(context, 'travellerNavBar');
          break;
      }
    } catch (e) {
      print('Error parsing user type: $e');
      print('Error stack trace: ${StackTrace.current}');
      // Default to traveller if there's an error
      Navigator.pushReplacementNamed(context, 'travellerNavBar');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  // image: DecorationImage(
                  //   image: AssetImage(
                  //       "assets/images/splash/photo_2025-06-26_21-30-33.jpg"),
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'login');
                      },
                      child: _showLogo
                          ? FadeTransition(
                              opacity: _fadeAnimation,
                              child: Image.asset("assets/images/ard_logo.png",
                                  height: 350, width: 350),
                            )
                          : SizedBox(height: 350, width: 350),
                    ),

                    // CustomText(
                    //     text: "Anti-Afrocentric#",
                    //     size: 14.sp,
                    //     color: white,
                    //     fontWeight: FontWeight.w700)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
