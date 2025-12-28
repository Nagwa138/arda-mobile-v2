import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/add%20service/addServices.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: context.read<AddServiceCubit>().contactForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'addService.4.contact'.tr(),
              style: TextStyle(
                color: accentColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20.h),
            textFormFildBuilder(
              context,
              title: 'addService.4.title1'.tr(),
              hint: 'addService.4.title1Hint'.tr(),
              controller: context.read<AddServiceCubit>().websiteController,
              isRequired: false,
            ),
            textFormFildBuilder(
              context,
              title: 'addService.4.title2'.tr(),
              hint: 'addService.4.title2Hint'.tr(),
              inputType: TextInputType.number,
              controller: context.read<AddServiceCubit>().phoneController,
            ),
            textFormFildBuilder(
              context,
              title: 'addService.4.title3'.tr(),
              hint: 'addService.4.title3Hint'.tr(),
              controller: context.read<AddServiceCubit>().empController,
            ),
          ],
        ),
      ),
    );
  }
}
