import 'dart:io';

import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddServicePage extends StatelessWidget {
  const AddServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AddServiceCubit>().locationForm,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              // Property Name Section
              _buildSection(
                context,
                icon: Icons.business,
                title: 'Property Name',
                child: _buildTextField(
                  context,
                  hint: 'addService.1.servicesNameHint'.tr(),
                  controller:
                      context.read<AddServiceCubit>().placeNameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter property name' : null,
                ),
              ),

              // Full Description Section
              _buildSection(
                context,
                icon: Icons.description,
                title: 'Full Description',
                child: _buildTextField(
                  context,
                  hint: 'Enter full description',
                  controller:
                      context.read<AddServiceCubit>().serviceNameController,
                  maxLines: 5,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter description' : null,
                ),
              ),

              // Location Section
              _buildSection(
                context,
                icon: Icons.location_on,
                title: 'Location',
                child: Column(
                  children: [
                    _buildTextField(
                      context,
                      hint: 'addService.1.addressHint'.tr(),
                      controller:
                          context.read<AddServiceCubit>().addressController,
                      label: 'Address',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter address' : null,
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      context,
                      hint: 'addService.1.cityHint'.tr(),
                      controller:
                          context.read<AddServiceCubit>().cityController,
                      label: 'City',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter city' : null,
                    ),
                  ],
                ),
              ),

              // Government Section
              _buildSection(
                context,
                icon: Icons.account_balance,
                title: 'Government',
                child: _buildTextField(
                  context,
                  hint: 'addService.1.governateHint'.tr(),
                  controller:
                      context.read<AddServiceCubit>().governateController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter government' : null,
                ),
              ),

              // What's Included Section - Amenities
              _buildSection(
                context,
                icon: Icons.check_circle_outline,
                title: "What's Included",
                subtitle: 'Select amenities available at your property',
                isOptional: true,
                child: context.read<AddServiceCubit>().amenitiesModel == null
                    ? SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: [
                              ...List.generate(
                                context
                                    .read<AddServiceCubit>()
                                    .amenitiesModel!
                                    .data!
                                    .length,
                                (index) {
                                  final amenity = context
                                      .read<AddServiceCubit>()
                                      .amenitiesModel!
                                      .data![index];
                                  final isSelected = context
                                      .read<AddServiceCubit>()
                                      .amenities
                                      .contains(amenity.id);
                                  return GestureDetector(
                                    onTap: () {
                                      context
                                          .read<AddServiceCubit>()
                                          .addAmenities(amenity.id!);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 12.h),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? accentColor
                                            : appBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        border: Border.all(
                                          color: isSelected
                                              ? accentColor
                                              : Colors.grey.shade300,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            isSelected
                                                ? Icons.check_circle
                                                : Icons.circle_outlined,
                                            color: isSelected
                                                ? Colors.white
                                                : accentColor,
                                            size: 18.r,
                                          ),
                                          SizedBox(width: 6.w),
                                          Text(
                                            amenity.name!,
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : accentColor,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // زر Other
                              // BlocBuilder<AddServiceCubit, AddServiceState>(
                              //   builder: (context, state) {
                              //     final isOtherSelected = context
                              //         .read<AddServiceCubit>()
                              //         .isOtherAmenitySelected;
                              //     return GestureDetector(
                              //       onTap: () {
                              //         context
                              //             .read<AddServiceCubit>()
                              //             .toggleOtherAmenity();
                              //       },
                              //       child: Container(
                              //         padding: EdgeInsets.symmetric(
                              //             horizontal: 16.w, vertical: 12.h),
                              //         decoration: BoxDecoration(
                              //           color: isOtherSelected
                              //               ? accentColor
                              //               : appBackgroundColor,
                              //           borderRadius:
                              //               BorderRadius.circular(12.r),
                              //           border: Border.all(
                              //             color: isOtherSelected
                              //                 ? accentColor
                              //                 : Colors.grey.shade300,
                              //             width: 1,
                              //           ),
                              //         ),
                              //         child: Row(
                              //           mainAxisSize: MainAxisSize.min,
                              //           children: [
                              //             Icon(
                              //               isOtherSelected
                              //                   ? Icons.check_circle
                              //                   : Icons.add_circle_outline,
                              //               color: isOtherSelected
                              //                   ? Colors.white
                              //                   : accentColor,
                              //               size: 18.r,
                              //             ),
                              //             SizedBox(width: 6.w),
                              //             Text(
                              //               'Other',
                              //               style: TextStyle(
                              //                 color: isOtherSelected
                              //                     ? Colors.white
                              //                     : accentColor,
                              //                 fontSize: 13.sp,
                              //                 fontWeight: FontWeight.w600,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),
                            ],
                          ),
                          // الـ Input Field للـ Custom Amenity
                          // BlocBuilder<AddServiceCubit, AddServiceState>(
                          //   builder: (context, state) {
                          //     if (!context
                          //         .read<AddServiceCubit>()
                          //         .isOtherAmenitySelected) {
                          //       return SizedBox.shrink();
                          //     }
                          //     return Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         SizedBox(height: 16.h),
                          //         Container(
                          //           padding: EdgeInsets.all(16.r),
                          //           decoration: BoxDecoration(
                          //             color: Colors.blue.shade50,
                          //             borderRadius: BorderRadius.circular(12.r),
                          //             border: Border.all(
                          //                 color: Colors.blue.shade200),
                          //           ),
                          //           child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Row(
                          //                 children: [
                          //                   Icon(Icons.info_outline,
                          //                       color: Colors.blue.shade700,
                          //                       size: 20.r),
                          //                   SizedBox(width: 8.w),
                          //                   Text(
                          //                     'Add Custom Amenity',
                          //                     style: TextStyle(
                          //                       color: Colors.blue.shade700,
                          //                       fontSize: 14.sp,
                          //                       fontWeight: FontWeight.w700,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //               SizedBox(height: 12.h),
                          //               TextFormField(
                          //                 controller: context
                          //                     .read<AddServiceCubit>()
                          //                     .customAmenityController,
                          //                 style: TextStyle(
                          //                   color: accentColor,
                          //                   fontSize: 14.sp,
                          //                   fontWeight: FontWeight.w400,
                          //                 ),
                          //                 decoration: InputDecoration(
                          //                   contentPadding:
                          //                       EdgeInsets.symmetric(
                          //                           horizontal: 16.w,
                          //                           vertical: 14.h),
                          //                   hintText:
                          //                       'Enter custom amenity name',
                          //                   hintStyle: TextStyle(
                          //                     color: Colors.grey.shade400,
                          //                     fontSize: 14.sp,
                          //                     fontWeight: FontWeight.w400,
                          //                   ),
                          //                   filled: true,
                          //                   fillColor: Colors.white,
                          //                   border: OutlineInputBorder(
                          //                     borderRadius:
                          //                         BorderRadius.circular(10.r),
                          //                     borderSide: BorderSide(
                          //                         color: Colors.grey.shade300,
                          //                         width: 1),
                          //                   ),
                          //                   enabledBorder: OutlineInputBorder(
                          //                     borderRadius:
                          //                         BorderRadius.circular(10.r),
                          //                     borderSide: BorderSide(
                          //                         color: Colors.grey.shade300,
                          //                         width: 1),
                          //                   ),
                          //                   focusedBorder: OutlineInputBorder(
                          //                     borderRadius:
                          //                         BorderRadius.circular(10.r),
                          //                     borderSide: BorderSide(
                          //                         color: accentColor, width: 2),
                          //                   ),
                          //                   suffixIcon: IconButton(
                          //                     icon: Icon(Icons.add_circle,
                          //                         color: accentColor),
                          //                     onPressed: () {
                          //                       final text = context
                          //                           .read<AddServiceCubit>()
                          //                           .customAmenityController
                          //                           .text
                          //                           .trim();
                          //                       if (text.isNotEmpty) {
                          //                         context
                          //                             .read<AddServiceCubit>()
                          //                             .addCustomAmenity(text);
                          //                         context
                          //                             .read<AddServiceCubit>()
                          //                             .customAmenityController
                          //                             .clear();
                          //                       }
                          //                     },
                          //                   ),
                          //                 ),
                          //               ),
                          //               // عرض الـ Custom Amenities المضافة
                          //               if (context
                          //                   .read<AddServiceCubit>()
                          //                   .customAmenities
                          //                   .isNotEmpty) ...[
                          //                 SizedBox(height: 12.h),
                          //                 Wrap(
                          //                   spacing: 8.w,
                          //                   runSpacing: 8.h,
                          //                   children: context
                          //                       .read<AddServiceCubit>()
                          //                       .customAmenities
                          //                       .map((customAmenity) {
                          //                     return Container(
                          //                       padding: EdgeInsets.symmetric(
                          //                           horizontal: 12.w,
                          //                           vertical: 8.h),
                          //                       decoration: BoxDecoration(
                          //                         color: Colors.green.shade100,
                          //                         borderRadius:
                          //                             BorderRadius.circular(
                          //                                 8.r),
                          //                         border: Border.all(
                          //                             color: Colors
                          //                                 .green.shade300),
                          //                       ),
                          //                       child: Row(
                          //                         mainAxisSize:
                          //                             MainAxisSize.min,
                          //                         children: [
                          //                           Icon(Icons.check,
                          //                               color: Colors
                          //                                   .green.shade700,
                          //                               size: 16.r),
                          //                           SizedBox(width: 6.w),
                          //                           Text(
                          //                             customAmenity,
                          //                             style: TextStyle(
                          //                               color: Colors
                          //                                   .green.shade700,
                          //                               fontSize: 12.sp,
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                           SizedBox(width: 6.w),
                          //                           GestureDetector(
                          //                             onTap: () {
                          //                               context
                          //                                   .read<
                          //                                       AddServiceCubit>()
                          //                                   .removeCustomAmenity(
                          //                                       customAmenity);
                          //                             },
                          //                             child: Icon(Icons.close,
                          //                                 color: Colors
                          //                                     .green.shade700,
                          //                                 size: 16.r),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     );
                          //                   }).toList(),
                          //                 ),
                          //               ],
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // ),
                        ],
                      ),
              ),

              // Rules Section
              _buildSection(
                context,
                icon: Icons.rule,
                title: 'Rules And Cancellation Policy',
                isOptional: true,
                child: _buildTextField(
                  context,
                  hint: 'Enter rules and cancellation policy',
                  controller: context.read<AddServiceCubit>().rulesController,
                  maxLines: 4,
                  isRequired: false,
                ),
              ),

              // Important Information Section
              _buildSection(
                context,
                icon: Icons.info_outline,
                title: 'Important Information',
                isOptional: true,
                child: _buildTextField(
                  context,
                  hint: 'Any additional important information',
                  controller:
                      context.read<AddServiceCubit>().importantController,
                  maxLines: 3,
                  isRequired: false,
                ),
              ),

              // Upload Photos Section
              _buildSection(
                context,
                icon: Icons.photo_library,
                title: 'Upload Photos',
                subtitle: 'Add photos of your property',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    context.read<AddServiceCubit>().serviceImages.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "addImagesInAccommodation",
                                  arguments: {
                                    "cxt": context,
                                    "selectedimages": context
                                        .read<AddServiceCubit>()
                                        .serviceImages,
                                    "coverImageIndex": context
                                        .read<AddServiceCubit>()
                                        .serviceImageCoverImageNumber,
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.all(32.r),
                              decoration: BoxDecoration(
                                color: appBackgroundColor,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color: Colors.grey.shade300,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.cloud_upload,
                                      size: 56.r,
                                      color:
                                          accentColor.withValues(alpha: 0.5)),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'Tap to upload photos',
                                    style: TextStyle(
                                      color: accentColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    'JPG, PNG up to 10MB',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.file(
                                  File(context
                                      .read<AddServiceCubit>()
                                      .serviceImages[context
                                          .read<AddServiceCubit>()
                                          .serviceImageCoverImageNumber]
                                      .path),
                                  height: 200.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Container(
                                padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border:
                                      Border.all(color: Colors.green.shade200),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: Colors.green, size: 20.r),
                                    SizedBox(width: 8.w),
                                    Text(
                                      '${context.read<AddServiceCubit>().serviceImages.length} photos uploaded',
                                      style: TextStyle(
                                        color: Colors.green.shade700,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "addImagesInAccommodation",
                                            arguments: {
                                              "cxt": context,
                                              "selectedimages": context
                                                  .read<AddServiceCubit>()
                                                  .serviceImages,
                                              "coverImageIndex": context
                                                  .read<AddServiceCubit>()
                                                  .serviceImageCoverImageNumber,
                                            });
                                      },
                                      child: Text('Edit',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      style: TextButton.styleFrom(
                                          foregroundColor: accentColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    if (context.read<AddServiceCubit>().serviceImages.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline,
                                color: Colors.red, size: 16.r),
                            SizedBox(width: 6.w),
                            Text(
                              'Please upload at least one photo',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Room Numbers Section
              _buildSection(
                context,
                icon: Icons.bed,
                title: 'Room Configuration',
                subtitle: 'Specify number of each room type',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: appBackgroundColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          _buildRoomCounter(
                            context,
                            title: 'addService.2.single'.tr(),
                            icon: Icons.single_bed,
                            number:
                                context.read<AddServiceCubit>().singleRoomNum,
                            onDecrease: () => context
                                .read<AddServiceCubit>()
                                .changeSingleRoomNum(isAdded: false),
                            onIncrease: () => context
                                .read<AddServiceCubit>()
                                .changeSingleRoomNum(isAdded: true),
                          ),
                          Divider(height: 1, color: Colors.grey.shade200),
                          _buildRoomCounter(
                            context,
                            title: 'addService.2.double'.tr(),
                            icon: Icons.bed,
                            number:
                                context.read<AddServiceCubit>().doubleRoomNum,
                            onDecrease: () => context
                                .read<AddServiceCubit>()
                                .changeDoubleRoomeNum(isAdded: false),
                            onIncrease: () => context
                                .read<AddServiceCubit>()
                                .changeDoubleRoomeNum(isAdded: true),
                          ),
                          Divider(height: 1, color: Colors.grey.shade200),
                          _buildRoomCounter(
                            context,
                            title: 'addService.2.triple'.tr(),
                            icon: Icons.king_bed,
                            number:
                                context.read<AddServiceCubit>().tripleRoomNum,
                            onDecrease: () => context
                                .read<AddServiceCubit>()
                                .changeTripleRoomNum(isAdded: false),
                            onIncrease: () => context
                                .read<AddServiceCubit>()
                                .changeTripleRoomNum(isAdded: true),
                          ),
                          Divider(height: 1, color: Colors.grey.shade200),
                          _buildRoomCounter(
                            context,
                            title: 'addService.2.king'.tr(),
                            icon: Icons.bedroom_parent,
                            number: context.read<AddServiceCubit>().kingRoomNum,
                            onDecrease: () => context
                                .read<AddServiceCubit>()
                                .changeKingRoomNum(isAdded: false),
                            onIncrease: () => context
                                .read<AddServiceCubit>()
                                .changeKingRoomNum(isAdded: true),
                          ),
                          Container(
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12.r),
                                bottomRight: Radius.circular(12.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.hotel,
                                        color: accentColor, size: 20.r),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Total Rooms',
                                      style: TextStyle(
                                        color: accentColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: accentColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            accentColor.withValues(alpha: 0.3),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    context
                                        .read<AddServiceCubit>()
                                        .sumOfAllRooms
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (context.read<AddServiceCubit>().sumOfAllRooms == 0)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline,
                                color: Colors.red, size: 16.r),
                            SizedBox(width: 6.w),
                            Text(
                              'Please add at least one room',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    bool isOptional = false,
    required Widget child,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: appBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: accentColor, size: 22.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (isOptional)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              'Optional',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        else
                          Text(
                            ' *',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                      ],
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String hint,
    required TextEditingController controller,
    String? label,
    int maxLines = 1,
    bool isRequired = true,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label,
            style: TextStyle(
              color: accentColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
        ],
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: isRequired ? validator : null,
          style: TextStyle(
            color: accentColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: accentColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomCounter(
    BuildContext context, {
    required String title,
    required IconData icon,
    required int number,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: accentColor, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: accentColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: onDecrease,
                  icon: Icon(Icons.remove_circle_outline,
                      color: number > 0 ? accentColor : Colors.grey,
                      size: 24.r),
                  padding: EdgeInsets.all(8.r),
                  constraints: BoxConstraints(),
                ),
                Container(
                  width: 40.w,
                  alignment: Alignment.center,
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onIncrease,
                  icon: Icon(Icons.add_circle_outline,
                      color: accentColor, size: 24.r),
                  padding: EdgeInsets.all(8.r),
                  constraints: BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
