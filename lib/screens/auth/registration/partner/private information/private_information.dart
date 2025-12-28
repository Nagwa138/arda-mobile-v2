// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/auth/registration/partner/partner_register.dart';
import 'package:PassPort/services/auth/registration/partner/partner_register_cubit.dart';

class PrivateInformation extends StatelessWidget {
  const PrivateInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.9.sh,
       color: appBackgroundColor,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () async {
              await context.read<PartnerRegisterCubit>().pickCompanyLogo();
            },
            child: context.read<PartnerRegisterCubit>().CompanyLogo != null
                ? CircleAvatar(
                    radius: 40.r,
                    backgroundImage: FileImage(
                      File(context
                          .read<PartnerRegisterCubit>()
                          .CompanyLogo!
                          .path),
                    ),
                  )
                : Column(
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: accentColor,
                        child: Icon(
                          Icons.person,
                          color: white,
                          size: 50.r,
                        ),
                      ),
                      Text(
                        'register.uploadImage'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
          ),
          SizedBox(height: 10.h),
          textFormFildBuilder(
            context,
            title: 'register.companyName'.tr(),
            hint: 'register.inputs.companyName'.tr(),
            validation: (value) {
              if (value!.isEmpty) {
                return 'register.inputs.companyName'.tr();
              }
            },
            controller:
                context.read<PartnerRegisterCubit>().companyNameController,
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: 'register.governate'.tr(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: true ? ' *' : '',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Color(0xFF8C8C8C)),
            ),
            child: Builder(
              builder: (context) {
                var cubit = context.watch<PartnerRegisterCubit>();
                var availableItems = cubit.governmentsModel.data ?? [];

                return DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  hint: Text('register.governate'.tr()),
                  value: availableItems
                          .any((e) => e.id == cubit.governateController)
                      ? cubit.governateController
                      : null,
                  items: availableItems.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem<String>(
                      value: e.id,
                      child: Text(
                        e.name!,
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    cubit.changeCountry(value);
                  },
                );
              },
            ),
          ),

          SizedBox(height: 10.h),
          textFormFildBuilder(
            context,
            title: 'register.address'.tr(),
            isRequired: false,
            hint: 'register.inputs.address'.tr(),
            controller: context.read<PartnerRegisterCubit>().addressController ,
            validation: (value) {
              return null;
            },
            inputType: TextInputType.text,
          ),
          SizedBox(height: 10.h),
          textFormFildBuilder(
            
            context,
            title: 'register.websiteLink'.tr(),
            hint: 'register.inputs.websiteLink'.tr(),
            isRequired: false,
            validation: (value) {
              // if (value!.isEmpty) {
              //   return 'register.inputs.websiteLink'.tr();
              // }
            },
            controller: context.read<PartnerRegisterCubit>().websiteController,
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<PartnerRegisterCubit>()
                          .pageController
                          .previousPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                    },
                    child: Text(
                      'register.back'.tr(),
                      style: TextStyle(
                        color: Color(0xFF8C8C8C),
                        decoration: TextDecoration.underline,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();

                    context.read<PartnerRegisterCubit>().privateInfoStatus
                        ? context
                            .read<PartnerRegisterCubit>()
                            .pageController
                            .nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease)
                        : null;
                  },
                  child: Container(
                    // width: 1.sw,
                    height: 48.h,
                    decoration: ShapeDecoration(
                      // color: context.read<PartnerRegisterCubit>().privateInfoStatus ? Color(0xFFC26023) : Color(0xFF8C8C8C),
                      color: accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'register.next'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          // RichText(
          //   text: TextSpan(
          //     text: 'register.signinSuggestion'.tr() + " ",
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 14.sp,
          //       fontWeight: FontWeight.w400,
          //     ),
          //     children: [
          //       TextSpan(
          //         recognizer: TapGestureRecognizer()
          //           ..onTap = () {
          //             Navigator.pushNamed(context, 'login');
          //           },
          //         text: 'register.login'.tr(),
          //         style: TextStyle(
          //           decoration: TextDecoration.underline,
          //           color: orange,
          //           fontSize: 14.sp,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 25.h,
          // ),
        ],
      ),
    );
  }
}
