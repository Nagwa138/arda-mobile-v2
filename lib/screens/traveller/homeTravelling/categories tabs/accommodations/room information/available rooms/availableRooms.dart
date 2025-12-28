import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/rooms/roomlist.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/BookingCart/bookingCardCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';

class AvailableRooms extends StatelessWidget {
  const AvailableRooms({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => BookingTravellerCubit()
              ..getAllRoomAvailable(
                  id: arguments['idAcomandation'],
                  roomType: "0",
                  startDate: arguments['date'],
                  endDate: arguments['endDate'])),
        BlocProvider(create: (BuildContext context) => CardCubitRoom()),
      ],
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {
          if (state is DeleteBookingSuccessful) {
            Fluttertoast.showToast(
                msg: "Done",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is AddBookingSuccessful) {
            Fluttertoast.showToast(
                msg: "Done",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is AddAnotherBookingSuccessful) {
            Fluttertoast.showToast(
                msg: "Done Again",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is CreateBookingRoomSuccessful) {
            Fluttertoast.showToast(
                msg: "Create Booking Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is CreateBookingRoomError) {
            Navigator.pop(context);
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is CreateBookingRoomLoading) {
            showDialog(
              context: context,
              barrierDismissible: false, // لا يمكن إغلاق الحوار بالضغط خارجًا
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 10),
                      Text("Loading..."),
                    ],
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<CardCubitRoom, List<RoomList>>(
            builder: (BuildContext context, List<RoomList> state) {
              final availableRooms =
                  BookingTravellerCubit.get(context).getAllAvailableRom;
              if (availableRooms == null || availableRooms.data == null) {
                return Scaffold(
                    body:
                        Center(child: CircularProgressIndicator(color: black)));
              }

              return WillPopScope(
                onWillPop: () async {
                  context.read<CardCubitRoom>().clearState();
                  Navigator.pop(context);

                  return true;
                },
                child: Scaffold(
                  backgroundColor: appBackgroundColor,
                  appBar: AppBar(
                    backgroundColor: appBackgroundColor,
                    elevation: 0.0,
                    centerTitle: true,
                    leading: IconButton(
                        onPressed: () {
                          context.read<CardCubitRoom>().clearState();
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    title: Text(
                      "availableRooms.title".tr(),
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  body: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                    children: [
                      Text(
                        "availableRooms.title2".tr(),
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                BookingTravellerCubit.get(context)
                                    .toggleRoomMethod(0);
                                BookingTravellerCubit.get(context)
                                    .getAllRoomAvailable(
                                        id: arguments['idAcomandation'],
                                        roomType: "0",
                                        startDate: arguments['date'],
                                        endDate: arguments['endDate']);
                              },
                              child: Container(
                                width: 140.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    border: Border.all(color: black),
                                    color: BookingTravellerCubit.get(context)
                                                .toggleRoom ==
                                            0
                                        ? accentColor
                                        : appBackgroundColor,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20.r)),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "single Room",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              BookingTravellerCubit.get(context)
                                                          .toggleRoom ==
                                                      0
                                                  ? appBackgroundColor
                                                  : accentColor),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                BookingTravellerCubit.get(context)
                                    .toggleRoomMethod(1);
                                BookingTravellerCubit.get(context)
                                    .getAllRoomAvailable(
                                        id: arguments['idAcomandation'],
                                        roomType: "1",
                                        startDate: arguments['date'],
                                        endDate: arguments['endDate']);
                              },
                              child: Container(
                                width: 140.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    border: Border.all(color: black),
                                    color: BookingTravellerCubit.get(context)
                                                .toggleRoom ==
                                            1
                                        ? accentColor
                                        : appBackgroundColor,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20.r)),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "double Room",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              BookingTravellerCubit.get(context)
                                                          .toggleRoom ==
                                                      1
                                                  ? appBackgroundColor
                                                  : accentColor),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                BookingTravellerCubit.get(context)
                                    .toggleRoomMethod(2);
                                BookingTravellerCubit.get(context)
                                    .getAllRoomAvailable(
                                        id: arguments['idAcomandation'],
                                        roomType: "2",
                                        startDate: arguments['date'],
                                        endDate: arguments['endDate']);
                              },
                              child: Container(
                                width: 140.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    border: Border.all(color: black),
                                    color: BookingTravellerCubit.get(context)
                                                .toggleRoom ==
                                            2
                                        ? accentColor
                                        : appBackgroundColor,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20.r)),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "triple Room",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              BookingTravellerCubit.get(context)
                                                          .toggleRoom ==
                                                      2
                                                  ? appBackgroundColor
                                                  : accentColor),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                BookingTravellerCubit.get(context)
                                    .toggleRoomMethod(3);
                                BookingTravellerCubit.get(context)
                                    .getAllRoomAvailable(
                                        id: arguments['idAcomandation'],
                                        roomType: "3",
                                        startDate: arguments['date'],
                                        endDate: arguments['endDate']);
                              },
                              child: Container(
                                width: 140.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    border: Border.all(color: accentColor),
                                    color: BookingTravellerCubit.get(context)
                                                .toggleRoom ==
                                            3
                                        ? accentColor
                                        : appBackgroundColor,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20.r)),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "king Room",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              BookingTravellerCubit.get(context)
                                                          .toggleRoom ==
                                                      3
                                                  ? appBackgroundColor
                                                  : accentColor),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: accentColor,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            arguments['date'],
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.person,
                            color: accentColor,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            arguments['Guest'] + "availableRooms.guest".tr(),
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      BookingTravellerCubit.get(context)
                              .getAllAvailableRom!
                              .data!
                              .isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 60.h,
                                ),
                                Image.asset("assets/images/oops.png"),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "No Rooms Available On The Selected Days",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            )
                          : ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: accentColor),
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20.r)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Room Number",
                                            //'addService.2.single'.tr(),
                                            style: TextStyle(
                                              color: accentColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            BookingTravellerCubit.get(context)
                                                .getAllAvailableRom!
                                                .data![index]
                                                .roomNo
                                                .toString(),

                                            //"availableRooms.for".tr(),
                                            style: TextStyle(
                                              color: accentColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      SizedBox(
                                        height: 200.h,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, indexImage) =>
                                              ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            child: Image.network(
                                              BookingTravellerCubit.get(context)
                                                  .getAllAvailableRom!
                                                  .data![index]
                                                  .roomImage![indexImage]
                                                  .toString(),
                                              width: 200.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            width: 10.w,
                                          ),
                                          itemCount:
                                              BookingTravellerCubit.get(context)
                                                      .getAllAvailableRom!
                                                      .data![index]
                                                      .roomImage
                                                      ?.length ??
                                                  0,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Text(
                                            BookingTravellerCubit.get(context)
                                                .getAllAvailableRom!
                                                .data![index]
                                                .roomType
                                                .toString(),
                                            //'addService.2.single'.tr(),
                                            style: TextStyle(
                                              color: accentColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "availableRooms.for".tr(),
                                            style: TextStyle(
                                              color: accentColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            BookingTravellerCubit.get(context)
                                                .getAllAvailableRom!
                                                .data![index]
                                                .capacity
                                                .toString(),

                                            //"availableRooms.for".tr(),
                                            style: TextStyle(
                                              color: accentColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Icon(Icons.person)
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            textAlign: TextAlign.start,
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${BookingTravellerCubit.get(context).getAllAvailableRom!.data![index].price.toString()} ${'currency'.tr()} /',
                                                  style: TextStyle(
                                                    color: accentColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      'addService.3.night'.tr(),
                                                  style: TextStyle(
                                                    color: accentColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Text(
                                            'availableRooms.total'.tr(),
                                            style: TextStyle(
                                              color: accentColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            BookingTravellerCubit.get(context)
                                                    .calculateTotalPrice(
                                                        BookingTravellerCubit
                                                                .get(context)
                                                            .getAllAvailableRom!
                                                            .data![index]
                                                            .price,
                                                        arguments['night']) +
                                                'currency'.tr(),
                                            style: TextStyle(
                                              color: accentColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            side: BorderSide(
                                              color: accentColor,
                                            ),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Icon(
                                                Icons.info,
                                                color: accentColor,
                                              ),
                                              title: Text(
                                                'roomInfo.title7'.tr(),
                                                style: TextStyle(
                                                  color: accentColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 10.h),
                                                  Text(
                                                    'roomInfo.subtitle7-1'.tr(),
                                                    style: TextStyle(
                                                      color: accentColor,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    'roomInfo.subtitle7-2'.tr(),
                                                    style: TextStyle(
                                                      color: accentColor,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: Row(
                                                children: [
                                                  // التحقق من حالة الغرفة
                                                  Builder(
                                                    builder: (context) {
                                                      String roomId =
                                                          BookingTravellerCubit
                                                                  .get(context)
                                                              .getAllAvailableRom!
                                                              .data![index]
                                                              .id!;
                                                      bool isBooked = context
                                                          .read<CardCubitRoom>()
                                                          .isRoomBooked(roomId);

                                                      if (isBooked) {
                                                        // إذا كانت الغرفة محجوزة، نعرض زر "Cancel Now"
                                                        return Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              int roomIndex = context
                                                                  .read<
                                                                      CardCubitRoom>()
                                                                  .state
                                                                  .indexWhere(
                                                                      (room) =>
                                                                          room.id ==
                                                                          roomId);
                                                              if (roomIndex !=
                                                                  -1) {
                                                                context
                                                                    .read<
                                                                        CardCubitRoom>()
                                                                    .removeCard(
                                                                        roomIndex);
                                                              }
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          16.w,
                                                                      vertical:
                                                                          12.h),
                                                              decoration:
                                                                  ShapeDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.r)),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  "Cancel Now",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        // إذا كانت الغرفة غير محجوزة، نعرض زر "Book Now"
                                                        return Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              var numberOfPerson;
                                                              if (BookingTravellerCubit
                                                                          .get(
                                                                              context)
                                                                      .getAllAvailableRom!
                                                                      .data![
                                                                          index]
                                                                      .roomType ==
                                                                  "Single") {
                                                                numberOfPerson =
                                                                    1;
                                                              } else if (BookingTravellerCubit
                                                                          .get(
                                                                              context)
                                                                      .getAllAvailableRom!
                                                                      .data![
                                                                          index]
                                                                      .roomType ==
                                                                  "Double") {
                                                                numberOfPerson =
                                                                    2;
                                                              } else if (BookingTravellerCubit
                                                                          .get(
                                                                              context)
                                                                      .getAllAvailableRom!
                                                                      .data![
                                                                          index]
                                                                      .roomType ==
                                                                  "Triple") {
                                                                numberOfPerson =
                                                                    3;
                                                              } else if (BookingTravellerCubit
                                                                          .get(
                                                                              context)
                                                                      .getAllAvailableRom!
                                                                      .data![
                                                                          index]
                                                                      .roomType ==
                                                                  "King") {
                                                                numberOfPerson =
                                                                    4;
                                                              }
                                                              final newCard =
                                                                  RoomList(
                                                                id: '${BookingTravellerCubit.get(context).getAllAvailableRom?.data![index].id}',
                                                                numberOfPerson:
                                                                    numberOfPerson,
                                                              );

                                                              context
                                                                  .read<
                                                                      CardCubitRoom>()
                                                                  .addCard(
                                                                      newCard);
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          16.w,
                                                                      vertical:
                                                                          12.h),
                                                              decoration:
                                                                  ShapeDecoration(
                                                                color:
                                                                    accentColor,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.r)),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  "Book Now",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 20.h,
                              ),
                              itemCount: BookingTravellerCubit.get(context)
                                  .getAllAvailableRom!
                                  .data!
                                  .length,
                            ),
                    ],
                  ),
                  bottomNavigationBar: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Container(
                      height: 50.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(accentColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (state.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please Select Rooms",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: backgroundColor,
                                fontSize: 16.0);
                          } else {
                            BookingTravellerCubit.get(context)
                                .bookRoom(
                                    room: state,
                                    start: arguments['date'],
                                    end: arguments['endDate'],
                                    phone: arguments['phone'],
                                    specialRequests:
                                        arguments['specialRequests'],
                                    numberOfAdult: arguments['Adult'],
                                    numberOfChildern: arguments['child'],
                                    nationalityType:
                                        arguments['nationalityType'])
                                .then((value) {
                              state.clear();
                              context.read<CardCubitRoom>().clearState();
                              Navigator.pushNamed(context, 'travellerNavBar');
                            });
                          }
                        },
                        child: Text(
                          "confirm Booking" + "    (${state.length})" + " Room",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
