import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/partner/profile/profile_cubit.dart';

class EditCompanyProfilePlaceholder extends StatelessWidget {
  const EditCompanyProfilePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>ProfileCubit()..companyInformation(),
      child: BlocConsumer<ProfileCubit,ProfileState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: white,

            appBar: AppBar(
              backgroundColor: white,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'profile.companyEdit'.tr(),
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body:
            state is CompanyLoading ? Center(child: CircularProgressIndicator(color: orange,)) :
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              children: [
                SizedBox(height: 20.h),
               CircleAvatar(
                 backgroundImage:NetworkImage(context.read<ProfileCubit>().companymodel!.data!.logo.toString() ,
               )),
                SizedBox(height: 20.h),
                personInfoBuilder(
                  title: 'profile.companyName'.tr(),
                  subTitle: context.read<ProfileCubit>().companymodel!.data!.companyName.toString(),
                ),
                personInfoBuilder(
                  title: 'profile.companyCatergories'.tr(),
                  subTitle: context.read<ProfileCubit>().companymodel!.data!.companyCategory.toString(),
                ),
                personInfoBuilder(
                  title: 'register.governate'.tr(),
                  subTitle:context.read<ProfileCubit>().companymodel!.data!.governate.toString(),
                ),
                personInfoBuilder(
                  title: 'register.websiteLink'.tr(),
                  subTitle: context.read<ProfileCubit>().companymodel!.data!.website.toString(),
                ),
                personInfoBuilder(
                  title: 'register.address'.tr(),
                  subTitle: context.read<ProfileCubit>().companymodel!.data!.address.toString(),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pushNamed(context, 'editCompanyProfile');
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.edit_square,
                //         color: orange,
                //         size: 22.sp,
                //       ),
                //       SizedBox(width: 5.w),
                //       Text(
                //         'profile.edit'.tr(),
                //         textAlign: TextAlign.right,
                //         style: TextStyle(
                //           color: orange,
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w700,
                //           decoration: TextDecoration.underline,
                //         ),
                //       )
                //     ],
                //   ),
                // ),


              ],
            ),
          );
        },

      ),
    );
  }
}

Widget personInfoBuilder({required String title, required String subTitle}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 45.h),
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
