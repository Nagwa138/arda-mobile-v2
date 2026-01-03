import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/activity/activity_random_model.dart'
    as activity_model;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key, required this.activity, this.onTap});
  final activity_model.Data activity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 290.w,
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          color: lightBeige,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.15 * 255).toInt()),
              spreadRadius: 0,
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActivityImageSection(activity: activity),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActivityName(activity: activity),
                  SizedBox(height: 8.h),
                  ActivityLocationInfo(activity: activity),
                  SizedBox(height: 10.h),
                  ActivityPriceAndDurationRow(activity: activity),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityImageSection extends StatelessWidget {
  const ActivityImageSection({super.key, required this.activity});
  final activity_model.Data activity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
          child: Container(
            height: 220.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFD4C4B0),
            ),
            child: activity.image != null && activity.image!.isNotEmpty
                ? Image.network(
                    activity.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/ard_logo.png',
                        fit: BoxFit.cover,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: const Color(0xFF9B6B4A),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/ard_logo.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          top: 16.h,
          left: 16.w,
          right: 16.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AdventureBadge(),
              if (activity.rate != null && activity.rate! > 0)
                RatingBadge(rating: activity.rate!),
            ],
          ),
        ),
        if (activity.duration != null)
          Positioned(
            bottom: 16.h,
            left: 16.w,
            child: DurationBadge(duration: activity.duration!),
          ),
      ],
    );
  }
}

class AdventureBadge extends StatelessWidget {
  const AdventureBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5E3C), Color(0xFF9B6B4A)],
        ),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5E3C).withAlpha((0.4 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.explore_outlined,
            size: 13.sp,
            color: const Color(0xFFFAF5F0),
          ),
          SizedBox(width: 5.w),
          Text(
            'Adventure',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFFAF5F0),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  const RatingBadge({super.key, required this.rating});
  final num rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5F0).withAlpha((0.95 * 255).toInt()),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5E3C).withAlpha((0.2 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            color: const Color(0xFFFFD700),
            size: 14.sp,
          ),
          SizedBox(width: 4.w),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF5A3D2B),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class DurationBadge extends StatelessWidget {
  const DurationBadge({super.key, required this.duration});
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5F0).withAlpha((0.95 * 255).toInt()),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5E3C).withAlpha((0.2 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule_outlined,
            size: 13.sp,
            color: const Color(0xFF8B5E3C),
          ),
          SizedBox(width: 5.w),
          Text(
            '$duration ${duration == 1 ? 'day' : 'days'}',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF5A3D2B),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityName extends StatelessWidget {
  const ActivityName({super.key, required this.activity});
  final activity_model.Data activity;

  @override
  Widget build(BuildContext context) {
    return Text(
      activity.activitieName ?? 'Local Adventure',
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF3D2817),
        height: 1.3,
        letterSpacing: -0.2,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class ActivityLocationInfo extends StatelessWidget {
  const ActivityLocationInfo({super.key, required this.activity});
  final activity_model.Data activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5F0).withAlpha((0.6 * 255).toInt()),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFD4C4B0).withAlpha((0.5 * 255).toInt()),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on_rounded,
            size: 16.sp,
            color: const Color(0xFF8B5E3C),
          ),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              activity.description ?? 'Egypt',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF5A3D2B),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityPriceAndDurationRow extends StatelessWidget {
  const ActivityPriceAndDurationRow({super.key, required this.activity});
  final activity_model.Data activity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActivityPrice(price: activity.pricePerPerson ?? 0),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: const Color(0xFF9B6B4A),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7D5737).withAlpha((0.4 * 255).toInt()),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.arrow_forward_rounded,
            size: 20.sp,
            color: const Color(0xFFFAF5F0),
          ),
        ),
      ],
    );
  }
}

class ActivityPrice extends StatelessWidget {
  const ActivityPrice({super.key, required this.price});
  final num price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: const Color(0xFF9B6B4A),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7D5737).withAlpha((0.4 * 255).toInt()),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$price',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFFAF5F0),
              height: 1,
            ),
          ),
          SizedBox(width: 4.w),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              'EGP',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFAF5F0).withAlpha((0.85 * 255).toInt()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
