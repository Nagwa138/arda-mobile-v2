import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../../../consts/api/api.dart';
import '../../../../../../../models/traveller/accomandating/accomandtionByIdone.dart';
import '../../../../../../../services/traveller/bookingTravellerCubit/BookingCart/bookingCardCubit.dart';
import 'package:PassPort/models/traveller/rooms/roomlist.dart';

class ViewRooms extends StatelessWidget {
  const ViewRooms({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookingTravellerCubit()),
        BlocProvider(create: (context) => AddServiceCubit()),
        BlocProvider(create: (context) => CardCubitRoom()..clearState()),
      ],
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<AddServiceCubit, AddServiceState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                backgroundColor: appBackgroundColor,
                appBar: AppBar(
                  backgroundColor: appBackgroundColor,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    "viewRooms.title".tr(),
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                  leading: Container(
                    margin: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios_new, size: 18.sp),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),

                        // Guest Information Card
                        _buildSectionCard(
                          context,
                          icon: Icons.people_outline_rounded,
                          title: "viewRooms.title3".tr(),
                          child: Column(
                            children: [
                              _modernRoomNumBuilder(
                                context,
                                function: context
                                    .read<AddServiceCubit>()
                                    .changeSingleRoomNumUpdateAdult,
                                number: context
                                    .read<AddServiceCubit>()
                                    .singleRoomNumAdult,
                                title: 'addTripe.numberAdult'.tr(),
                                icon: Icons.person_rounded,
                              ),
                              Divider(height: 1, color: Colors.grey.shade200),
                              _modernRoomNumBuilder(
                                context,
                                function: context
                                    .read<AddServiceCubit>()
                                    .changeSingleRoomNumUpdateChild,
                                number: context.read<AddServiceCubit>().child,
                                title: 'addTripe.chieldern'.tr(),
                                icon: Icons.child_care_rounded,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Available Rooms Section
                        _buildSectionCard(
                          context,
                          icon: Icons.hotel_rounded,
                          title: "Available Rooms",
                          child: BlocBuilder<CardCubitRoom, List<RoomList>>(
                            builder: (context, state) {
                              return Column(
                                children: List.generate(
                                  arguments['rooms']?.length ?? 0,
                                  (index) {
                                    final Room room = arguments['rooms'][index];
                                    final cartItem = state.firstWhere(
                                      (item) => item.id == room.id,
                                      orElse: () => RoomList(
                                          id: room.id ?? "", numberOfPerson: 0),
                                    );
                                    final quantity =
                                        cartItem.numberOfPerson ?? 0;

                                    return Column(
                                      children: [
                                        if (index > 0)
                                          Divider(
                                              height: 24.h,
                                              color: Colors.grey.shade200),
                                        _buildRoomCard(
                                          context,
                                          room: room,
                                          initialQuantity: quantity,
                                          onQuantityChanged: (newQuantity) {
                                            context
                                                .read<CardCubitRoom>()
                                                .addOrUpdateRoom(
                                                  room.id ?? "",
                                                  newQuantity,
                                                );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Dates Card
                        _buildSectionCard(
                          context,
                          icon: Icons.calendar_month_rounded,
                          title: "Booking Dates",
                          child: Column(
                            children: [
                              _modernDateField(
                                context,
                                label: "Check-in Date",
                                hint: "Select check-in date",
                                controller: BookingTravellerCubit.get(context)
                                    .startDate,
                                onTap: () {
                                  final cubit =
                                      BookingTravellerCubit.get(context);
                                  DateTime? endDate =
                                      DateTime.tryParse(cubit.endDate.text);
                                  DateTime firstDate = DateTime.now();
                                  DateTime lastDate =
                                      endDate ?? DateTime(2050, 1, 1);

                                  if (lastDate.isBefore(firstDate)) {
                                    lastDate = DateTime(2050, 1, 1);
                                  }

                                  cubit.PickDate(
                                    context: context,
                                    controller: cubit.startDate,
                                    firstDate: firstDate,
                                    lastDate: lastDate,
                                  );
                                },
                              ),
                              SizedBox(height: 16.h),
                              _modernDateField(
                                context,
                                label: "Check-out Date",
                                hint: "Select check-out date",
                                controller:
                                    BookingTravellerCubit.get(context).endDate,
                                onTap: () {
                                  final cubit =
                                      BookingTravellerCubit.get(context);
                                  DateTime? startDate =
                                      DateTime.tryParse(cubit.startDate.text);
                                  DateTime firstDate =
                                      startDate ?? DateTime.now();

                                  if (firstDate.isBefore(DateTime.now())) {
                                    firstDate = DateTime.now();
                                  }

                                  cubit.PickDate(
                                    context: context,
                                    controller: cubit.endDate,
                                    firstDate: firstDate,
                                    lastDate: DateTime(2050, 1, 1),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Contact Information Card
                        _buildSectionCard(
                          context,
                          icon: Icons.phone_rounded,
                          title: "Contact Information",
                          child: Column(
                            children: [
                              _modernTextField(
                                context,
                                label: "Phone Number",
                                hint: "Enter your phone number",
                                controller: BookingTravellerCubit.get(context)
                                    .phoneRoom,
                                icon: Icons.phone_outlined,
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(height: 16.h),
                              _modernTextField(
                                context,
                                label: "Special Requests",
                                hint: "Any special requests or requirements...",
                                controller: BookingTravellerCubit.get(context)
                                    .specialRequests,
                                icon: Icons.note_outlined,
                                maxLines: 3,
                                isRequired: false,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Nationality Card
                        _buildSectionCard(
                          context,
                          icon: Icons.flag_rounded,
                          title: "Nationality Type",
                          child: Row(
                            children: [
                              Expanded(
                                child: _modernRadioTile(
                                  context,
                                  value: 0,
                                  groupValue: BookingTravellerCubit.get(context)
                                      .nationalityType,
                                  title: 'Egyptian',
                                  icon: '🇪🇬',
                                  onChanged: (value) {
                                    BookingTravellerCubit.get(context)
                                        .changeNationalityType(value);
                                  },
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _modernRadioTile(
                                  context,
                                  value: 1,
                                  groupValue: BookingTravellerCubit.get(context)
                                      .nationalityType,
                                  title: 'Foreign',
                                  icon: '🌍',
                                  onChanged: (value) {
                                    BookingTravellerCubit.get(context)
                                        .changeNationalityType(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: BlocBuilder<CardCubitRoom, List<RoomList>>(
                  builder: (context, roomsState) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Container(
                        height: 50.h,
                        child: BlocBuilder<BookingTravellerCubit,
                            BookingTravellerStates>(
                          builder: (context, bookingState) {
                            final isLoading =
                                bookingState is CreateBookingRoomLoading;
                            return ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    isLoading ? Colors.grey : accentColor),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      // Validation
                                      if (roomsState.isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "Please Select Rooms",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        return;
                                      }

                                      final bookingCubit =
                                          BookingTravellerCubit.get(context);
                                      final cubit =
                                          context.read<AddServiceCubit>();

                                      // Validate dates
                                      if (bookingCubit.startDate.text
                                          .trim()
                                          .isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "Please select check-in date",
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                        );
                                        return;
                                      }

                                      if (bookingCubit.endDate.text
                                          .trim()
                                          .isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "Please select check-out date",
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                        );
                                        return;
                                      }

                                      // Validate phone
                                      if (bookingCubit.phoneRoom.text
                                          .trim()
                                          .isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "Please enter phone number",
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                        );
                                        return;
                                      }

                                      // Validate guest numbers
                                      if (cubit.singleRoomNumAdult == 0 &&
                                          cubit.child == 0) {
                                        Fluttertoast.showToast(
                                          msg:
                                              "Please add at least one adult or child",
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                        );
                                        return;
                                      }

                                      // Call booking API
                                      await bookingCubit.bookRoom(
                                        room: roomsState,
                                        start:
                                            bookingCubit.startDate.text.trim(),
                                        end: bookingCubit.endDate.text.trim(),
                                        phone:
                                            bookingCubit.phoneRoom.text.trim(),
                                        specialRequests: bookingCubit
                                            .specialRequests.text
                                            .trim(),
                                        numberOfAdult: cubit.singleRoomNumAdult,
                                        numberOfChildern: cubit.child,
                                        nationalityType:
                                            bookingCubit.nationalityType,
                                      );
                                      await Future.delayed(
                                          Duration(milliseconds: 500));

                                      // Clear state and navigate
                                      if (bookingCubit.state
                                          is CreateBookingRoomSuccessful) {
                                        roomsState.clear();
                                        context
                                            .read<CardCubitRoom>()
                                            .clearState();
                                        Navigator.pushNamed(
                                            context, 'travellerNavBar');
                                      }
                                    },
                              child: isLoading
                                  ? SizedBox(
                                      height: 24.h,
                                      width: 24.h,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      "Confirm Booking",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRoomCard(
    BuildContext context, {
    required Room room,
    required Function(int) onQuantityChanged,
    int initialQuantity = 0,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Color(0xFFE8EAED), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: (room.roomImage != null && room.roomImage!.isNotEmpty)
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: EdgeInsets.zero,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              InteractiveViewer(
                                panEnabled: true,
                                boundaryMargin: EdgeInsets.all(20),
                                minScale: 0.5,
                                maxScale: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    "${Api.BASE_URL}/Images/AccomodationImages/${room.roomImage![0]}",
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.broken_image,
                                              color: Colors.white, size: 50),
                                          SizedBox(height: 8),
                                          Text(
                                            "Image not available",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: IconButton(
                                  icon: Icon(Icons.close,
                                      color: Colors.white, size: 30),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      "${Api.BASE_URL}/Images/AccomodationImages/${room.roomImage![0]}",
                      width: 90.w,
                      height: 90.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 90.w,
                          height: 90.h,
                          color: Colors.grey.shade300,
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 90.w,
                          height: 90.h,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  )
                : Container(
                    width: 90.w,
                    height: 90.h,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.hotel, color: Colors.grey),
                  ),
          ),

          SizedBox(width: 12.w),

          // Room Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Room Type
                Text(
                  room.roomType ?? 'Room',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                    letterSpacing: -0.3,
                  ),
                ),

                // SizedBox(height: 4.h),

                // // Available Rooms Count
                // Row(
                //   children: [
                //     Icon(Icons.door_front_door_rounded,
                //         size: 14.sp, color: Colors.grey),
                //     SizedBox(width: 4.w),
                //     Text(
                //       '${room.count ?? 0} rooms available',
                //       style: TextStyle(
                //         fontSize: 12.sp,
                //         color: Colors.grey,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),

                SizedBox(height: 8.h),

                // Price
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    '${room.price ?? 0} EGP / night',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                // Quantity Selector
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        color: accentColor.withOpacity(0.2), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (initialQuantity > 0) {
                            onQuantityChanged(initialQuantity - 1);
                          }
                        },
                        icon: Icon(Icons.remove_circle_outline_rounded),
                        color: initialQuantity > 0 ? accentColor : Colors.grey,
                        iconSize: 22.sp,
                        padding: EdgeInsets.all(4.w),
                        constraints: BoxConstraints(),
                      ),
                      Container(
                        width: 35.w,
                        alignment: Alignment.center,
                        child: Text(
                          initialQuantity.toString(),
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (initialQuantity < 20) {
                            onQuantityChanged(initialQuantity + 1);
                          }
                        },
                        icon: Icon(Icons.add_circle_outline_rounded),
                        color: initialQuantity < 20 ? accentColor : Colors.grey,
                        iconSize: 22.sp,
                        padding: EdgeInsets.all(4.w),
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: accentColor, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                  letterSpacing: -0.3,
                ),
              ),
              Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
            ],
          ),
          SizedBox(height: 20.h),
          child,
        ],
      ),
    );
  }

  Widget _modernRoomNumBuilder(
    BuildContext context, {
    required Function function,
    required String title,
    required int number,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Icon(icon, color: accentColor.withOpacity(0.7), size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: accentColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => function(isAdded: false),
                  icon: Icon(Icons.remove_circle_outline_rounded),
                  color: number > 0 ? accentColor : Colors.grey,
                  iconSize: 24.sp,
                  padding: EdgeInsets.all(8.w),
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
                  onPressed: () => function(isAdded: true),
                  icon: Icon(Icons.add_circle_outline_rounded),
                  color: accentColor,
                  iconSize: 24.sp,
                  padding: EdgeInsets.all(8.w),
                  constraints: BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _modernDateField(
    BuildContext context, {
    required String label,
    required String hint,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: accentColor,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Color(0xFFE8EAED), width: 1.5),
          ),
          child: TextFormField(
            controller: controller,
            readOnly: true,
            onTap: onTap,
            style: TextStyle(
              color: accentColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: accentColor.withOpacity(0.4),
                fontSize: 14.sp,
              ),
              prefixIcon: Icon(
                Icons.calendar_today_rounded,
                color: accentColor.withOpacity(0.5),
                size: 20.sp,
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _modernTextField(
    BuildContext context, {
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: accentColor,
                letterSpacing: 0.2,
              ),
            ),
            if (isRequired)
              Text(' *', style: TextStyle(color: Colors.red, fontSize: 14.sp)),
            if (!isRequired)
              Text(
                ' (Optional)',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Color(0xFFE8EAED), width: 1.5),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: TextStyle(
              color: accentColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: accentColor.withOpacity(0.4),
                fontSize: 14.sp,
              ),
              prefixIcon: Icon(
                icon,
                color: accentColor.withOpacity(0.5),
                size: 20.sp,
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _modernRadioTile(
    BuildContext context, {
    required int value,
    required int groupValue,
    required String title,
    required String icon,
    required Function(int?) onChanged,
  }) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? accentColor.withOpacity(0.08) : Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? accentColor : Color(0xFFE8EAED),
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: TextStyle(fontSize: 20.sp)),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                color: accentColor,
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
