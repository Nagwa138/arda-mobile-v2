import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TripBooking extends StatelessWidget {
  const TripBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddServiceCubit(),
        ),
        BlocProvider(create: (context) => BookingTravellerCubit())
      ],
      child: BlocConsumer<AddServiceCubit, AddServiceState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
            listener: (context, state) {
              if (state is CreateBookingLoading) {
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
              }
              if (state is CreateBookingSuccessful) {
                Navigator.pop(context);
                Navigator.pop(context);
                context.showCustomSnackBar(
                  'Booking created successfully',
                  type: SnackBarType.success,
                );
              } else if (state is CreateBookingError) {
                Navigator.pop(context);
                context.showCustomSnackBar(
                  state.error,
                  type: SnackBarType.error,
                );
              }
            },
            builder: (context, state) {
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
                    appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        centerTitle: true,
                        title: Text("trips.TripBooking".tr(),
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: accentColor,
                            ))),
                    body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),

                            // Header Card
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person_outline,
                                          color: accentColor, size: 24.sp),
                                      SizedBox(width: 8.w),
                                      Text("trips.GuestProfile".tr(),
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                            color: accentColor,
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Text("trips.d1".tr(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Name Field
                            textFormFieldTripe(context,
                                title: 'trips.name'.tr(),
                                hint: 'trips.enterName'.tr(),
                                controller:
                                    BookingTravellerCubit.get(context).name,
                                mixLine: 3,
                                minLine: 2,
                                validation: () {}),

                            // Phone Field
                            textFormFieldTripe(context,
                                title: 'trips.phone'.tr(),
                                hint: 'trips.enterPhone'.tr(),
                                inputType: TextInputType.phone,
                                controller:
                                    BookingTravellerCubit.get(context).phone,
                                mixLine: 3,
                                minLine: 2,
                                validation: () {}),

                            SizedBox(height: 10.h),

                            // Guests Section Card
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Number of Persons
                                  textFormFieldTripe(context,
                                      title: 'addTripe.number'.tr(),
                                      hint: 'Enter number of persons',
                                      inputType: TextInputType.number,
                                      controller:
                                          BookingTravellerCubit.get(context)
                                              .numOfPersonsTrip,
                                      mixLine: 1,
                                      minLine: 1,
                                      validation: () {}),

                                  SizedBox(height: 10.h),

                                  // Number of Children
                                  textFormFieldTripe(context,
                                      title: 'addTripe.chieldern'.tr(),
                                      hint: 'Enter number of children',
                                      inputType: TextInputType.number,
                                      controller:
                                          BookingTravellerCubit.get(context)
                                              .numOfChildrenTrip,
                                      mixLine: 1,
                                      minLine: 1,
                                      validation: () {},
                                      isRequired: false),
                                ],
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Special Requests Field
                            textFormFieldTripe(context,
                                title: 'Special Requests',
                                hint: 'Any special requests or requirements',
                                controller: BookingTravellerCubit.get(context)
                                    .specialRequestsTrip,
                                mixLine: 4,
                                minLine: 2,
                                validation: () {},
                                isRequired: false),

                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      decoration: BoxDecoration(
                        color: appBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: 350.w,
                        height: 55.h,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      side: BorderSide(
                                          color: accentColor, width: 2))),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(accentColor),
                              elevation: WidgetStateProperty.all(4),
                            ),
                            onPressed: () async {
                              // Validation
                              if (BookingTravellerCubit.get(context)
                                      .name
                                      .text
                                      .trim()
                                      .isEmpty ||
                                  BookingTravellerCubit.get(context)
                                      .phone
                                      .text
                                      .trim()
                                      .isEmpty) {
                                context.showCustomSnackBar(
                                  "Please enter name and phone number",
                                  type: SnackBarType.error,
                                );
                                return;
                              }

                              // Validate number of persons
                              final numPersonsText =
                                  BookingTravellerCubit.get(context)
                                      .numOfPersonsTrip
                                      .text
                                      .trim();
                              if (numPersonsText.isEmpty) {
                                context.showCustomSnackBar(
                                  "Please enter number of persons",
                                  type: SnackBarType.error,
                                );
                                return;
                              }

                              final numPersons = int.tryParse(numPersonsText);
                              if (numPersons == null || numPersons <= 0) {
                                context.showCustomSnackBar(
                                  "Number of persons must be greater than 0",
                                  type: SnackBarType.error,
                                );
                                return;
                              }

                              // Validate number of children
                              final numChildrenText =
                                  BookingTravellerCubit.get(context)
                                      .numOfChildrenTrip
                                      .text
                                      .trim();
                              int numChildren = 0;
                              if (numChildrenText.isNotEmpty) {
                                numChildren =
                                    int.tryParse(numChildrenText) ?? 0;
                                if (numChildren < 0) {
                                  context.showCustomSnackBar(
                                    "Number of children cannot be negative",
                                    type: SnackBarType.error,
                                  );
                                  return;
                                }
                              }

                              print(arguments['id']);
                              BookingTravellerCubit.get(context)
                                  .createBookingTrip(
                                tripId: arguments['id'],
                                numOfPersons: numPersons,
                                name: BookingTravellerCubit.get(context)
                                    .name
                                    .text
                                    .trim(),
                                phone: BookingTravellerCubit.get(context)
                                    .phone
                                    .text
                                    .trim(),
                                numberOfChildren: numChildren,
                                specialRequests:
                                    BookingTravellerCubit.get(context)
                                        .specialRequestsTrip
                                        .text
                                        .trim(),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle_outline, size: 20.sp),
                                SizedBox(width: 8.w),
                                Flexible(
                                  child: Text(
                                    "booking.Continue".tr() +
                                        " ${arguments['price']} " +
                                        "booking.EGP".tr() +
                                        " / " +
                                        "trips.person".tr(),
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: white,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

Widget textFormFieldTripe(
  BuildContext context, {
  required String title,
  required String hint,
  bool isRequired = true,
  bool isRead = false,
  required TextEditingController controller,
  VoidCallback? onTap,
  bool obstructText = false,
  int mixLine = 2,
  int minLine = 1,
  TextInputType inputType = TextInputType.text,
  required final Function validation,
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
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            validator: (value) =>
                value!.isEmpty ? 'Please enter a valid value' : null,
            onChanged: (value) {},
            onTap: onTap,
            readOnly: isRead,
            obscureText: obstructText,
            keyboardType: inputType,
            maxLines: mixLine,
            minLines: minLine,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              hintText: hint.tr(),
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: accentColor,
                  width: 2,
                ),
              ),
              suffixIcon: suffixIcon,
            ),
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
