import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/partner/rooms/addRoom.dart';
import 'package:PassPort/services/partner/servicesCubit/servicesCubit.dart';
import 'package:PassPort/services/partner/servicesCubit/servicesStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<List<DateTime>> selectedRanges = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(date);
  }

  void _onDaySelected(DateTime start, DateTime end) {
    setState(() {
      _rangeStart = start;
      _rangeEnd = end;
      if (start.isBefore(end) || start.isAtSameMomentAs(end)) {
        selectedRanges.add([start, end]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(
      create: (BuildContext context) => ServicesCubit(),
      child: BlocConsumer<ServicesCubit, ServicesStates>(
        listener: (context, state) {
          if (state is RegisterRoomLoaded) {
            Fluttertoast.showToast(
              msg: "Room Added Successfully!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Navigator.pop(context);
          } else if (state is RegisterRoomError) {
            Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Color.fromRGBO(19, 10, 3, 1)),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              title: Text(
                'Select Busy Days',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(19, 10, 3, 1),
                ),
              ),
            ),
            body: Column(
              children: [
                // Calendar Card
                Container(
                  margin: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.06),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2030, 12, 31),
                    calendarFormat: _calendarFormat,
                    onRangeSelected: (start, end, focusedDay) {
                      if (start != null && end != null) {
                        _onDaySelected(start, end);
                      }
                    },
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    rangeSelectionMode: RangeSelectionMode.toggledOn,
                    calendarStyle: CalendarStyle(
                      rangeHighlightColor: orange.withValues(alpha:0.2),
                      rangeStartDecoration: BoxDecoration(
                        color: orange,
                        shape: BoxShape.circle,
                      ),
                      rangeEndDecoration: BoxDecoration(
                        color: orange,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: orange.withValues(alpha:0.3),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(19, 10, 3, 1),
                      ),
                      leftChevronIcon: Icon(Icons.chevron_left, color: orange),
                      rightChevronIcon:
                          Icon(Icons.chevron_right, color: orange),
                    ),
                  ),
                ),

                // Selected Ranges Header
                if (selectedRanges.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Icon(Icons.event_note, color: orange, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          "Selected Date Ranges (${selectedRanges.length})",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: black,
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 12.h),

                // Selected Ranges List
                Expanded(
                  child: selectedRanges.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today_outlined,
                                  size: 64.sp, color: Colors.grey[300]),
                              SizedBox(height: 16.h),
                              Text(
                                "No dates selected yet",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Select date ranges on the calendar",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: selectedRanges.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8.h),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(12.r),
                                border:
                                    Border.all(color: orange.withValues(alpha:0.3)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha:0.04),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: orange.withValues(alpha:0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Icon(Icons.date_range,
                                        color: orange, size: 20.sp),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Range ${index + 1}",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          '${formatDate(selectedRanges[index][0])} - ${formatDate(selectedRanges[index][1])}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedRanges.removeAt(index);
                                      });
                                    },
                                    icon: Icon(Icons.delete_outline,
                                        color: Colors.red, size: 22.sp),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),

                // Bottom Action Buttons
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.08),
                        blurRadius: 12,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Reset Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: selectedRanges.isEmpty
                              ? null
                              : () {
                                  setState(() {
                                    _rangeStart = null;
                                    _rangeEnd = null;
                                    selectedRanges.clear();
                                  });
                                },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            side: BorderSide(
                              color: selectedRanges.isEmpty
                                  ? Colors.grey[300]!
                                  : orange,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.refresh,
                                color: selectedRanges.isEmpty
                                    ? Colors.grey[400]
                                    : orange,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Reset',
                                style: TextStyle(
                                  color: selectedRanges.isEmpty
                                      ? Colors.grey[400]
                                      : orange,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 12.w),

                      // Add Room Button
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: selectedRanges.isEmpty
                              ? null
                              : () {
                                  // Validate inputs
                                  final roomNumber = arguments['roomNumber']
                                          ?.toString()
                                          .trim() ??
                                      '';
                                  final price =
                                      arguments['price']?.toString().trim() ??
                                          '0';

                                  if (roomNumber.isEmpty) {
                                    Fluttertoast.showToast(
                                      msg: "Please enter a room number",
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                    );
                                    return;
                                  }

                                  // Check if room number is valid
                                  final roomNo = int.tryParse(roomNumber);
                                  if (roomNo == null) {
                                    Fluttertoast.showToast(
                                      msg: "Invalid room number",
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                    );
                                    return;
                                  }

                                  // Check price for King rooms
                                  double roomPrice = 0.0;
                                  if (arguments['roomType'] == "King") {
                                    final parsedPrice = double.tryParse(price);
                                    if (parsedPrice == null ||
                                        parsedPrice <= 0) {
                                      Fluttertoast.showToast(
                                        msg:
                                            "Please enter a valid price for King room",
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                      );
                                      return;
                                    }
                                    roomPrice = parsedPrice;
                                  }

                                  List<OccupiedTime> occupiedTimes =
                                      selectedRanges.map((range) {
                                    return OccupiedTime(
                                      start: range[0].toIso8601String(),
                                      end: range[1].toIso8601String(),
                                    );
                                  }).toList();

                                  RoomPartner room = RoomPartner(
                                    roomNo: roomNo,
                                    price: roomPrice,
                                    occupiedTimes: occupiedTimes,
                                  );

                                  context.read<ServicesCubit>().registerRoom(
                                      room: room, id: arguments['id']);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedRanges.isEmpty
                                ? Colors.grey[300]
                                : orange,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: selectedRanges.isEmpty ? 0 : 4,
                            shadowColor: orange.withValues(alpha:0.4),
                          ),
                          child: state is RegisterRoomLoading
                              ? SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: CircularProgressIndicator(
                                    color: white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle_outline,
                                        color: white, size: 20.sp),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Add Room',
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
