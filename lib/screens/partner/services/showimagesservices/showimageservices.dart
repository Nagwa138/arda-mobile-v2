import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';

class ShowImageServices extends StatelessWidget {
  const ShowImageServices({super.key});

  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context)?.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Services.imagePlaces".tr(),
          style: TextStyle(
            color: black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700))),
      body: GridView.builder(
        itemCount: args.length,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h),
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(7.r),
          child: CustomImage(
            args[index],
            fit: BoxFit.cover))));
  }
}
