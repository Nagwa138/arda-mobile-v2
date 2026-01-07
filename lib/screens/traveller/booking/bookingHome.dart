import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingHome extends StatelessWidget {
  const BookingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BookingTravellerCubit(),
      child: BlocConsumer<BookingTravellerCubit, BookingTravellerStates>(
        listener: (context, state) {
          if (state is SendNotificationSuccessful) {
            context.showCustomSnackBar(
              "Send Message Successful",
              type: SnackBarType.success,
            );
            BookingTravellerCubit.get(context).contentNotification.clear();
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                // Background Image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        automaticallyImplyLeading: false,
                        centerTitle: true,
                        title: Text(
                          "booking.booking".tr(),
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // actions: [
                        //   IconButton(
                        //     onPressed: () {
                        //       Navigator.pushNamed(context, "cart");
                        //     },
                        //     icon: Icon(
                        //       Icons.shopping_bag,
                        //       size: 40.sp,
                        //     ),
                        //   )
                        // ],
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // BookingTravellerCubit.get(context).getAllBooking(
                                      //     state: "0", serviceName: 'accommodations');
                                      Navigator.pushNamed(context, "booking");
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            child: Image.asset(
                                                height: 150,
                                                fit: BoxFit.fitWidth,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                "assets/images/traveller/accomodtion2.jpg")),
                                        Text("Camps and Glamps",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: appBackgroundColor,
                                              fontWeight: FontWeight.w600,
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "bookingTrips");
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: Image.asset(
                                              height: 150,
                                              fit: BoxFit.fitWidth,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              "assets/images/traveller/trips2.jpeg"),
                                        ),
                                        Text("Journey Planner",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: appBackgroundColor,
                                              fontWeight: FontWeight.w600,
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "bookingActivity");
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: Image.asset(
                                              height: 150,
                                              fit: BoxFit.fitWidth,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              "assets/images/traveller/activity2.jpeg"),
                                        ),
                                        Text("Adventure",
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              color: appBackgroundColor,
                                              fontWeight: FontWeight.w600,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<void> showMyDialog(BuildContext context) async {
  final _formKey = GlobalKey<FormState>();
  String userInput = '';

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to dismiss dialog
    builder: (BuildContext contextm) {
      return AlertDialog(
        title: Text(
          'Enter your message',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: BookingTravellerCubit.get(context).contentNotification,
            decoration: InputDecoration(
              labelText: 'Message',
            ),
            onSaved: (value) {
              userInput = value ?? '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text('Send'),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                // // Handle the user input here
                // print('User input: $userInput');

                BookingTravellerCubit.get(context).sendNotification();
                Navigator.pop(contextm);
              }
            },
          ),
        ],
      );
    },
  );
}
