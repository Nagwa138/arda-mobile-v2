import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:PassPort/version2_module/core/widgets/custom_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ActivityBooking extends StatelessWidget {
  const ActivityBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => BookingTravellerCubit()),
        BlocProvider(create: (context) => AddServiceCubit())
      ],
      child: BlocConsumer<AddServiceCubit, AddServiceState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
            listener: (context, state) {
              if (state is CreateBookingActivityLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
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
              } else if (state is CreateBookingActivitySuccessful) {
                Navigator.pop(context);
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "Successful",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (state is CreateBookingActivityError) {
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: state.error,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: appBackgroundColor,
                appBar: AppBar(
                  elevation: 0.0,
                  backgroundColor: appBackgroundColor,
                  title: Text(
                    "Booking Activities",
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
                body: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  children: <Widget>[
                    Text(
                      "bookingActivities.t1".tr(),
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "bookingActivities.sub1".tr(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Phone Number Field
                    textFormFildBuilder(
                      context,
                      title: "Phone Number",
                      hint: "Enter phone number",
                      inputType: TextInputType.phone,
                      controller:
                          BookingTravellerCubit.get(context).phoneActivity,
                    ),

                    // Activity Date Field
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Activity Date",
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              children: [
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          TextFormField(
                            controller:
                                BookingTravellerCubit.get(context).activityDate,
                            readOnly: true,
                            onTap: () {
                              BookingTravellerCubit.get(context).PickDate(
                                context: context,
                                controller: BookingTravellerCubit.get(context)
                                    .activityDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050, 1, 1),
                              );
                            },
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 20.h),
                              hintText: "Select activity date",
                              hintStyle: TextStyle(
                                color: accentColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(color: accentColor),
                              ),
                              suffixIcon: Icon(Icons.calendar_month),
                            ),
                          ),
                        ],
                      ),
                    ),

                    textFormFildBuilder(
                      context,
                      title: "Health Limitations",
                      hint: "Any health limitations or medical conditions",
                      isRequired: false,
                      controller:
                          BookingTravellerCubit.get(context).healthLimitations,
                    ),
                    textFormFildBuilder(
                      context,
                      title: "What is your current level in this activity?",
                      hint: "Describe your experience level",
                      isRequired: false,
                      controller: BookingTravellerCubit.get(context)
                          .experienceInActivity,
                    ),
                    textFormFildBuilder(
                      context,
                      title: "Special Requests",
                      hint: "Any special requests or requirements",
                      isRequired: false,
                      controller: BookingTravellerCubit.get(context)
                          .specialRequestsActivity,
                    ),
                    textFormFildBuilder(
                      context,
                      title: "Languages",
                      hint: "Preferred languages for communication",
                      isRequired: false,
                      controller:
                          BookingTravellerCubit.get(context).languagesActivity,
                    ),

                    roomNumBuilder(
                        function: context
                            .read<AddServiceCubit>()
                            .changeSingleRoomNumActvity,
                        number: context
                            .read<AddServiceCubit>()
                            .singleRoomNumActvity,
                        title: 'addTripe.number'.tr()),
                    SizedBox(height: 30.h),
                  ],
                ),
                bottomNavigationBar: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: CustomButton(
                    text: 'Continue',
                    onPressed: () {
                      // Validation
                      if (BookingTravellerCubit.get(context)
                          .phoneActivity
                          .text
                          .isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Please enter phone number",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        return;
                      }
                      if (BookingTravellerCubit.get(context)
                          .activityDate
                          .text
                          .isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Please select activity date",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        return;
                      }

                      BookingTravellerCubit.get(context).createBookingActivity(
                        activityId: arguments['id'],
                        numberOfGuest: context
                            .read<AddServiceCubit>()
                            .singleRoomNumActvity,
                        activityDate: BookingTravellerCubit.get(context)
                            .activityDate
                            .text
                            .trim(),
                        phone: BookingTravellerCubit.get(context)
                            .phoneActivity
                            .text
                            .trim(),
                        healthLimitations: BookingTravellerCubit.get(context)
                            .healthLimitations
                            .text
                            .trim(),
                        experienceInActivity: BookingTravellerCubit.get(context)
                            .experienceInActivity
                            .text
                            .trim(),
                        specialRequests: BookingTravellerCubit.get(context)
                            .specialRequestsActivity
                            .text
                            .trim(),
                        languages: BookingTravellerCubit.get(context)
                            .languagesActivity
                            .text
                            .trim(),
                      );
                    },
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
          ),
        ),
      ],
    ),
  );
}

ListTile roomNumBuilder({
  required Function function,
  required String title,
  required int number,
}) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(
        color: accentColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
    trailing: SizedBox(
      width: 70.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              function(isAdded: false);
            },
            child: Icon(
              Icons.remove_circle_outline,
              size: 24.sp,
            ),
          ),
          Text(
            number.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: accentColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: () {
              function(isAdded: true);
            },
            child: Icon(
              Icons.add_circle_outline,
              size: 24.sp,
            ),
          ),
        ],
      ),
    ),
  );
}
