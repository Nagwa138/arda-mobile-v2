import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/categories%20tab/accommodation/filter/filter_cubit.dart';

class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCubit(),
      child: BlocConsumer<FilterCubit, FilterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'accommodationsFilter.title'.tr(),
                style: TextStyle(
                  color: black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              children: [
                Text(
                  'accommodationsFilter.sort'.tr(),
                  style: TextStyle(
                    color: black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Wrap(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      child: GestureDetector(
                        onTap: () {
                          context.read<FilterCubit>().selectSort(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: context.read<FilterCubit>().selectedSort == index ? black : Color(0xFFEEEEEE),
                              width: 1.w,
                            ),
                          ),
                          child: Text(
                            'accommodationsFilter.sortCategories.${index + 1}'.tr(),
                            style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'accommodationsFilter.range'.tr(),
                  style: TextStyle(
                    color: black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          '0 ' + "currency".tr(),
                          style: TextStyle(
                            color: black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Slider(
                        value: context.read<FilterCubit>().currentPrice,
                        min: 0,
                        max: 100000,
                        divisions: 100000,
                        activeColor: orange,
                        label: context.read<FilterCubit>().currentPrice.round().toString(),
                        onChanged: (value) {
                          context.read<FilterCubit>().changePrice(value);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          '100K ' + "currency".tr(),
                          style: TextStyle(
                            color: black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  'accommodationsFilter.accommodationTitle'.tr(),
                  style: TextStyle(
                    color: black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    {
                      "image": 'assets/images/main/hotel.png',
                      "title": 'addService.1.hotel'.tr(),
                    },
                    {
                      "image": 'assets/images/main/tent.png',
                      "title": 'addService.1.camp'.tr(),
                    },
                  ]
                      .map(
                        (e) => Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Color(0xFFB2BBC6),
                                ),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  e["image"]!,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                Text(
                                  e["title"]!,
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 20.h),
                Text(
                  'accommodationsFilter.roomType'.tr(),
                  style: TextStyle(
                    color: black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Wrap(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      child: GestureDetector(
                        onTap: () {
                          context.read<FilterCubit>().selectRoomType(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: context.read<FilterCubit>().selectedRoomType == index ? black : Color(0xFFEEEEEE),
                              width: 1.w,
                            ),
                          ),
                          child: Text(
                            'accommodationsFilter.roomTypeCategories.${index + 1}'.tr(),
                            style: TextStyle(
                              color: black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'accommodationsFilter.people'.tr(),
                  style: TextStyle(
                    color: black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      7,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
                        child: GestureDetector(
                          onTap: () {
                            // context.read<FilterCubit>().selectRoomType(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                // color: context.read<FilterCubit>().selectedRoomType == index ? black : Color(0xFFEEEEEE),
                                color: Color(0xFFEEEEEE),
                                width: 1.w,
                              ),
                            ),
                            child: Text(
                              'accommodationsFilter.peopleNumber.${index + 1}'.tr(),
                              style: TextStyle(
                                color: black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'accommodationsFilter.service'.tr(),
                  style: TextStyle(
                    color: black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CheckboxListTile(
                  value: true,
                  contentPadding: EdgeInsets.zero,
                  activeColor: orange,
                  onChanged: (value) {},
                  title: Text(
                    'accommodationsFilter.included'.tr(),
                    style: TextStyle(
                      color: black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                CheckboxListTile(
                  value: false,
                  contentPadding: EdgeInsets.zero,
                  activeColor: orange,
                  onChanged: (value) {},
                  title: Text(
                    'accommodationsFilter.notIncluded'.tr(),
                    style: TextStyle(
                      color: black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'accommodationsFilter.amenities'.tr(),
                  style: TextStyle(
                    color: black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CheckboxListTile(
                  value: false,
                  contentPadding: EdgeInsets.zero,
                  activeColor: orange,
                  onChanged: (value) {},
                  title: Text(
                    'Services.internet'.tr(),
                    style: TextStyle(
                      color: black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                CheckboxListTile(
                  value: true,
                  contentPadding: EdgeInsets.zero,
                  activeColor: orange,
                  onChanged: (value) {},
                  title: Text(
                    'Services.air'.tr(),
                    style: TextStyle(
                      color: black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                CheckboxListTile(
                  value: true,
                  contentPadding: EdgeInsets.zero,
                  activeColor: orange,
                  onChanged: (value) {},
                  title: Text(
                    'Services.bath'.tr(),
                    style: TextStyle(
                      color: black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'accommodationsFilter.hostLang'.tr(),
                  style: TextStyle(
                    color: black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: false,
                        contentPadding: EdgeInsets.zero,
                        activeColor: orange,
                        onChanged: (value) {},
                        title: Text(
                          'accommodationsFilter.ar'.tr(),
                          style: TextStyle(
                            color: black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        value: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        activeColor: orange,
                        onChanged: (value) {},
                        title: Text(
                          'accommodationsFilter.en'.tr(),
                          style: TextStyle(
                            color: black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50.h,
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: orange,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'accommodationsFilter.reset'.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                      color: orange,
                    ),
                    child: Center(
                      child: Text(
                        'accommodationsFilter.apply'.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: white,
                          fontWeight: FontWeight.w600,
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
