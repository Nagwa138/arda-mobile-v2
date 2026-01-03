import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/trips_model/trips_model.dart'
    as trips_model;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip, this.onTap});
  final trips_model.Data trip;
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
            TripImageSection(trip: trip),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TripName(trip: trip),
                  SizedBox(height: 8.h),
                  TripRouteInfo(trip: trip),
                  SizedBox(height: 10.h),
                  TripPriceAndTimeRow(trip: trip),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TripImageSection extends StatelessWidget {
  const TripImageSection({super.key, required this.trip});
  final trips_model.Data trip;

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
            decoration: BoxDecoration(
              color: const Color(0xFFD4C4B0),
            ),
            child: trip.image != null && trip.image!.isNotEmpty
                ? Image.network(
                    trip.image!,
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
              if (trip.date != null) DateBadge(date: trip.date!),
              if (trip.availableSeats != null && trip.availableSeats! > 0)
                AvailableSeatsBadge(seats: trip.availableSeats!),
            ],
          ),
        ),
      ],
    );
  }
}

class DateBadge extends StatelessWidget {
  const DateBadge({super.key, required this.date});
  final String date;

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
            Icons.calendar_today_rounded,
            size: 13.sp,
            color: const Color(0xFF8B5E3C),
          ),
          SizedBox(width: 5.w),
          Text(
            formatDate(date),
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

  String formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${date.day} ${months[date.month - 1]}';
    } catch (e) {
      return dateString.split(' ').first;
    }
  }
}

class AvailableSeatsBadge extends StatelessWidget {
  const AvailableSeatsBadge({super.key, required this.seats});
  final int seats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: const Color(0xFF9B6B4A),
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
            Icons.people_rounded,
            size: 13.sp,
            color: const Color(0xFFFAF5F0),
          ),
          SizedBox(width: 5.w),
          Text(
            '$seats left',
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

class TripName extends StatelessWidget {
  const TripName({super.key, required this.trip});
  final trips_model.Data trip;

  @override
  Widget build(BuildContext context) {
    return Text(
      trip.name ?? 'Journey Planner',
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

class TripRouteInfo extends StatelessWidget {
  const TripRouteInfo({super.key, required this.trip});
  final trips_model.Data trip;

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
              '${trip.from ?? 'From'} → ${trip.to ?? 'To'}',
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

class TripPriceAndTimeRow extends StatelessWidget {
  const TripPriceAndTimeRow({super.key, required this.trip});
  final trips_model.Data trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TripPrice(price: trip.pricePerPerson ?? 0),
        if (trip.time != null) TripTimeBadge(time: trip.time!),
      ],
    );
  }
}

class TripPrice extends StatelessWidget {
  const TripPrice({super.key, required this.price});
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

class TripTimeBadge extends StatelessWidget {
  const TripTimeBadge({super.key, required this.time});
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
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
            Icons.access_time_rounded,
            size: 15.sp,
            color: const Color(0xFF8B5E3C),
          ),
          SizedBox(width: 5.w),
          Text(
            time,
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF5A3D2B),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
