import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/accomadationType_cubit/accomadtion_type_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/accomadationType_cubit/acommedtion_type_state.dart';
import 'package:PassPort/version2_module/core/const/app_colors.dart';
import 'package:PassPort/version2_module/core/widgets/custom_carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

//import AccomandtionByIdModelone
import '../../../../../../models/traveller/accomandating/accomandtionByIdone.dart';

class RoomInformation extends StatelessWidget {
  const RoomInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(
      create: (context) => AccommodatingCubit()
        ..getOneAccommodating(oneAccomandationPrivate: arguments['id']),
      child: BlocConsumer<AccommodatingCubit, AccommodatingState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetOneAccommodatingLoading) {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(
                color: accentColor,
              ),
            ));
          }

          final data =
              AccommodatingCubit.get(context).accomandtionByIdModel?.data;
          print(data?.amenityName);

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: CustomScrollView(
                  slivers: [
                    // App Bar with Image
                    SliverAppBar(
                      expandedHeight: 280.h,
                      pinned: true,
                      backgroundColor: appBackgroundColor,
                      elevation: 0,
                      leading: Container(
                        margin: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back_ios_new,
                              color: accentColor, size: 20.r),
                        ),
                      ),
                      actions: [
                        if (arguments['text'] != "Favourite")
                          Container(
                            margin: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                data?.isFav == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: data?.isFav == true
                                    ? Colors.red
                                    : accentColor,
                              ),
                              onPressed: () {
                                if (data?.isFav == true) {
                                  AccommodatingCubit.get(context)
                                      .deleteFavouriteOfAccommodating(
                                          AccomId: arguments['id']);
                                } else {
                                  AccommodatingCubit.get(context)
                                      .addFavouriteOfAccommodating(
                                          AccomId: arguments['id']);
                                }
                                AccommodatingCubit.get(context)
                                    .changeFavHotel(data?.isFav);
                              },
                            ),
                          ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: _buildHeroImage(data),
                      ),
                    ),

                    // Content
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),

                            // Title
                            Text(
                              data?.serviceName ?? 'No details',
                              style: TextStyle(
                                  color: accentColor,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5),
                            ),
                            SizedBox(height: 8.h),

                            // Rating Section
                            Container(
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color: appBackgroundColor,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      (data?.rate ?? 0).toInt(),
                                      (index) => Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                        size: 22.r,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    data?.rate?.toString() ?? '0',
                                    style: TextStyle(
                                      color: accentColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text("•",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16.sp)),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "commentsAndRating",
                                            arguments: {
                                              'id': arguments['id'],
                                              'state': '0'
                                            });
                                      },
                                      child: Text(
                                        '${data?.reviewrsCount ?? 0} ${'roomInfo.reviews'.tr()}',
                                        style: TextStyle(
                                          color: blue,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),

                            // Price Section (جديد)
                            if (data?.reservationPrice != null)
                              Container(
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.buttonColor
                                          .withValues(alpha: 0.1),
                                      AppColors.buttonColor
                                          .withValues(alpha: 0.05),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                      color: AppColors.buttonColor
                                          .withValues(alpha: 0.3)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Starting from',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Row(
                                          children: [
                                            Text(
                                              '\$${data!.reservationPrice}',
                                              style: TextStyle(
                                                color: AppColors.buttonColor,
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Text(
                                              '/night',
                                              style: TextStyle(
                                                color: accentColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.attach_money_rounded,
                                      color: AppColors.buttonColor,
                                      size: 36.r,
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(height: 24.h),

                            // About Section
                            _buildSectionTitle('roomInfo.about'.tr()),
                            SizedBox(height: 12.h),
                            Text(
                              data?.serviceDesc?.isNotEmpty == true
                                  ? data!.serviceDesc!
                                  : 'No details',
                              style: TextStyle(
                                color: accentColor.withValues(alpha: 0.8),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 24.h),

                            // Special Features
                            if (data?.specialName?.isNotEmpty == true)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionTitle('Special Features'),
                                  SizedBox(height: 12.h),
                                  SizedBox(
                                    height: 3.h,
                                    child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.textColor
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          border: Border.all(
                                              color: AppColors.textColor
                                                  .withValues(alpha: 0.3),
                                              width: 1),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.check_circle,
                                                color: AppColors.textColor,
                                                size: 16.r),
                                            SizedBox(width: 6.w),
                                            Text(
                                              data.specialName![index],
                                              style: TextStyle(
                                                color: AppColors.textColor,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 10.w),
                                      itemCount: data!.specialName!.length,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                ],
                              ),

                            //!MARK // Amenities Section
                            // if (data?.amenityName?.isNotEmpty == true) ...[
                            //   _buildSectionTitle('roomInfo.title1'.tr()),
                            //   SizedBox(height: 12.h),
                            //   GridView.builder(
                            //     shrinkWrap: true,
                            //     padding: EdgeInsets.zero,
                            //     physics: NeverScrollableScrollPhysics(),
                            //     gridDelegate:
                            //         SliverGridDelegateWithFixedCrossAxisCount(
                            //       crossAxisCount: 2,
                            //       crossAxisSpacing: 12.w,
                            //       mainAxisSpacing: 12.h,
                            //       childAspectRatio: 4.5,
                            //     ),
                            //     itemCount: data!.amenityName!.length,
                            //     itemBuilder: (context, index) {
                            //       var icons = [
                            //         Icons.wifi,
                            //         Icons.ac_unit,
                            //         Icons.tv,
                            //         Icons.dry_cleaning,
                            //         Icons.pool,
                            //         Icons.restaurant,
                            //         Icons.local_parking,
                            //         Icons.fitness_center,
                            //       ];
                            //       return Container(
                            //         padding: EdgeInsets.symmetric(
                            //             horizontal: 6.w, vertical: 6.h),
                            //         decoration: BoxDecoration(
                            //           color: appBackgroundColor,
                            //           borderRadius: BorderRadius.circular(10.r),
                            //           border: Border.all(
                            //               color: Colors.grey.shade200,
                            //               width: 1),
                            //         ),
                            //         child: Row(
                            //           children: [
                            //             Icon(
                            //               icons[index % icons.length],
                            //               color: accentColor,
                            //               size: 20.r,
                            //             ),
                            //             SizedBox(width: 8.w),
                            //             Expanded(
                            //               child: Text(
                            //                 data.amenityName![index],
                            //                 style: TextStyle(
                            //                   color: accentColor,
                            //                   fontSize: 12.sp,
                            //                   fontWeight: FontWeight.w600,
                            //                 ),
                            //                 overflow: TextOverflow.ellipsis,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //   ),
                            //   SizedBox(height: 24.h),
                            // ],

                            // Rating Stats Section
                            _buildSectionTitle('roomInfo.title2'.tr()),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(20.r),
                                    decoration: BoxDecoration(
                                      color: appBackgroundColor,
                                      borderRadius: BorderRadius.circular(16.r),
                                      border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 1.5),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(Icons.star_rounded,
                                            color: Colors.amber, size: 32.r),
                                        SizedBox(height: 12.h),
                                        Text(
                                          data?.rate?.toString() ?? '0',
                                          style: TextStyle(
                                            color: accentColor,
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          'roomInfo.overall'.tr(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: accentColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "${data?.reviewrsCount ?? 0} ${'roomInfo.reviews'.tr()}",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(20.r),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.buttonColor,
                                          AppColors.buttonColor
                                              .withValues(alpha: 0.8)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(Icons.thumb_up_rounded,
                                            color: white, size: 32.r),
                                        SizedBox(height: 12.h),
                                        Text(
                                          '${data?.recomondedPercentage ?? 0}%',
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          'roomInfo.recommend'.tr(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          'Would book again',
                                          style: TextStyle(
                                            color: white.withValues(alpha: 0.8),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),

                            // Reviews Section
                            if (data?.reviews?.isNotEmpty == true) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildSectionTitle('Reviews'),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "commentsAndRating",
                                          arguments: {
                                            'id': arguments['id'],
                                            'state': '0'
                                          });
                                    },
                                    child: Text(
                                      'See All',
                                      style: TextStyle(
                                        color: blue,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Container(
                                decoration: BoxDecoration(
                                  color: appBackgroundColor,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                      color: Colors.grey.shade200, width: 1),
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.all(16.r),
                                  itemCount: data!.reviews!.length > 4
                                      ? 4
                                      : data.reviews!.length,
                                  separatorBuilder: (context, index) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    child: Divider(height: 1),
                                  ),
                                  itemBuilder: (context, index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20.r,
                                            backgroundColor: AppColors
                                                .primaryColor
                                                .withValues(alpha: 0.1),
                                            child: Icon(Icons.person,
                                                color: AppColors.primaryColor),
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.reviews![index]
                                                          .userName ??
                                                      'No details',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: accentColor,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Row(
                                                  children: [
                                                    ...List.generate(
                                                      (data.reviews![index]
                                                                  .rating ??
                                                              0)
                                                          .toInt(),
                                                      (starIndex) => Icon(
                                                        Icons.star_rounded,
                                                        color: Colors.amber,
                                                        size: 16.r,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      data.reviews![index]
                                                              .time ??
                                                          '',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.grey,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Text(
                                        data.reviews![index].comment ??
                                            'No details',
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                          color: accentColor.withValues(
                                              alpha: 0.7),
                                          fontSize: 14.sp,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 28.h),
                            ],

                            // Location Section
                            _buildSectionTitle('roomInfo.title3'.tr()),
                            SizedBox(height: 12.h),
                            Container(
                              padding: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: appBackgroundColor,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color: Colors.grey.shade200, width: 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                          color: AppColors.textColor
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: Icon(
                                          Icons.location_on,
                                          color: AppColors.textColor,
                                          size: 20.r,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data?.address?.isNotEmpty == true
                                                  ? data!.address!
                                                  : 'No details',
                                              style: TextStyle(
                                                color: accentColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                height: 1.4,
                                              ),
                                            ),
                                            if (data?.city?.isNotEmpty ==
                                                    true ||
                                                data?.government?.isNotEmpty ==
                                                    true) ...[
                                              SizedBox(height: 6.h),
                                              Text(
                                                '${data?.city ?? ''}, ${data?.government ?? ''}',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (data?.website?.isNotEmpty == true) ...[
                                    SizedBox(height: 16.h),
                                    Divider(height: 1),
                                    SizedBox(height: 16.h),
                                    Text(
                                      'roomInfo.subtitle3'.tr(),
                                      style: TextStyle(
                                        color: accentColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    GestureDetector(
                                      onTap: () async {
                                        await launch(data.website!);
                                      },
                                      child: Text(
                                        data!.website!,
                                        style: TextStyle(
                                          color: blue,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // Contact Section
                            if (data?.language?.isNotEmpty == true ||
                                data?.officialPhone?.isNotEmpty == true) ...[
                              _buildSectionTitle('roomInfo.title4'.tr()),
                              SizedBox(height: 12.h),

                              // Language
                              if (data?.language?.isNotEmpty == true)
                                Container(
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                    color: appBackgroundColor,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                        color: Colors.grey.shade200, width: 1),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                          color: AppColors.textColor
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: Icon(
                                          Icons.language,
                                          color: AppColors.textColor,
                                          size: 20.r,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'roomInfo.availableLang'.tr(),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              data!.language!,
                                              style: TextStyle(
                                                color: accentColor,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              // Phone
                              if (data?.officialPhone?.isNotEmpty == true)
                                Container(
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                    color: appBackgroundColor,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                        color: Colors.grey.shade200, width: 1),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                          color: AppColors.textColor
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: Icon(
                                          Icons.phone,
                                          color: AppColors.textColor,
                                          size: 20.r,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          // تابع من السطر السابق - Contact Section
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Phone Number',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              data!.officialPhone!,
                                              style: TextStyle(
                                                color: accentColor,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
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

                            // Rooms Information (جديد)
                            if (data?.room?.isNotEmpty == true) ...[
                              _buildSectionTitle('Available Rooms'),
                              ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data!.room!.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 12.h),
                                itemBuilder: (context, index) {
                                  final room = data.room![index];
                                  return Container(
                                    padding: EdgeInsets.all(16.r),
                                    decoration: BoxDecoration(
                                      color: appBackgroundColor,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                room.roomType ?? 'No details',
                                                style: TextStyle(
                                                  color: accentColor,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                  vertical: 6.h),
                                              decoration: BoxDecoration(
                                                color: AppColors.buttonColor
                                                    .withValues(alpha: 0.1),
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                              child: Text(
                                                '\$${room.price ?? 0}',
                                                style: TextStyle(
                                                  color: AppColors.buttonColor,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12.h),
                                        _buildRoomDetail(Icons.people,
                                            '${room.guestNum ?? 0} Guests'),
                                        if (room.includeBreakFast == true) ...[
                                          SizedBox(height: 8.h),
                                          Row(
                                            children: [
                                              Icon(Icons.free_breakfast,
                                                  size: 16.r,
                                                  color: Colors.green),
                                              SizedBox(width: 6.w),
                                              Text(
                                                'Breakfast Included',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 24.h),
                            ],

                            // Policies Section
                            _buildSectionTitle('roomInfo.title6'.tr()),
                            SizedBox(height: 12.h),
                            Container(
                              padding: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: appBackgroundColor,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color: Colors.grey.shade200, width: 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildPolicyItem(
                                    'roomInfo.subtitle6-1'.tr(),
                                    'roomInfo.subtitle6-2'.tr(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // Important Info
                            Container(
                              padding: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color: Colors.blue.shade200, width: 1),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: blue,
                                    size: 24.r,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'roomInfo.title7'.tr(),
                                          style: TextStyle(
                                            color: accentColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 12.h),
                                        Text(
                                          'roomInfo.subtitle7-1'.tr(),
                                          style: TextStyle(
                                            color: accentColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          'roomInfo.subtitle7-2'.tr(),
                                          style: TextStyle(
                                            color: accentColor.withValues(
                                                alpha: 0.7),
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 32.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Bottom Book Button
                bottomNavigationBar: Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: appBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'viewRooms', arguments: {
                          'idAcomandation': data?.id ?? '',
                          'rooms': data?.room,
                          'serviceName': data?.serviceName ?? 'No details',
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.buttonColor,
                              AppColors.buttonColor.withValues(alpha: 0.8),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.buttonColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "book",
                              style: TextStyle(
                                color: white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: white,
                              size: 20.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: accentColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildPolicyItem(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: accentColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          subtitle,
          style: TextStyle(
            color: accentColor.withValues(alpha: 0.7),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildRoomDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.r, color: Colors.grey),
        SizedBox(width: 6.w),
        Text(
          text,
          style: TextStyle(
            color: accentColor.withValues(alpha: 0.7),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage(Data? data) {
    // Prepare images list - use backend images when available, otherwise use dummy
    final List<String> images = data?.serviceImageUrl ?? [];

    // Check if backend provides images array (future implementation)
    // For now, use single image or dummy images
    if (data?.coverPhotoUrl?.isNotEmpty == true) {
      images.add(data!.coverPhotoUrl!);
    }

    // Add dummy images to make it a carousel (3 images total)
    while (images.length < 3) {
      images.add(
          'https://zadnaeg.com/wp-content/uploads/2017/06/wood-blog-placeholder.jpg');
    }

    return CustomCarouselSlider(
      images: images,
      placeholderImage: 'assets/images/ard_logo.png',
    );
  }
}
