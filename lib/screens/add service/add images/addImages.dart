import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/dotted%20container/dottedRect.dart';
import 'package:PassPort/services/add%20service/add%20images/add_images_cubit.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';

class AddImages extends StatelessWidget {
  final String i = "";
  const AddImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'addService.addImage.title'.tr(),
          style: TextStyle(
            color: black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocProvider<AddImagesCubit>(
        create: (context) => AddImagesCubit(),
        child: BlocConsumer<AddImagesCubit, AddImagesState>(
          listener: (context, state) {},
          builder: (context, state) {
            BlocProvider.of<AddImagesCubit>(context).serviceImages.clear();
            BlocProvider.of<AddImagesCubit>(context).serviceImages.addAll(args['selectedimages']);
            BlocProvider.of<AddImagesCubit>(context).serviceImageCoverImageNumber = args['coverImageIndex'];
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'addService.addImage.hint'.tr(),
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
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20.h),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: BlocProvider.of<AddImagesCubit>(context).serviceImages.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.h);
                  },
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Image.file(
                          File(BlocProvider.of<AddImagesCubit>(context).serviceImages[index].path),
                          width: 1.sw,
                        ),
                        // Positioned(
                        //   top: 10.h,
                        //   left: 10.w,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       showModalBottomSheet(
                        //         context: context,
                        //         builder: (x) => bottomSheetBuilder(
                        //           context,
                        //           index: index,
                        //           cxt: args['cxt'],
                        //           args: args,
                        //         ),
                        //       );
                        //       // BlocProvider.of<AddImagesCubit>(context).serviceImages.removeAt(index);
                        //       // BlocProvider.of<AddImagesCubit>(context).emit(AddServiceImagesChanged());
                        //     },
                        //     child: Container(
                        //       padding: EdgeInsets.all(5),
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         shape: BoxShape.circle,
                        //       ),
                        //       child: Icon(
                        //         Icons.more_vert_rounded,
                        //         color: black,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          top: 15.h,
                          right: 10.w,
                          child: index == BlocProvider.of<AddImagesCubit>(context).serviceImageCoverImageNumber
                              ? Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    'addService.imageCover'.tr(),
                                    style: TextStyle(
                                      color: accentColor,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        )
                      ],
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<AddImagesCubit>(context).addServiceImages(
                            args["cxt"],
                          );
                        },
                        child: DashedRect(
                          color: accentColor,
                          strokeWidth: 1,
                          gap: 5,
                          child: Container(
                            height: 150.h,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'addService.addImage.sub1'.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: accentColor,
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
                          BlocProvider.of<AddImagesCubit>(context).addServiceImagesFromCamera(
                            args["cxt"],
                          );
                        },
                        child: DashedRect(
                          color: accentColor,
                          strokeWidth: 1,
                          gap: 5,
                          child: Container(
                            height: 150.h,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'addService.addImage.sub2'.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: accentColor,
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
                ),
                SizedBox(height: 20.h),
              ],
            );
          },
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      //   child: ElevatedButton(
      //     onPressed: () {},
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: orange,
      //       padding: EdgeInsets.symmetric(vertical: 15.h),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(10.r),
      //       ),
      //     ),
      //     child: Text(
      //       'register.next'.tr(),
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 16.sp,
      //         fontWeight: FontWeight.w700,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  bottomSheetBuilder(BuildContext context, {required int index, required BuildContext cxt, required Map args}) {
    return Container(
      height: 250.h,
      child: Column(
        children: [
          ListTile(
            title: Text(
              'addService.editImage'.tr(),
              style: TextStyle(
                color: accentColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: 10.h),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'addService.setDefault'.tr(),
              style: TextStyle(
                color: accentColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.pop(context);

              BlocProvider.of<AddImagesCubit>(context).changeServiceImageCoverImageNumber(cxt, index);
              args['coverImageIndex'] = index;
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text(
              'addService.deleteImage'.tr(),
              style: TextStyle(
                color: accentColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              if (index != args['coverImageIndex']) {
                context.read<AddImagesCubit>().removeServiceImage(cxt, index);
              } else {}
              // BlocProvider.of<AddImagesCubit>(context).emit(AddServiceImagesChanged());
            },
          ),
        ],
      ),
    );
  }
}
