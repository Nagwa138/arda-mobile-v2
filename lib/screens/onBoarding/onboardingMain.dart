import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/consts/cache manger/cache.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PageController onBoardingController = PageController();

class OnBoardingMain extends StatelessWidget {
  OnBoardingMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: PageView(
        controller: onBoardingController,
        children: [
          onboardingBuilder(context,
              index: 0,
              title: "Unique Stays",
              subtitle:
                  "Stay in places that tell a story. From desert camps to heritage homes, each stay is carefully selected to reflect local culture, nature, and a sense of place. This is not accommodation. This is belonging.",
              image: "assets/images/accomodtion2.jpg"),
          onboardingBuilder(context,
              index: 1,
              title: "Golden Hands",
              subtitle:
                  "Crafted by culture, made by people. Discover handmade pieces created by local artisans. Every item carries heritage, skill, and a human story. You're not buying a product. You're preserving a craft.",
              image: "assets/images/products2.jpeg"),
          onboardingBuilder(context,
              index: 2,
              title: "Adventures",
              subtitle:
                  "Go beyond sightseeing. Explore experiences designed by locals, from desert journeys to hidden paths and cultural encounters. Real adventures, built around people, land, and moments you won't find in guidebooks.",
              image: "assets/images/activity2.jpeg"),
          onboardingBuilder(context,
              index: 4,
              title: "Journey Planner",
              subtitle:
                  "Travel, thoughtfully designed. Plan your journey with smart suggestions tailored to your interests, timing, and travel style. Every step is intentional, seamless, and built around how you actually want to move.",
              image: "assets/images/trips2.jpeg"),
        ],
      ),
    );
  }

  Widget onboardingBuilder(BuildContext context,
      {required int index,
      required String title,
      required String subtitle,
      required String image}) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 38.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  // Mark onboarding as completed when skipping
                  await CacheManger.setOnboardingCompleted();
                  Navigator.pushReplacementNamed(context, 'register');
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'onboarding.skip'.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Image.asset("assets/images/logo.png"),
              // SizedBox(
              //   height: 10.h,
              // ),
              // CustomText(text: 'slogan'.tr(), size: 8.sp, color: white, fontWeight: FontWeight.w700),
              // Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20.r),
                  color: Color(0x58FFFFFF),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              CircleAvatar(
                backgroundColor: accentColor,
                radius: 30,
                child: ClipOval(
                  child: IconButton(
                    onPressed: () async {
                      if (index != 4) {
                        onBoardingController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      } else {
                        // Mark onboarding as completed
                        await CacheManger.setOnboardingCompleted();
                        Navigator.pushReplacementNamed(context, 'register');
                      }
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
