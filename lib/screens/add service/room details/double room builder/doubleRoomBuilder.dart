import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customText.dart';
import 'package:PassPort/components/widgets/dotted%20container/dottedRect.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';

class DoubleRoomBuilder extends StatelessWidget {
  const DoubleRoomBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'addService.2.double'.tr(),
          style: TextStyle(
            color: accentColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 20.h),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'addService.3.title1'.tr(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Color(0xFFE21818),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        context.read<AddServiceCubit>().doubleRoomImage == null
            ? Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<AddServiceCubit>().addDoubleRoomImage(isPicked: true);
                      },
                      child: DashedRect(
                        color: accentColor,
                        strokeWidth: 1,
                        gap: 5,
                        child: Container(
                          height: 77.h,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              'addService.addImage.sub1'.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<AddServiceCubit>().addDoubleRoomImage(isPicked: false);
                      },
                      child: DashedRect(
                        color: accentColor,
                        strokeWidth: 1,
                        gap: 5,
                        child: Container(
                          height: 77.h,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              'addService.addImage.sub2'.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.file(
                    File(context.read<AddServiceCubit>().doubleRoomImage!.path),
                    // height: 100.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      context.read<AddServiceCubit>().removeDoubleRoomImage();
                    },
                    child: Text(
                      'addService.deleteImage'.tr(),
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
        SizedBox(height: 20.h),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'addService.3.title2'.tr() + "?",
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Color(0xFFE21818),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        TextFormField(
          controller: context.read<AddServiceCubit>().doubleRoomNightController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'errorMessages.empty'.tr();
            }
            return null;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'addService.3.title2'.tr(),
            suffixText: 'addService.3.night'.tr(),
            suffixStyle: TextStyle(
              color: accentColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: accentColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: accentColor,
                width: 1,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'addService.3.title4'.tr(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Color(0xFFE21818),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        TextFormField(
          controller: context.read<AddServiceCubit>().doubleRoomGuestController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'errorMessages.empty'.tr();
            }
            return null;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'addService.3.title4'.tr(),
            suffixText: 'addService.3.Gust'.tr(),
            suffixStyle: TextStyle(
              color: accentColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            hintStyle: TextStyle(
              color: accentColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: accentColor,
                width: 1,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        CheckboxListTile(
          activeColor: orange,
          title: CustomText(text:  'addService.3.title3'.tr(), size: 18.sp, color: accentColor, fontWeight: FontWeight.w600),

          value: context.read<AddServiceCubit>().agreeDouble,
          onChanged: (newValue) {
            context.read<AddServiceCubit>().changeAgreeDouble(newValue);
          },
        ),
        Divider(),
        SizedBox(height: 20.h),
      ],
    );
  }
}
