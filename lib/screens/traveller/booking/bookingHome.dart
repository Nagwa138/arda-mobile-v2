import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/background_container.dart';
import 'package:PassPort/screens/traveller/homeTravelling/categories%20tabs/products/cart/cart.dart';
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
                const BackgroundContainer(),
                SafeArea(
                  child: Column(
                    children: [
                      BookingAppBar(),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  BookingCategoryCard(
                                    imagePath: "assets/images/accomodtion2.jpg",
                                    title: "Camps and Glamps",
                                    onTap: () {
                                      Navigator.pushNamed(context, "booking");
                                    },
                                  ),
                                  SizedBox(height: 20.h),
                                  BookingCategoryCard(
                                    imagePath: "assets/images/trips2.jpeg",
                                    title: "Journey Planner",
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "bookingTrips");
                                    },
                                  ),
                                  SizedBox(height: 20.h),
                                  BookingCategoryCard(
                                    imagePath: "assets/images/activity2.jpeg",
                                    title: "Adventure",
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "bookingActivity");
                                    },
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

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class BookingAppBar extends StatelessWidget {
  const BookingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}

class BookingCategoryCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const BookingCategoryCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              imagePath,
              height: 150,
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              color: appBackgroundColor,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

Future<void> showMyDialog(BuildContext context) async {
  final formKey = GlobalKey<FormState>();

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return MessageDialog(
        formKey: formKey,
        parentContext: context,
      );
    },
  );
}

class MessageDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final BuildContext parentContext;

  const MessageDialog({
    super.key,
    required this.formKey,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Enter your message',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
      ),
      content: Form(
        key: formKey,
        child: MessageTextField(
          controller:
              BookingTravellerCubit.get(parentContext).contentNotification,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Send'),
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              formKey.currentState?.save();
              BookingTravellerCubit.get(parentContext).sendNotification();
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}

class MessageTextField extends StatelessWidget {
  final TextEditingController controller;

  const MessageTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Message',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
