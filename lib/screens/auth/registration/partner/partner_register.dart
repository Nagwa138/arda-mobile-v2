// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/transeletarabic/transalet.dart';
import 'package:PassPort/screens/auth/registration/partner/private%20information/private_information.dart';
import 'package:PassPort/screens/auth/registration/partner/service%20information/service_information.dart';

import 'package:PassPort/services/auth/registration/partner/partner_register_cubit.dart';

import 'general information/general_information.dart';

class PartnerRegister extends StatelessWidget {
  const PartnerRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocProvider(
        create: (context) => PartnerRegisterCubit()
          ..getGovernments()
          ..getServices(),
        child: BlocConsumer<PartnerRegisterCubit, PartnerRegisterState>(
          listener: (context, state) {
            if (state is RegisterPartnerLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: orange,
                  ));
                },
              );
            } else if (state is PartnerRegisterSuccess) {
              if (context.read<PartnerRegisterCubit>().serviceSelected == 0) {
                accommodationDialog(context);
              } else if (context.read<PartnerRegisterCubit>().serviceSelected ==
                  1) {
                dialog(context, subTitleNumber: 1);
              } else if (context.read<PartnerRegisterCubit>().serviceSelected ==
                  2) {
                dialog(context, subTitleNumber: 2);
              } else {
                dialog(context, subTitleNumber: 3);
              }
              //Navigator.pop(context);
            } else if (state is PartnerRegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    state.error,
                  ),
                ),
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/auth/image1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: BackButton(
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/ard_logo.png",
                          height: 250.h,
                        ),
                        Container(
                          // height: 0.75.sh,
                          decoration: BoxDecoration(
                            color: appBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.r),
                              topRight: Radius.circular(24.r),
                              bottomLeft: Radius.circular(24.r),
                              bottomRight: Radius.circular(4.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Form(
                              key: context.read<PartnerRegisterCubit>().formKey,
                              child: ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      3,
                                      (index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        child: Container(
                                          width: 43.w,
                                          height: 2.h,
                                          decoration: ShapeDecoration(
                                            color: context
                                                        .read<
                                                            PartnerRegisterCubit>()
                                                        .currentPage ==
                                                    index
                                                ? orange
                                                : Color(0xFF8C8C8C),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    'register.title'.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: accentColor,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'register.subtitle'.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF7A8699),
                                      fontSize: 12.sp,
                                      fontFamily: 'Mona Sans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    // color: Colors.green,
                                    height: 770.h,
                                    child: PageView(
                                      physics: NeverScrollableScrollPhysics(),
                                      controller: context
                                          .read<PartnerRegisterCubit>()
                                          .pageController,
                                      onPageChanged: (index) {
                                        context
                                            .read<PartnerRegisterCubit>()
                                            .changeCurrentIndex(index);
                                      },
                                      children: [
                                        GeneralInformation(),
                                        PrivateInformation(),
                                        ServiceInformation(),
                                      ],
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget textFormFildBuilder(
  BuildContext context, {
  required String title,
  required String hint,
  bool isRequired = true,
  required TextEditingController controller,
  bool obstructText = false,
  required final Function validation,
  TextInputType inputType = TextInputType.text,
  Widget? suffixIcon,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title.tr(),
            style: TextStyle(
              color: accentColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: isRequired ? ' *' : '',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          controller: controller,
          onChanged: (value) {
            context.read<PartnerRegisterCubit>().currentPage == 0
                ? context.read<PartnerRegisterCubit>().toggleGeneralInfo()
                : context.read<PartnerRegisterCubit>().togglePrivateInfo();
          },
          obscureText: obstructText,
          validator: (input) => validation(input),
          keyboardType: inputType,
          inputFormatters: [
            ArabicToEnglishNumeralsFormatter(),
          ],
          style: TextStyle(
            color: accentColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),

            hintText: hint.tr(),
            hintStyle: TextStyle(
              color: accentColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Color(0xFFDFE2E6),
              ),
            ),
            suffixIcon: suffixIcon,
            // filled: true,
            // fillColor: Color(0xFFF5F7FA),
          ),
        ),
      ],
    ),
  );
}
