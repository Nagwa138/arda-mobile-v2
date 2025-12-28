import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/partner/profile/profile_cubit.dart';

class PersonalProfile extends StatelessWidget {
  const PersonalProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'profile.personalProfile'.tr(),
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit()..getPersonalData(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {

          },
          builder: (context, state) {


            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              children: [
                Text(
                  'profile.title1'.tr(),
                  style: TextStyle(
                    color: Color(0xFF130A03),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 40.h),
                state is ProfileLoading ? Center(child: CircularProgressIndicator(color: orange)) :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    personInfoBuilder(
                      title: 'profile.username'.tr(),
                      subTitle: context.read<ProfileCubit>().personalProfileModel.data!.userName.toString(),
                    ),
                    personInfoBuilder(
                      title: 'profile.email'.tr(),
                      subTitle: context.read<ProfileCubit>().personalProfileModel.data!.email.toString(),
                    ),
                    personInfoBuilder(
                      title: 'profile.phone'.tr(),
                      subTitle:context.read<ProfileCubit>().personalProfileModel.data!.phoneNumber.toString(),
                    ),
                    SizedBox(height: 30.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'editProfile', arguments: {
                          "userName": context.read<ProfileCubit>().personalProfileModel.data!.userName!,
                          "email": context.read<ProfileCubit>().personalProfileModel.data!.email!,
                          "phoneNumber": context.read<ProfileCubit>().personalProfileModel.data!.phoneNumber!,
                          "gender" :context.read<ProfileCubit>().personalProfileModel!.data!.gender
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit_square,
                            color: orange,
                            size: 22.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            'profile.edit'.tr(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: orange,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 60.w),
                      minLeadingWidth: 10.w,
                      splashColor: Colors.transparent,
                      leading: Icon(
                        Icons.edit_sharp,
                        color: Colors.grey,
                        size: 20.sp,
                      ),
                      title: Text(
                        'profile.companyEdit'.tr(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, 'editCompanyProfilePlaceHolder');
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20.sp,
                      ),
                    ),

                  ],

                ),
                // Icon(
                //   CupertinoIcons.person_alt_circle_fill,
                //   color: orange,
                //   size: 80.sp,
                // ),
                // SizedBox(height: 16.h),
                // Text(
                //   'El Amal',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: black,
                //     fontSize: 16.sp,
                //     fontWeight: FontWeight.w600,
                //   ),
                // )

              ],
            );
          },
        ),
      ),
    );
  }

  Widget personInfoBuilder({required String title, required String subTitle}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            subTitle,
            style: TextStyle(
              color: Color(0xFF8C8C8C),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
