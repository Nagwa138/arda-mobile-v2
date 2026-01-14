// ========== 1. GetRoomsPartner Screen ==========
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/services/partner/servicesCubit/servicesCubit.dart';
import 'package:PassPort/services/partner/servicesCubit/servicesStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetRoomsPartner extends StatelessWidget {
  const GetRoomsPartner({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(
      create: (BuildContext context) =>
          ServicesCubit()..getRoomsAccomantion(id: arguments['id']),
      child: BlocConsumer<ServicesCubit, ServicesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Color.fromRGBO(19, 10, 3, 1)),
                onPressed: () => Navigator.pop(context)),
              centerTitle: true,
              title: Text(
                "Rooms",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(19, 10, 3, 1)))),
            body: state is getRoomPartnerLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: orange,
                      strokeWidth: 3))
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        // Add Room Button
                        if (context
                                .read<ServicesCubit>()
                                .getRoomsAccomandtionModel!
                                .data!
                                .length <
                            arguments['count'])
                          Padding(
                            padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
                            child: _buildAddRoomButton(context, arguments)),

                        // Rooms Count Badge
                        Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                                color: orange.withValues(alpha: 0.3))),
                          child: Row(
                            children: [
                              Icon(Icons.hotel, color: orange, size: 20.sp),
                              SizedBox(width: 8.w),
                              Text(
                                "Total Rooms: ",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: black)),
                              Text(
                                "${context.read<ServicesCubit>().getRoomsAccomandtionModel!.data!.length} / ${arguments['count']}",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: orange)),
                            ])),

                        // Rooms List
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(bottom: 16.h),
                            itemBuilder: (context, index) =>
                                _buildRoomCard(context, index),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 12.h),
                            itemCount: context
                                .read<ServicesCubit>()
                                .getRoomsAccomandtionModel!
                                .data!
                                .length)),
                      ])));
        }));
  }

  Widget _buildAddRoomButton(BuildContext context, Map arguments) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "addRoomDetails",
            arguments: {'name': arguments['roomType'], 'id': arguments['id']});
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            colors: [orange, orange.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
          boxShadow: [
            BoxShadow(
              color: orange.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: Offset(0, 4)),
          ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: white.withValues(alpha: 0.2),
                shape: BoxShape.circle),
              child: Icon(Icons.add, color: white, size: 20.sp)),
            SizedBox(width: 12.w),
            Text(
              "Add New Room",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: white)),
          ])));
  }

  Widget _buildRoomCard(BuildContext context, int index) {
    final room =
        context.read<ServicesCubit>().getRoomsAccomandtionModel!.data![index];

    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: Offset(0, 4)),
        ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Images Carousel
          Container(
            height: 180.h,
            child: Stack(
              children: [
                ListView.separated(
                  padding: EdgeInsets.all(12.w),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, indexImage) => ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CustomImage(
                      room.roomImage![indexImage],
                      width: 220.w,
                      fit: BoxFit.cover)),
                  separatorBuilder: (context, index) => SizedBox(width: 8.w),
                  itemCount: room.roomImage!.length),
                // Image Counter Badge
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20.r)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.photo_library, color: white, size: 14.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "${room.roomImage!.length}",
                          style: TextStyle(
                            color: white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600)),
                      ]))),
              ])),

          // Room Details
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Room Type & Number
                _buildInfoRow(
                  icon: Icons.meeting_room,
                  label: room.roomType.toString(),
                  value: "Room ${room.roomNo}"),
                SizedBox(height: 12.h),

                // Guests Number
                _buildInfoRow(
                  icon: Icons.people_outline,
                  label: "Guests Capacity",
                  value: "${room.guestsNo} Guests"),
                SizedBox(height: 12.h),

                // Price
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: orange.withValues(alpha: 0.3))),
                  child: Row(
                    children: [
                      Icon(Icons.attach_money, color: orange, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        "${room.price} ",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: orange)),
                      Text(
                        'currency'.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700])),
                      Text(
                        " / ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600])),
                      Text(
                        'addService.3.night'.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: black)),
                    ])),
              ])),
        ]));
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        children: [
          Icon(icon, color: orange, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: black))),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700])),
        ]));
  }
}
