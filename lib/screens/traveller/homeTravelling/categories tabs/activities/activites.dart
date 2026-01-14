import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/activity_cubit/activity_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/activity_cubit/activity_stata.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Activities extends StatelessWidget {
  const Activities({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ActivityCubit()..getAllActivity(),
        child: BlocConsumer<ActivityCubit, ActivityState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: appBackgroundColor,
                  appBar: AppBar(
                      elevation: 0.0,
                      backgroundColor: appBackgroundColor,
                      centerTitle: true,
                      title: Text("Adventure",
                          style: TextStyle(
                              color: accentColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp))),
                  body: state is GetActivityLoading
                      ? Center(
                          child: CircularProgressIndicator(color: accentColor))
                      : ActivityCubit.get(context)
                              .getAllActivityModel!
                              .data!
                              .isEmpty
                          ? Center(
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            "assets/images/landingHome/notificationEmpty.png"),
                                        Text(
                                            textAlign: TextAlign.center,
                                            "You havenâ€™t any Adventure Now",
                                            style: TextStyle(
                                                color: accentColor,
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.w400))
                                      ])))
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              itemCount: ActivityCubit.get(context)
                                  .getAllActivityModel
                                  ?.data
                                  ?.length,
                              itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  child: Container(
                                      margin: EdgeInsets.only(right: 16.w),
                                      width: 1.sw,
                                      decoration: ShapeDecoration(
                                          color: Colors.white54,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r))),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, 'activitiesDetails',
                                                arguments: {
                                                  'activityId':
                                                      ActivityCubit.get(context)
                                                          .getAllActivityModel!
                                                          .data![index]
                                                          .id
                                                          .toString(),
                                                  'activityName':
                                                      ActivityCubit.get(context)
                                                          .getAllActivityModel!
                                                          .data![index]
                                                          .activitieName
                                                          .toString(),
                                                  'rate':
                                                      ActivityCubit.get(context)
                                                          .getAllActivityModel!
                                                          .data![index]
                                                          .rate
                                                          .toString(),
                                                  'price':
                                                      ActivityCubit.get(context)
                                                          .getAllActivityModel!
                                                          .data![index]
                                                          .pricePerPerson
                                                          .toString(),
                                                  'des':
                                                      ActivityCubit.get(context)
                                                          .getAllActivityModel!
                                                          .data![index]
                                                          .description
                                                          .toString(),
                                                  'image':
                                                      ActivityCubit.get(context)
                                                          .getAllActivityModel!
                                                          .data![index]
                                                          .image
                                                          .toString(),
                                                  "text": "activity"
                                                });
                                          },
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 14.h),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12.r)),
                                                        child: CustomImage(
                                                          ActivityCubit.get(
                                                                  context)
                                                              .getAllActivityModel!
                                                              .data![index]
                                                              .image
                                                              ?.toString(),
                                                          height: 200.h,
                                                          width: 1.sw,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16.w),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(children: [
                                                            Container(
                                                                width: 160.w,
                                                                child: Text(
                                                                    ActivityCubit.get(
                                                                            context)
                                                                        .getAllActivityModel!
                                                                        .data![
                                                                            index]
                                                                        .activitieName
                                                                        .toString(),
                                                                    // "Water Play Activity",
                                                                    style: TextStyle(
                                                                        color:
                                                                            accentColor,
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w600))),
                                                            Spacer(),
                                                            Icon(Icons.star,
                                                                color: Color(
                                                                    0xFFFFCE47),
                                                                size: 20.sp),
                                                            Text(
                                                                ActivityCubit.get(
                                                                        context)
                                                                    .getAllActivityModel!
                                                                    .data![
                                                                        index]
                                                                    .rate
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        accentColor,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500))
                                                          ]),
                                                          SizedBox(
                                                              height: 10.h),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .watch_later_outlined,
                                                                    color:
                                                                        orange,
                                                                    size:
                                                                        16.sp),
                                                                SizedBox(
                                                                    width: 3.w),
                                                                SizedBox(
                                                                    width: 55.w,
                                                                    child: Text(
                                                                        ActivityCubit.get(context)
                                                                            .getAllActivityModel!
                                                                            .data![
                                                                                index]
                                                                            .duration
                                                                            .toString(),
                                                                        // "3 days",
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        style: TextStyle(
                                                                            color:
                                                                                accentColor,
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w400))),
                                                                Spacer(),
                                                                Text.rich(TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          text:
                                                                              '${ActivityCubit.get(context).getAllActivityModel!.data![index].pricePerPerson.toString()} ${context.locale.languageCode == 'ar' ? "Ø¬Ù†ÙŠØ©" : "EGP"}',
                                                                          style: TextStyle(
                                                                              color: accentColor,
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600)),
                                                                    ]))
                                                              ]),
                                                          SizedBox(
                                                              height: 10.h),
                                                        ])),
                                              ]))))));
            }));
  }
}
