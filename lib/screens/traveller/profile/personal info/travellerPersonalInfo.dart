import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_cubit.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_state.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TravellerPersonalInfo extends StatelessWidget {
  const TravellerPersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit()..getInformationUser(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UpdateInformationSuccessful) {
            UserCubit.get(context).getInformationUser();
            context.showCustomSnackBar(
              "Successful",
              type: SnackBarType.success,
            );
          }
        },
        builder: (context, state) {
          return Stack(children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      color: accentColor, size: 22.sp),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  'profile.personalProfile'.tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              body: state is getInformationLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: orange,
                      strokeWidth: 3,
                    ))
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Section
                            Text(
                              'profile.title1'.tr(),
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 32.sp,
                                fontFamily: 'Mona Sans',
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Manage your personal information',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 40.h),

                            // Info Cards Container
                            Container(
                              decoration: BoxDecoration(
                                color: appBackgroundColor,
                                borderRadius: BorderRadius.circular(24.r),
                                border: Border.all(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  personInfoBuilder(
                                    icon: Icons.person_outline_rounded,
                                    title: 'profile.username'.tr(),
                                    subTitle: UserCubit.get(context)
                                        .userModel!
                                        .data!
                                        .userName
                                        .toString(),
                                    isFirst: true,
                                  ),
                                  _buildDivider(),
                                  personInfoBuilder(
                                    icon: Icons.email_outlined,
                                    title: 'profile.email'.tr(),
                                    subTitle: UserCubit.get(context)
                                        .userModel!
                                        .data!
                                        .email
                                        .toString(),
                                  ),
                                  _buildDivider(),
                                  personInfoBuilder(
                                    icon: Icons.wc_outlined,
                                    title: 'profile.gender'.tr(),
                                    subTitle:
                                        UserCubit.get(context).value.toString(),
                                  ),
                                  _buildDivider(),
                                  personInfoBuilder(
                                    icon: Icons.phone_outlined,
                                    title: 'profile.phone'.tr(),
                                    subTitle: UserCubit.get(context)
                                        .userModel!
                                        .data!
                                        .phoneNumber
                                        .toString(),
                                    isLast: true,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 50.h),

                            // Edit Button
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, 'travellerEditProfile',
                                    arguments: {
                                      'userName': UserCubit.get(context)
                                          .userModel!
                                          .data!
                                          .userName
                                          .toString(),
                                      'email': UserCubit.get(context)
                                          .userModel!
                                          .data!
                                          .email
                                          .toString(),
                                      'phone': UserCubit.get(context)
                                          .userModel!
                                          .data!
                                          .phoneNumber
                                          .toString(),
                                      'gender': UserCubit.get(context)
                                          .userModel!
                                          .data!
                                          .gender
                                    });
                              },
                              child: Container(
                                width: double.infinity,
                                height: 58.h,
                                decoration: BoxDecoration(
                                  color: accentColor,
                                  borderRadius: BorderRadius.circular(16.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: accentColor.withValues(alpha: 0.3),
                                      blurRadius: 12,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit_rounded,
                                      color: Colors.white,
                                      size: 24.sp,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      'profile.edit'.tr(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
            )
          ]);
        },
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.shade200,
      ),
    );
  }

  Widget personInfoBuilder({
    required IconData icon,
    required String title,
    required String subTitle,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 18.w),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  subTitle,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
