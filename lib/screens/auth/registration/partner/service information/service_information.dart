import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customText.dart';

import '../../../../../services/auth/registration/partner/partner_register_cubit.dart';

class ServiceInformation extends StatelessWidget {
  List items = [
    {
      "image": 'assets/images/register/accommodation.png',
      "title": 'Accommodation',
    },
    {
      "image": 'assets/images/register/activities.png',
      "title": "Adventure",
    },
    {
      "image": 'assets/images/register/trips.png',
      "title": "Journey Planner",
    },
    {
      "image": 'assets/images/register/products.png',
      "title": 'Golden Hands',
    },
  ];
  ServiceInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PartnerRegisterCubit, PartnerRegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'register.serviceTitle'.tr(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.h),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: context
                    .read<PartnerRegisterCubit>()
                    .applicationServicesModel
                    .data!
                    .length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24.w,
                  mainAxisSpacing: 24.h,
                  childAspectRatio: (1).h,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    // Log the service type selected
                    final serviceName = context
                        .read<PartnerRegisterCubit>()
                        .applicationServicesModel
                        .data![index]
                        .name;
                    print('Service selected: $serviceName');
                    // Pass context to Cubit for trip type dialog if needed
                    context
                        .read<PartnerRegisterCubit>()
                        .changeServiceSelected(index, context: context);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: context
                                      .read<PartnerRegisterCubit>()
                                      .serviceSelected ==
                                  index
                              ? accentColor
                              : Color(0xFFEEEEEE),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            items[index]["image"],
                            height: 100.h,
                            width: 100.w,
                            color: accentColor,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            context
                                .read<PartnerRegisterCubit>()
                                .applicationServicesModel
                                .data![index]
                                .name
                                .toString(),
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'register.term&conditionsTitle'.tr(),
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, 'termConditions');
                          },
                        text: 'register.term&conditions'.tr(),
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30.h),
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
                        context.read<PartnerRegisterCubit>().register();
                      },
                      child: Container(
                        width: 1.sw,
                        height: 48.h,
                        decoration: ShapeDecoration(
                          color: context
                                      .read<PartnerRegisterCubit>()
                                      .serviceSelected !=
                                  -1
                              ? accentColor
                              : Color(0xFF8C8C8C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'register.signin'.tr(),
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
              SizedBox(height: 15.h),
            ],
          ),
        );
      },
    );
  }
}

dialog(BuildContext context, {required int subTitleNumber}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        surfaceTintColor: Colors.white,
        title: Image.asset(
          'assets/images/auth/phonegif.gif',
          width: 120.w,
          height: 120.h,
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "We appreciate your interest in sharing your services on our platform. We will review your request and get back to you soon.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                subTitleNumber == 1
                    ? 'register.accommodationDialog.subtitle2'.tr()
                    : subTitleNumber == 2
                        ? 'register.accommodationDialog.subtitle3'.tr()
                        : 'register.accommodationDialog.subtitle4'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: 0.45.sw,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'login',
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        // 'register.accommodationDialog.button'.tr(),
                        "submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

accommodationDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        surfaceTintColor: Colors.white,
        title: Image.asset(
          'assets/images/main/code-review 1.png',
          width: 120.w,
          height: 120.h,
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "We appreciate your interest in sharing your services on our platform. We will review your request and get back to you soon.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'register.accommodationDialog.subtitle'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: 0.45.sw,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'login',
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        // 'register.accommodationDialog.button'.tr(),
                        "submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
