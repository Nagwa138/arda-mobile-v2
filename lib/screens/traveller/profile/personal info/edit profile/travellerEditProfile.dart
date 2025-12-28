import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/transeletarabic/transalet.dart';
import 'package:PassPort/components/widgets/customText.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_cubit.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_state.dart';

class TravellerEditProfile extends StatelessWidget {
  const TravellerEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(
      create: (BuildContext context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UpdateInformationSuccessful) {
            UserCubit.get(context).getInformationUser();
            Fluttertoast.showToast(
                msg: "Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushNamed(context, "travellerPersonalInfo");
          } else if (state is UpdateInformationError) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                // Modern App Bar with Image
                SliverAppBar(
                  expandedHeight: 220.h,
                  pinned: true,
                  backgroundColor: accentColor,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 20.sp),
                    onPressed: () => Navigator.pop(context),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/auth/Intersect.png',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            "assets/images/ard_logo.png",
                            height: 120.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: appBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Update your personal information',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 32.h),

                          // Form Fields
                          textFormFieldBuilder(
                            icon: Icons.person_outline_rounded,
                            title: 'profile.username'.tr(),
                            subTitle: arguments['userName'],
                            controller: UserCubit.get(context).userName,
                          ),
                          SizedBox(height: 24.h),

                          textFormFieldBuilder(
                            icon: Icons.email_outlined,
                            title: 'profile.email'.tr(),
                            subTitle: arguments['email'],
                            controller: UserCubit.get(context).email,
                          ),
                          SizedBox(height: 24.h),

                          textFormFieldBuilder(
                            icon: Icons.phone_outlined,
                            title: 'profile.phone'.tr(),
                            subTitle: arguments['phone'],
                            controller: UserCubit.get(context).phone,
                          ),
                          SizedBox(height: 32.h),

                          // Gender Selection
                          Text(
                            'profile.gender'.tr(),
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 16.h),

                          Container(
                            decoration: BoxDecoration(
                              color: appBackgroundColor,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.08),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      UserCubit.get(context).checkGender(0);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      decoration: BoxDecoration(
                                        color: UserCubit.get(context).val == 0
                                            ? accentColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.r),
                                          bottomLeft: Radius.circular(16.r),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.male_rounded,
                                            color:
                                                UserCubit.get(context).val == 0
                                                    ? Colors.white
                                                    : Colors.black54,
                                            size: 22.sp,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            'profile.male'.tr(),
                                            style: TextStyle(
                                              color:
                                                  UserCubit.get(context).val ==
                                                          0
                                                      ? Colors.white
                                                      : Colors.black54,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 50.h,
                                  color: Colors.black.withOpacity(0.08),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      UserCubit.get(context).checkGender(1);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      decoration: BoxDecoration(
                                        color: UserCubit.get(context).val == 1
                                            ? orange
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16.r),
                                          bottomRight: Radius.circular(16.r),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.female_rounded,
                                            color:
                                                UserCubit.get(context).val == 1
                                                    ? Colors.white
                                                    : Colors.black54,
                                            size: 22.sp,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            'profile.female'.tr(),
                                            style: TextStyle(
                                              color:
                                                  UserCubit.get(context).val ==
                                                          1
                                                      ? Colors.white
                                                      : Colors.black54,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 40.h),

                          // Save Button
                          state is UpdateInformationLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: accentColor,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    UserCubit.get(context).updateInformation(
                                        name: UserCubit.get(context)
                                                .userName
                                                .text
                                                .trim()
                                                .isNotEmpty
                                            ? UserCubit.get(context)
                                                .userName
                                                .text
                                                .trim()
                                            : arguments['userName'],
                                        email: UserCubit.get(context)
                                                .email
                                                .text
                                                .trim()
                                                .isNotEmpty
                                            ? UserCubit.get(context)
                                                .email
                                                .text
                                                .trim()
                                            : arguments['email'],
                                        phone: UserCubit.get(context)
                                                .phone
                                                .text
                                                .trim()
                                                .isNotEmpty
                                            ? UserCubit.get(context)
                                                .phone
                                                .text
                                                .trim()
                                            : arguments['phone'],
                                        valG: UserCubit.get(context).val != null &&
                                                (UserCubit.get(context).val ==
                                                        0 ||
                                                    UserCubit.get(context).val ==
                                                        1)
                                            ? UserCubit.get(context).val
                                            : (arguments['gender'] ??
                                                0) // Add null check
                                        );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 58.h,
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      borderRadius: BorderRadius.circular(16.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: accentColor.withOpacity(0.3),
                                          blurRadius: 12,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.white,
                                          size: 24.sp,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          'profile.save'.tr(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget textFormFieldBuilder({
    required IconData icon,
    required String title,
    required String subTitle,
    required TextEditingController controller,
  }) {
    // Set initial value if controller is empty
    if (controller.text.isEmpty && subTitle.isNotEmpty) {
      controller.text = subTitle;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: accentColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: appBackgroundColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: Colors.black.withOpacity(0.08),
              width: 1.5,
            ),
          ),
          child: TextFormField(
            controller: controller,
            inputFormatters: [
              ArabicToEnglishNumeralsFormatter(),
            ],
            style: TextStyle(
              color: accentColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              prefixIcon: Container(
                padding: EdgeInsets.all(12.w),
                child: Icon(
                  icon,
                  color: accentColor.withOpacity(0.6),
                  size: 22.sp,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 18.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
