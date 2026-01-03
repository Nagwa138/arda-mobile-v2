import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';

class GuestProfile extends StatelessWidget {
  const GuestProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit(),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "guestProfile.title".tr(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
              ),
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "guestProfile.title".tr(),
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    "guestProfile.subtitle".tr(),
                    style: TextStyle(
                      color: Color(0xFF8C8C8C),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                textFormFildBuilder(
                  context,
                  title: "Phone Number",
                  hint: "Enter phone number",
                  controller: BookingTravellerCubit.get(context).phoneRoom,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Special Requests",
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                              text: ' (Optional)',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        controller:
                            BookingTravellerCubit.get(context).specialRequests,
                        onChanged: (value) {},
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        minLines: 1,
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 20.h),
                          hintText: "Any special requests or requirements...",
                          hintStyle: TextStyle(
                            color: Color(0xFFCECFD1),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CheckboxListTile(
                  activeColor: accentColor,
                  title: Text(
                    'ProfileGuest.t1'.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: accentColor,
                    ),
                  ),
                  value: BookingTravellerCubit.get(context).agreeCheck,
                  onChanged: (newValue) {
                    BookingTravellerCubit.get(context).agree(newValue);
                  },
                ),
                BookingTravellerCubit.get(context).agreeCheck == true
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: accentColor),
                            borderRadius: BorderRadius.circular(20.r)),
                        child: DropdownButton<String>(
                            hint: Text('Select an item'),
                            isExpanded: true,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            borderRadius: BorderRadius.circular(20.r),
                            style: TextStyle(color: accentColor),
                            value: BookingTravellerCubit.get(context).item,
                            onChanged: (String? newValue) {
                              BookingTravellerCubit.get(context)
                                  .selectItem(newValue);
                              print(BookingTravellerCubit.get(context).item);
                              if (BookingTravellerCubit.get(context).item ==
                                  "Egyption") {
                                BookingTravellerCubit.get(context).items = "0";
                              } else if (BookingTravellerCubit.get(context)
                                      .item ==
                                  "Arabic") {
                                BookingTravellerCubit.get(context).items = "1";
                              } else {
                                BookingTravellerCubit.get(context).items = "2";
                              }
                              print(BookingTravellerCubit.get(context).items);
                            },
                            items: BookingTravellerCubit.get(context)
                                .lang
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Nationality Type",
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        value: 0,
                        activeColor: accentColor,
                        groupValue:
                            BookingTravellerCubit.get(context).nationalityType,
                        title: Text(
                          'Egyptian',
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onChanged: (value) {
                          BookingTravellerCubit.get(context)
                              .changeNationalityType(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        value: 1,
                        activeColor: accentColor,
                        groupValue:
                            BookingTravellerCubit.get(context).nationalityType,
                        title: Text(
                          'Foreign',
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onChanged: (value) {
                          BookingTravellerCubit.get(context)
                              .changeNationalityType(value);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Container(
                height: 50.h,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(accentColor),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // print("name ${BookingTravellerCubit.get(context).nameRoom.text.trim()}");
                    // print("email ${BookingTravellerCubit.get(context).emailRoom.text.trim()}");
                    // print("date ${BookingTravellerCubit.get(context).birthDayRoom.text.trim()}");
                    // print("date ${arguments['date']}");
                    // print("Guset ${arguments['Guest']}");
                    // print("Adult ${arguments['Adult']}");
                    // print("child ${arguments['child']}");
                    // print("roomId ${arguments['roomId']}");
                    // print("val ${BookingTravellerCubit.get(context).val}");

                    Navigator.pushNamed(context, 'confirmation', arguments: {
                      'phone': BookingTravellerCubit.get(context)
                          .phoneRoom
                          .text
                          .trim(),
                      'specialRequests': BookingTravellerCubit.get(context)
                          .specialRequests
                          .text
                          .trim(),
                      'date': arguments['date'],
                      'endDate': arguments['endDate'],
                      'Adult': arguments['Adult'],
                      'child': arguments['child'],
                      'roomId': arguments['roomId'],
                      'nationalityType':
                          BookingTravellerCubit.get(context).nationalityType,
                      'night': arguments['night']
                    });
                  },
                  child: Text(
                    "booking.Continue".tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget textFormFildBuilder(
  BuildContext context, {
  required String title,
  required String hint,
  bool isRequired = true,
  VoidCallback? validator,
  required TextEditingController controller,
  bool obstructText = false,
  TextInputType inputType = TextInputType.text,
  Widget? suffixIcon,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title.tr(),
            style: TextStyle(
              color: accentColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: isRequired ? ' *' : '',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          controller: controller,
          validator: (value) =>
              value!.isEmpty ? 'Please enter a valid value' : null,
          onChanged: (value) {},
          obscureText: obstructText,
          keyboardType: inputType,
          style: TextStyle(
            color: accentColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),

            hintText: hint.tr(),
            hintStyle: TextStyle(
              color: accentColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: accentColor,
              ),
            ),
            suffixIcon: suffixIcon,
            // filled: true,
            // fillColor: Color(0xFFF5F7FA),
          ),
        ),
      ],
    ),
  );
}
