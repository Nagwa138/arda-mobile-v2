// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/add%20service/room%20details/roomDetails.dart';
import 'package:PassPort/services/add%20service/add%20images/add_images_cubit.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Add Service Page/AddServicePage.dart';

class AddServices extends StatelessWidget {
  const AddServices({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddServiceCubit()
            ..getAccommodationType()
            ..getAmenities()
            ..getSpecials(),
        ),
        BlocProvider(
          create: (context) => AddImagesCubit(),
        ),
      ],
      child: BlocConsumer<AddServiceCubit, AddServiceState>(
        listener: (context, state) {
          if (state is AddServiceLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AddServiceError) {
            Navigator.pop(context);
            snackBarBuilder(context, state.message);
          } else if (state is AddServiceSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            snackBarBuilder(context, 'successFul', isError: false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              toolbarHeight: 50.h,
              title: GestureDetector(
                onTap: () {
                  context.read<AddServiceCubit>().addService();
                },
                child: Text(
                  'addService.accommodation'.tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      child: Center(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          controller:
                              context.read<AddServiceCubit>().scrollController,
                          itemCount: 2,
                          // itemCount: 2,

                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            late List items;
                            items = [
                              " Details",
                              // 'addService.titles.2'.tr(),
                              'addService.titles.3'.tr(),
                              // 'addService.titles.4'.tr(),
                            ];

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SizedBox(
                                width: 150.w,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: context
                                                  .read<AddServiceCubit>()
                                                  .currentIndex ==
                                              index
                                          ? orange
                                          : Colors.grey,
                                      child: Text(
                                        (index + 1).toString(),
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    SizedBox(
                                      width: 90.w,
                                      child: Text(
                                        items[index],
                                        style: TextStyle(
                                          color: accentColor,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w700,
                                          height: (0.95).h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    // height: 0.70.sh,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (value) {
                        context.read<AddServiceCubit>().changePage(value);
                      },
                      controller:
                          context.read<AddServiceCubit>().pageController,
                      children: [
                        AddServicePage(),
                        // ServiceDetails(),
                        RoomDetails(),
                        // ContactDetails(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                children: [
                  context.read<AddServiceCubit>().currentIndex < 1
                      ? SizedBox()
                      : Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.read<AddServiceCubit>().previousPage();
                            },
                            child: Text(
                              'register.back'.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF8C8C8C),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                  context.read<AddServiceCubit>().currentIndex < 1
                      ? SizedBox()
                      : Expanded(
                          flex: 3,
                          child: SizedBox.shrink(),
                        ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        if (context.read<AddServiceCubit>().currentIndex == 0) {
                          // الصفحة الأولى - AddServicePage (دمج Location + Service Details)
                          bool isFormValid = context
                              .read<AddServiceCubit>()
                              .locationForm
                              .currentState!
                              .validate();
                          bool hasAccommodationType = context
                                  .read<AddServiceCubit>()
                                  .descriptionIndex !=
                              -1;
                          bool hasImages = context
                              .read<AddServiceCubit>()
                              .serviceImages
                              .isNotEmpty;
                          bool hasRooms =
                              context.read<AddServiceCubit>().sumOfAllRooms !=
                                  0;

                          if (isFormValid &&
                              hasAccommodationType &&
                              hasImages &&
                              hasRooms) {
                            context.read<AddServiceCubit>().nextPage(context);
                          } else {
                            // إظهار رسائل الأخطاء بالترتيب
                            if (!isFormValid) {
                              snackBarBuilder(
                                  context, "Please fill all required fields");
                            } else if (!hasAccommodationType) {
                              snackBarBuilder(context,
                                  "Please select an accommodation type");
                            } else if (!hasImages) {
                              snackBarBuilder(
                                  context, "Please upload at least one photo");
                            } else if (!hasRooms) {
                              snackBarBuilder(
                                  context, "Please add at least one room");
                            }
                          }
                        } else if (context
                                .read<AddServiceCubit>()
                                .currentIndex ==
                            1) {
                          // الصفحة الثانية - RoomDetails
                          if (context
                              .read<AddServiceCubit>()
                              .roomDetailsForm
                              .currentState!
                              .validate()) {
                            if (context
                                    .read<AddServiceCubit>()
                                    .checkSingleRoom() &&
                                context
                                    .read<AddServiceCubit>()
                                    .checkDoubleRoom() &&
                                context
                                    .read<AddServiceCubit>()
                                    .checkTripleRoom() &&
                                context
                                    .read<AddServiceCubit>()
                                    .checkKingRoom()) {
                              context.read<AddServiceCubit>().addService();
                            } else {
                              snackBarBuilder(
                                  context, "errorMessages.emptyImage".tr());
                            }
                          }
                        }
                        //  else if (context
                        //         .read<AddServiceCubit>()
                        //         .currentIndex ==
                        //     2)
                        // {
                        //   // الصفحة الثالثة - ContactDetails
                        //   if (context
                        //       .read<AddServiceCubit>()
                        //       .contactForm
                        //       .currentState!
                        //       .validate()) {
                        //     context.read<AddServiceCubit>().addService();
                        //   }
                        // }
                      },
                      child: Container(
                        width: 1.sw,
                        height: 48.h,
                        decoration: ShapeDecoration(
                          color: orange,
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
            ),
          );
        },
      ),
    );
  }
}

snackBarBuilder(BuildContext context, String message, {bool isError = true}) {
  return context.showCustomSnackBar(
    message,
    type: isError ? SnackBarType.error : SnackBarType.success,
  );
}

Widget textFormFildBuilder(
  BuildContext context, {
  required String title,
  required String hint,
  bool isRequired = true,
  VoidCallback? validator,
  required TextEditingController controller,
  bool obstructText = false,
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
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
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
          validator: (value) =>
              value!.isEmpty ? 'Please enter a valid value' : null,
          onChanged: (value) {},
          obscureText: obstructText,
          keyboardType: inputType,
          style: TextStyle(
            color: accentColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),

            hintText: hint.tr(),
            hintStyle: TextStyle(
              color: accentColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: accentColor,
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
