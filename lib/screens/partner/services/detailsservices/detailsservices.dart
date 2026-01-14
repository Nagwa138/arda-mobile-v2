import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/models/partner/acommdation_model.dart';
import 'package:PassPort/version2_module/features/partener/presentation/cubit/service_submission_cubit.dart';
import 'package:PassPort/version2_module/features/partener/presentation/models/partner_service_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsServices extends StatefulWidget {
  const DetailsServices({super.key});

  @override
  State<DetailsServices> createState() => _DetailsServicesState();
}

class _DetailsServicesState extends State<DetailsServices> {
  static const String _placeholderImage = 'assets/images/ard_logo.png';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final item = ModalRoute.of(context)!.settings.arguments as String;
      context
          .read<ServiceSubmissionCubit>()
          .getAccommodationServiceDetails(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceSubmissionCubit, ServiceSubmissionState>(
        builder: (context, state) {
      if (state is GetServiceDetailsLoading) {
        return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(child: CircularProgressIndicator(color: orange)));
      }

      if (state is GetServiceDetailsError) {
        return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
                child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline,
                              color: Colors.red, size: 64.sp),
                          SizedBox(height: 16.h),
                          Text(state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16.sp)),
                          SizedBox(height: 24.h),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: orange,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32.w, vertical: 14.h),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.r))),
                              onPressed: () {
                                final item = ModalRoute.of(context)!
                                    .settings
                                    .arguments as PartnerServiceItem;
                                context
                                    .read<ServiceSubmissionCubit>()
                                    .getAccommodationServiceDetails(item.id);
                              },
                              child: Text('Retry',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w600))),
                        ]))));
      }

      if (state is GetServiceDetailsSuccess) {
        final item = state.serviceDetails as AccommodationModel;

        return Scaffold(
            backgroundColor: backgroundColor,
            body: CustomScrollView(slivers: [
              // Modern App Bar with Hero Image
              SliverAppBar(
                  expandedHeight: 320.h,
                  pinned: true,
                  backgroundColor: backgroundColor,
                  leading: Container(
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                          color: white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 2)),
                          ]),
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back_ios_new,
                              color: black, size: 20.r))),
                  flexibleSpace:
                      FlexibleSpaceBar(background: _buildHeroImage(item))),

              // Content
              SliverToBoxAdapter(
                  child: Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Service Name Section
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          item.serviceDetails?.serviceName ??
                                              "N/A",
                                          style: TextStyle(
                                              color: black,
                                              fontSize: 26.sp,
                                              fontWeight: FontWeight.bold,
                                              height: 1.3)),
                                      SizedBox(height: 8.h),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 6.h),
                                          decoration: BoxDecoration(
                                              color:
                                                  orange.withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.category,
                                                    size: 16.sp, color: orange),
                                                SizedBox(width: 6.w),
                                                Text(
                                                    item.serviceDetails
                                                            ?.accomodationType ??
                                                        "N/A",
                                                    style: TextStyle(
                                                        color: orange,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ])),
                                    ])),

                            SizedBox(height: 24.h),

                            // Address Details Card
                            _buildSectionCard(context,
                                title: "Services.addressDetails".tr(),
                                icon: Icons.location_on,
                                child: Column(children: [
                                  _buildInfoRow(
                                      icon: Icons.location_on_outlined,
                                      title: "Services.address".tr(),
                                      value: item.companyDetails?.address ??
                                          "N/A"),
                                  SizedBox(height: 12.h),
                                  _buildInfoRow(
                                      icon: Icons.location_city_outlined,
                                      title: "Services.town".tr(),
                                      value: item.companyDetails?.address ??
                                          "N/A"),
                                  SizedBox(height: 12.h),
                                  _buildLinkRow(
                                      icon: Icons.link,
                                      title: "Services.linkAddress".tr(),
                                      link: item.companyDetails?.addressLink ??
                                          "N/A"),
                                ])),

                            // Service Details Card
                            _buildSectionCard(context,
                                title: "Services.ServicesDetails".tr(),
                                icon: Icons.info_outline,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Services.ServicesDescribe".tr(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: black,
                                              fontSize: 15.sp)),
                                      SizedBox(height: 8.h),
                                      Text(item.serviceDetails?.about ?? "N/A",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[700],
                                              fontSize: 14.sp,
                                              height: 1.6)),
                                      SizedBox(height: 20.h),

                                      // Amenities
                                      Text("Services.meansConfirm".tr(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: black,
                                              fontSize: 15.sp)),
                                      SizedBox(height: 12.h),
                                      Wrap(
                                          spacing: 8.w,
                                          runSpacing: 8.h,
                                          children: (item.serviceDetails
                                                      ?.amenityName ??
                                                  [])
                                              .map((e) => _buildChip(e))
                                              .toList()),
                                      SizedBox(height: 20.h),

                                      // Room Types Summary
                                      Text("Services.classRoom".tr(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: black,
                                              fontSize: 15.sp)),
                                      SizedBox(height: 12.h),
                                      ...(item.serviceDetails?.roomsType ?? [])
                                          .map((e) => Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10.h),
                                              child: _buildRoomTypeRow(e))),
                                      Divider(height: 32.h, thickness: 1),
                                      _buildInfoRow(
                                          icon: Icons.hotel,
                                          title: "Services.roomTotal".tr(),
                                          value: (item.serviceDetails
                                                      ?.roomsType ??
                                                  [])
                                              .fold(
                                                  0,
                                                  (sum, room) =>
                                                      sum + (room.count ?? 0))
                                              .toString(),
                                          isBold: true),
                                    ])),

                            // Rules and Cancellation Policy Card
                            _buildSectionCard(context,
                                title: "Rules & Cancellation Policy",
                                icon: Icons.policy_outlined,
                                child: _buildPolicyItem(
                                    icon: Icons.rule,
                                    description: item.serviceDetails
                                            ?.rulesAndCancellationPolicy ??
                                        "No specific rules provided")),

                            // Important Information Card
                            _buildSectionCard(context,
                                title: "Important Information",
                                icon: Icons.info,
                                child: _buildImportantInfoItem(
                                    icon: Icons.list_alt_outlined,
                                    text: item.serviceDetails
                                            ?.importantInformation ??
                                        "No important information provided")),

                            // Room Details Grid
                            _buildSectionCard(context,
                                title: "Services.roomDetails".tr(),
                                icon: Icons.bed,
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: item.serviceDetails?.roomsType
                                            ?.length ??
                                        0,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.55,
                                            crossAxisSpacing: 12.w,
                                            mainAxisSpacing: 12.h),
                                    itemBuilder: (context, index) {
                                      final room = item
                                          .serviceDetails!.roomsType![index];
                                      return _buildRoomCard(
                                          context, room, item);
                                    })),

                            // Contact Details Card
                            _buildSectionCard(context,
                                title: "Services.connectDetails".tr(),
                                icon: Icons.contact_phone,
                                child: Column(children: [
                                  _buildLinkRow(
                                      icon: Icons.language,
                                      title: "Website",
                                      link: item.companyDetails?.website ??
                                          "N/A"),
                                  SizedBox(height: 12.h),
                                  _buildInfoRow(
                                      icon: Icons.phone_outlined,
                                      title: "Official phone",
                                      value:
                                          item.companyDetails?.phone ?? "N/A"),
                                  SizedBox(height: 12.h),
                                  _buildInfoRow(
                                      icon: Icons.language_outlined,
                                      title:
                                          "Language your employees will speak",
                                      value: item.serviceDetails?.language ??
                                          "N/A"),
                                ])),

                            SizedBox(height: 32.h),
                          ]))),
            ]));
      }

      return Scaffold(
          backgroundColor: backgroundColor,
          body: Center(child: Text('No data')));
    });
  }

  Widget _buildHeroImage(AccommodationModel item) {
    final imageUrl = item.serviceDetails?.images?.first;

    return Stack(fit: StackFit.expand, children: [
      imageUrl != null && imageUrl.isNotEmpty
          ? CustomImage(imageUrl, fit: BoxFit.cover)
          : Container(
              color: Colors.grey[100],
              child: Center(
                  child: Image.asset(_placeholderImage,
                      fit: BoxFit.contain, width: 150.w))),
      // Gradient overlay
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.3),
          ]))),
    ]);
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2)),
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                    color: orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r)),
                child: Icon(icon, color: orange, size: 20.sp)),
            SizedBox(width: 12.w),
            Expanded(
                child: Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: black,
                        fontSize: 18.sp))),
          ]),
          SizedBox(height: 16.h),
          child,
        ]));
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    bool isBold = false,
  }) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, size: 20.sp, color: orange),
      SizedBox(width: 12.w),
      Expanded(
          child: RichText(
              text: TextSpan(children: [
        TextSpan(
            text: "$title: ",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: black, fontSize: 14.sp)),
        TextSpan(
            text: value,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
                color: isBold ? black : Colors.grey[700],
                fontSize: 14.sp)),
      ]))),
    ]);
  }

  Widget _buildLinkRow({
    required IconData icon,
    required String title,
    required String link,
  }) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, size: 20.sp, color: orange),
      SizedBox(width: 12.w),
      Expanded(
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("$title: ",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: black, fontSize: 14.sp)),
        SizedBox(height: 4.h),
        GestureDetector(
            onTap: () async {
              if (link != "N/A" && link.isNotEmpty) {
                await launch(link);
              }
            },
            child: Text(link,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: link != "N/A" ? Colors.blue : Colors.grey[700],
                    fontSize: 14.sp,
                    decoration: link != "N/A"
                        ? TextDecoration.underline
                        : TextDecoration.none))),
      ])),
    ]);
  }

  Widget _buildChip(String label) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: orange.withValues(alpha: 0.3))),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.check_circle, color: orange, size: 14.sp),
          SizedBox(width: 6.w),
          Text(label,
              style: TextStyle(
                  color: orange, fontSize: 13.sp, fontWeight: FontWeight.w500)),
        ]));
  }

  Widget _buildRoomTypeRow(RoomType room) {
    return Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[200]!)),
        child: Row(children: [
          Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  color: orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r)),
              child: Icon(Icons.bed, color: orange, size: 22.sp)),
          SizedBox(width: 14.w),
          Expanded(
              child: Text(_getRoomTypeLabel(room.roomType ?? ""),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: black,
                      fontSize: 15.sp))),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                  color: orange, borderRadius: BorderRadius.circular(20.r)),
              child: Text("${room.count}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: white,
                      fontSize: 15.sp))),
        ]));
  }

  Widget _buildPolicyItem({
    required IconData icon,
    required String description,
  }) {
    return Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[200]!)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: orange, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
              child: Text(description,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      fontSize: 13.sp,
                      height: 1.5))),
        ]));
  }

  Widget _buildImportantInfoItem({
    required IconData icon,
    required String text,
  }) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
              color: orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r)),
          child: Icon(icon, color: orange, size: 18.sp)),
      SizedBox(width: 12.w),
      Expanded(
          child: Text(text,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                  fontSize: 14.sp,
                  height: 1.5))),
    ]);
  }

  Widget _buildRoomCard(
      BuildContext context, RoomType room, AccommodationModel item) {
    final roomImage = room.roomImage;

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "getRoomPartner", arguments: {
            'id': room.id.toString(),
            'count': room.count,
            'roomType': room.roomType,
          });
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2)),
                ]),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Room Image
              ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: roomImage != null && roomImage.isNotEmpty
                      ? CustomImage(roomImage,
                          height: 120.h,
                          width: double.infinity,
                          fit: BoxFit.cover)
                      : Container(
                          height: 120.h,
                          color: Colors.grey[100],
                          child: Center(
                              child: Image.asset(_placeholderImage,
                                  fit: BoxFit.contain, width: 60.w)))),

              // Room Details
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${room.count} ${_getRoomTypeLabel(room.roomType ?? "")}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: black,
                                    fontSize: 14.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(height: 8.h),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("${room.price ?? 0}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: orange,
                                          fontSize: 18.sp)),
                                  SizedBox(width: 4.w),
                                  Text("currency".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600],
                                          fontSize: 11.sp)),
                                ]),
                            Text("/" + "Services.nigth".tr(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600],
                                    fontSize: 11.sp)),
                            if (room.includeBreakFast == true) ...[
                              SizedBox(height: 6.h),
                              Row(children: [
                                Icon(Icons.check_circle,
                                    color: Colors.green, size: 14.sp),
                                SizedBox(width: 4.w),
                                Expanded(
                                    child: Text("Services.contentPrice".tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[600],
                                            fontSize: 11.sp),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)),
                              ]),
                            ],
                            const Spacer(),
                            SizedBox(
                                width: double.infinity,
                                height: 34.h,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: orange,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        elevation: 0),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "getRoomPartner",
                                          arguments: {
                                            'id': room.id.toString(),
                                            'count': room.count,
                                            'roomType': room.roomType,
                                          });
                                    },
                                    child: Text("View Details",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: white)))),
                          ]))),
            ])));
  }

  String _getRoomTypeLabel(String roomType) {
    switch (roomType) {
      case "Single":
        return "Services.oneRoom".tr();
      case "Double":
        return "Services.doubleRoom".tr();
      case "Triple":
        return "Services.threeRoom".tr();
      case "King":
        return "Services.kingRoom".tr();
      default:
        return roomType;
    }
  }
}
