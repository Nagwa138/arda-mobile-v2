import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/partner/landinHomeCubit/landinHomeCubit.dart';
import 'package:PassPort/services/partner/landinHomeCubit/landingHomeStates.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandingMainHomeCubit(),
      child: BlocConsumer<LandingMainHomeCubit, LandingHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return WillPopScope(
            onWillPop: ()async {
              return false;
            },
            child: Scaffold(
              backgroundColor: appBackgroundColor,
              body: LandingMainHomeCubit.get(context).screens[LandingMainHomeCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                iconSize: 24.sp,
                backgroundColor: appBackgroundColor,
                elevation: 0,
                currentIndex: LandingMainHomeCubit.get(context).currentIndex,
                onTap: (index) {
                  LandingMainHomeCubit.get(context).changeCurrentIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/landingHome/home.png',
                      color: LandingMainHomeCubit.get(context).currentIndex == 0 ? accentColor : Color(0xff7E8181),
                      width: 32.w,
                      height: 32.h,
                    ),
                    label: LandingMainHomeCubit.get(context).titles[0],
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/landingHome/services.png',
                      color: LandingMainHomeCubit.get(context).currentIndex == 1 ? orange : Color(0xff7E8181),
                      width: 32.w,
                      height: 32.h,
                    ),
                    label: LandingMainHomeCubit.get(context).titles[1],
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/landingHome/profile.png',
                      color: LandingMainHomeCubit.get(context).currentIndex == 2 ? orange : Color(0xff7E8181),
                      width: 32.w,
                      height: 32.h,
                    ),
                    label: LandingMainHomeCubit.get(context).titles[2],
                  ),
                ],
                selectedItemColor: orange,
                selectedLabelStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 12.sp,
                ),
                unselectedItemColor: const Color(0xff7E8181),
                unselectedLabelStyle: TextStyle(
                  color: const Color(0xff7E8181),
                  fontSize: 12.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
