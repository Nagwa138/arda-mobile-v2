import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customText.dart';

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
              index: 0, title: "The Glamorous accommodation:", subtitle: "Camping Just Got Glamorous, Forget the lumpy sleeping bags and burnt marshmallows. Experience the luxury of glamping alongside unique camping adventures and boutique hotels", image: "assets/images/traveller/accomodtion2.jpg"),
          onboardingBuilder(context,
              index: 1, title: "Golden Hands", subtitle: "explore local products that tell a identity of a place.. ", image: "assets/images/traveller/products2.jpeg"),
          onboardingBuilder(context,
              index: 2, title: 'your adventures'.tr(), subtitle: "Adventure Awaits: Book Your Thrills, Create Unforgettable Memories.", image: "assets/images/traveller/activity2.jpeg"),
          onboardingBuilder(context,
              index: 4, title: "Journey planner", subtitle: "book amazing trips, and discover hidden gems With reliable tour guide and travel companies", image: "assets/images/traveller/trips2.jpeg"),

        ],
      ),
    );
  }

  Widget onboardingBuilder(BuildContext context, {required int index, required String title, required String subtitle, required String image}) {
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
              CustomText(
                text: 'onboarding.skip'.tr(),
                size: 18.sp,
                color: white,
                fontWeight: FontWeight.w400,
                alignment: Alignment.centerRight,
                textDecoration: TextDecoration.underline,
                function: () {
                  Navigator.pushReplacementNamed(context, 'register');
                },
              ),
          
              Image.asset("assets/images/ard_logo.png"),
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
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
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
                    onPressed: () {
                      if (index != 4) {
                        onBoardingController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      } else {
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
