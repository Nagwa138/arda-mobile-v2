import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customText.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/trips_cubit/trips_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/trips_cubit/trips_state.dart';

class AddTripe extends StatelessWidget {
  const AddTripe({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddServiceCubit(),
        ),
        BlocProvider(create: (context) => TripsCubit())
      ],
      child: BlocConsumer<AddServiceCubit, AddServiceState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<TripsCubit, TripsStates>(
            listener: (BuildContext context, state) {
              if (state is CreateTripSuccessful) {
                TripsCubit.get(context).clearFormFields();
                Navigator.pushNamed(context, "travellerNavBar");
                Fluttertoast.showToast(
                    msg: "Trip created successfully!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (state is CreateTripError) {
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
            builder: (BuildContext context, Object? state) {
              return Scaffold(
                backgroundColor: appBackgroundColor,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: accentColor, size: 20.sp),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    "Create Your Trip",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: orange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: TripsCubit.get(context).formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Text(
                            'Design Your Experience ',
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Tell us what kind of trip you dream of, whether it’s a romantic escape, a family adventure, or a team getaway. Our team will design a personalized experience just for you.",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 32.h),

                          // Form Container
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: appBackgroundColor,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.08),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                textFormFieldTripe(
                                  context,
                                  icon: Icons.flag_outlined,
                                  title: 'addTripe.Name'.tr(),
                                  hint: 'addTripe.hintName'.tr(),
                                  controller: TripsCubit.get(context).nameTrips,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return "please Enter Name";
                                    }
                                    return null;
                                  },
                                ),
                                textFormFieldTripe(
                                  context,
                                  icon: Icons.groups_outlined,
                                  title: "type of Group",
                                  hint: "example:- company , family , bigGroup",
                                  controller:
                                      TripsCubit.get(context).nameSupervisor,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return "please Enter type of group";
                                    }
                                    return null;
                                  },
                                ),
                                textFormFieldTripe(
                                  context,
                                  icon: Icons.calendar_today_outlined,
                                  title: 'addTripe.date'.tr(),
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return "please select date";
                                    }
                                    return null;
                                  },
                                  isRead: true,
                                  onTap: () {
                                    TripsCubit.get(context).PickDate(
                                        context: context,
                                        controller:
                                            TripsCubit.get(context).date,
                                        firstTime: DateTime.now(),
                                        lastTime: DateTime(2050 - 1 - 1));
                                  },
                                  hint: 'addTripe.enterDate'.tr(),
                                  controller: TripsCubit.get(context).date,
                                  suffixIcon:
                                      Icon(Icons.calendar_month, color: orange),
                                ),
                                textFormFieldTripe(
                                  context,
                                  icon: Icons.location_on_outlined,
                                  title: "the city you want to visit",
                                  hint: 'addTripe.city'.tr(),
                                  controller: TripsCubit.get(context).toGo,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return "please Enter place";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.h),
                                roomNumBuilder(
                                  function: context
                                      .read<AddServiceCubit>()
                                      .changeSingleRoomNum,
                                  number: context
                                      .read<AddServiceCubit>()
                                      .singleRoomNum,
                                  title: 'addTripe.number'.tr(),
                                ),
                                SizedBox(height: 10.h),
                                textFormFieldTripe(
                                  context,
                                  icon: Icons.description_outlined,
                                  title: 'addTripe.about'.tr(),
                                  hint: 'addTripe.aboutTripe'.tr(),
                                  minLine: 6,
                                  mixLine: 7,
                                  controller:
                                      TripsCubit.get(context).aboutTrips,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter description";
                                    }
                                    return null;
                                  },
                                ),
                                textFormFieldTripe(
                                  context,
                                  icon: Icons.note_outlined,
                                  title: 'addTripe.specialNotes'.tr(),
                                  hint: 'addTripe.hintSpecialNotes'.tr(),
                                  minLine: 3,
                                  mixLine: 4,
                                  isRequired: false,
                                  controller: TripsCubit.get(context)
                                      .specialNotesOrRequests,
                                  validation: (value) {
                                    return null;
                                  },
                                ),
                                textFormFieldTripe(
                                  context,
                                  icon: Icons.attach_money_outlined,
                                  title: 'addTripe.budget'.tr(),
                                  hint: 'addTripe.hintBudget'.tr(),
                                  inputType: TextInputType.number,
                                  controller: TripsCubit.get(context)
                                      .estimatedBudgetPerPerson,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter estimated budget";
                                    }
                                    return null;
                                  },
                                ),
                                textFormFieldTripe(
                                  context,
                                  icon: Icons.phone_outlined,
                                  title: 'addTripe.mobile'.tr(),
                                  hint: 'addTripe.hintMobile'.tr(),
                                  inputType: TextInputType.phone,
                                  controller:
                                      TripsCubit.get(context).mobileNumber,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter mobile number";
                                    }
                                    return null;
                                  },
                                ),
                                textFormFieldTripe(
                                  context,
                                  icon: Icons.travel_explore_outlined,
                                  title: 'addTripe.tripType'.tr(),
                                  hint: 'addTripe.hintTripType'.tr(),
                                  controller: TripsCubit.get(context).tripType,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter trip type";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // Submit Button
                          state is CreateTripLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: accentColor,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    if (TripsCubit.get(context)
                                        .formKey
                                        .currentState!
                                        .validate()) {
                                      if (context
                                              .read<AddServiceCubit>()
                                              .singleRoomNum ==
                                          0) {
                                        Fluttertoast.showToast(
                                            msg: "enter number of person",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else {
                                        TripsCubit.get(context).createTrips(
                                          NumOfPerson: context
                                              .read<AddServiceCubit>()
                                              .singleRoomNum
                                              .toString(),
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 58.h,
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      borderRadius: BorderRadius.circular(16.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: accentColor.withOpacity(0.3),
                                          blurRadius: 12,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.white,
                                          size: 24.sp,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          "booking.submit".tr(),
                                          style: TextStyle(
                                            fontSize: 17.sp,
                                            color: white,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                          SizedBox(height: 40.h),
                        ],
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

Widget textFormFieldTripe(
  BuildContext context, {
  required IconData icon,
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
    padding: EdgeInsets.only(bottom: 20.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: orange,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: title.tr(),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 15.sp,
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
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.black.withOpacity(0.08),
              width: 1.5,
            ),
          ),
          child: TextFormField(
            onTap: onTap,
            readOnly: isRead,
            controller: controller,
            onChanged: (value) {},
            obscureText: obstructText,
            validator: (input) => validation(input),
            maxLines: mixLine,
            minLines: minLine,
            keyboardType: inputType,
            style: TextStyle(
              color: accentColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              hintText: hint.tr(),
              hintStyle: TextStyle(
                color: Colors.black38,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget roomNumBuilder({
  required Function function,
  required String title,
  required int number,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: orange.withOpacity(0.05),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: orange.withOpacity(0.2),
        width: 1.5,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: orange.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.people_outline,
                color: orange,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                color: accentColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      function(isAdded: false);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                      child: Icon(
                        Icons.remove_circle_outline,
                        size: 25.sp,
                        color: number > 0 ? accentColor : Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    width: 40.w,
                    alignment: Alignment.center,
                    child: Text(
                      number.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      function(isAdded: true);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                      child: Icon(
                        Icons.add_circle_outline,
                        size: 25.sp,
                        color: accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
