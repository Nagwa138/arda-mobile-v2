import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customButton/customButton.dart';
import 'package:PassPort/components/widgets/customText.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/homeTravellerNavBarCubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/homeTravellerNavBarStates.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context)=>HomeTravellerNavBarCubit(),
      child: BlocConsumer<HomeTravellerNavBarCubit,HomeTravellerNavBarStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: appBackgroundColor,

            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/auth/image3.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 70.h,
                  ),
                  Image.asset("assets/images/ard_logo.png"),

                  // Image.asset(
                  //   'assets/images/logo.png',
                  //   width: 191.w,
                  //   height: 62.h,
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // CustomText(text: 'slogan'.tr(), size: 8.sp, color: white, fontWeight: FontWeight.w700),
                  // const Spacer(),
                  Container(
                    // width: 1.sw,
                    decoration: BoxDecoration(
                      color:Colors.white54,
                      borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(40.r), topStart: Radius.circular(40.r)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 38.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'onboarding.language'.tr(),
                          style: TextStyle(
                            color: blue,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.setLocale(const Locale('en'));
                           HomeTravellerNavBarCubit.get(context).changedColor();
                          },
                          child: Container(
                            height: 65.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(12.r),
                                border: Border.all(
                                    color: accentColor
                                ),
                                color: HomeTravellerNavBarCubit.get(context).changeColor == false ? orange:white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/splash/us.png",
                                  height: 56.h,
                                  width: 50.w,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                CustomText(text: 'English', size: 16.sp, color: accentColor, fontWeight: FontWeight.w600)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),

                        SizedBox(
                          height: 30.h,
                        ),
                        CustomButton(
                          height: 50.h,
                          backgroudColor: accentColor,
                          function: () {
                            Navigator.pushNamed(context, 'onBoardingMain');
                            //Navigator.pushNamed(context, 'landingHomeMain');
                            //Navigator.pushNamed(context, "travellerNavBar");
                          },
                          text: 'onboarding.next'.tr(),
                          width: 327.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
