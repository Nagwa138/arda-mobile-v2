import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_cubit.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profits extends StatelessWidget {
  const Profits({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit()..getProfits(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'profits.title'.tr(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: state is ProfitsLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: orange,
                  ))
                : Column(
                    children: [
                      SizedBox(
                        height: 290.h + 150.h,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              height: 290.h,
                              width: 1.sw,
                              color: orange,
                              child: Center(
                                child: SizedBox(
                                  width: 320.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 40.h),
                                    child: Text(
                                      'profits.h1'.tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 200.h,
                              child: Container(
                                // height: 100.h,
                                width: 200.w,
                                padding: EdgeInsets.symmetric(
                                  vertical: 35.h,
                                ),
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(16.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.5),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: white,
                                      radius: 25.sp,
                                      child: Icon(
                                        CupertinoIcons.money_dollar,
                                        color: orange,
                                        size: 40.sp,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      'EGP ${UserCubit.get(context).profitsModel?.data?.totalProfits.toString()}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      'profits.totalEarning'.tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xDD2E2D2D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'profits.p1'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "${UserCubit.get(context).profitsModel?.data?.totalBooking.toString()} " +
                            'profits.reservation'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: black,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        'profits.hint'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}
