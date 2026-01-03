import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';

class ServiceDetails extends StatelessWidget {
  const ServiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AddServiceCubit>().serviceForm,
      child: ListView(
        children: [
          SizedBox(height: 10.h),
          Text(
            'addService.2.title'.tr(),
            style: TextStyle(
              color: accentColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          textFormFildBuilder(
            context,
            title: 'addService.2.servicesName'.tr(),
            hint: 'addService.2.servicesNameHint'.tr(),
            controller: context.read<AddServiceCubit>().serviceNameController,
          ),
          SizedBox(height: 20.h),
          Text(
            'addService.2.description'.tr(),
            style: TextStyle(
              color: accentColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 100.h,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: context.read<AddServiceCubit>().amenitiesModel!.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.read<AddServiceCubit>().addAmenities(context.read<AddServiceCubit>().amenitiesModel!.data![index].id!);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Container(
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: context.read<AddServiceCubit>().amenities.contains(context.read<AddServiceCubit>().amenitiesModel!.data![index].id!)
                              ? accentColor
                              : Color(0xFFEEEEEE),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Text(
                            context.read<AddServiceCubit>().amenitiesModel!.data![index].name!,
                            style: TextStyle(
                              color:
                                  context.read<AddServiceCubit>().amenities.contains(context.read<AddServiceCubit>().amenitiesModel!.data![index].id!)
                                      ? accentColor
                                      : accentColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'addService.2.description2'.tr(),
            style: TextStyle(
              color: accentColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 100.h,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: context.read<AddServiceCubit>().specialsModel!.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                print('----\n ${context.read<AddServiceCubit>().specialsModel!.data![index].name} \n----');

                return GestureDetector(
                  onTap: () {
                    context.read<AddServiceCubit>().addFeature(context.read<AddServiceCubit>().specialsModel!.data![index].id!);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Container(
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: context.read<AddServiceCubit>().feature.contains(context.read<AddServiceCubit>().specialsModel!.data![index].id)
                              ? accentColor
                              : Color(0xFFEEEEEE),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Text(
                            context.read<AddServiceCubit>().specialsModel!.data![index].name!,
                            style: TextStyle(
                              color: context.read<AddServiceCubit>().feature.contains(context.read<AddServiceCubit>().specialsModel!.data![index].id)
                                  ? accentColor
                                  : accentColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'addService.2.description3'.tr(),
            style: TextStyle(
              color: accentColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'addService.2.description3Hint'.tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xFFE21818),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 20.h),
          context.read<AddServiceCubit>().serviceImages.length == 0
              ? ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, "addImagesInAccommodation", arguments: {
                      "cxt": context,
                      "selectedimages": context.read<AddServiceCubit>().serviceImages,
                      "coverImageIndex": context.read<AddServiceCubit>().serviceImageCoverImageNumber,
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    side: BorderSide(
                      color: Color(0xFFDFE2E6),
                    ),
                  ),
                  leading: Icon(
                    Icons.add,
                  ),
                  title: Text(
                    'addService.2.add'.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.file(
                      File(context.read<AddServiceCubit>().serviceImages[context.read<AddServiceCubit>().serviceImageCoverImageNumber].path),
                      // height: 100.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "addImagesInAccommodation", arguments: {
                          "cxt": context,
                          "selectedimages": context.read<AddServiceCubit>().serviceImages,
                          "coverImageIndex": context.read<AddServiceCubit>().serviceImageCoverImageNumber,
                        });
                      },
                      child: Text(
                        'addService.editImage'.tr(),
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
          SizedBox(height: 25.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'addService.2.description4'.tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xFFE21818),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 20.h),
          roomNumBuilder(
              function: context.read<AddServiceCubit>().changeSingleRoomNum,
              number: context.read<AddServiceCubit>().singleRoomNum,
              title: 'addService.2.single'.tr()),
          roomNumBuilder(
              function: context.read<AddServiceCubit>().changeDoubleRoomeNum,
              number: context.read<AddServiceCubit>().doubleRoomNum,
              title: 'addService.2.double'.tr()),
          roomNumBuilder(
              function: context.read<AddServiceCubit>().changeTripleRoomNum,
              number: context.read<AddServiceCubit>().tripleRoomNum,
              title: 'addService.2.triple'.tr()),
          roomNumBuilder(
              function: context.read<AddServiceCubit>().changeKingRoomNum,
              number: context.read<AddServiceCubit>().kingRoomNum,
              title: 'addService.2.king'.tr()),
          Divider(),
          ListTile(
            title: Text(
              'addService.2.totalNumOfRooms'.tr(),
              style: TextStyle(
                color: accentColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(right: 29.w),
              child: Text(
                context.read<AddServiceCubit>().sumOfAllRooms.toString(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ListTile roomNumBuilder({
    required Function function,
    required String title,
    required int number,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: accentColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: SizedBox(
        width: 70.w,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                function(isAdded: false);
              },
              child: Icon(
                Icons.remove_circle_outline,
                size: 24.sp,
              ),
            ),
            Text(
              number.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: accentColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () {
                function(isAdded: true);
              },
              child: Icon(
                Icons.add_circle_outline,
                size: 24.sp,
              ),
            ),
          ],
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
          onChanged: (value) {},
          obscureText: obstructText,
          keyboardType: inputType,
          maxLines: 7,
          style: TextStyle(
            color: accentColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),

            hintText: hint.tr(),
            hintStyle: TextStyle(
              color: Color(0xFFCECFD1),
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
