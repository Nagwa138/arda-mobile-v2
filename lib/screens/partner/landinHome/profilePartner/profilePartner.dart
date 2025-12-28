
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/partner/landingMainContentCubit/landingMainContentCubit.dart';
import 'package:PassPort/services/partner/landingMainContentCubit/landingMainContentStates.dart';

class ProfilePartner extends StatelessWidget {
  const ProfilePartner({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return  BlocProvider(
      create: (BuildContext context)=>LandingMainContentCubit()..getGuestById(id: arguments['id']),
      child: BlocConsumer<LandingMainContentCubit,LandingMainContentStates>(
        listener: (context,state){
          if(state is AcceptSuccessful){
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else if (state is AcceptError){
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else  if(state is RejectSuccessful){
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else if (state is RejectError){
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        builder: (context,state){
          return   Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: Text("ProfileGuest.profile".tr(),style: TextStyle(
                color: accentColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),),

            ),
            body:

            state is getGuestByIdLoadingCancel  ?Center(child: CircularProgressIndicator(color: accentColor,)):
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset("assets/images/landingHome/famele.png")),
                  Center(
                    child: Text(
                      LandingMainContentCubit.get(context).guestByIdModel!.data!.userDate!.userName.toString(),
                      style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Center(
                    child: Text(
                      LandingMainContentCubit.get(context).guestByIdModel!.data!.userDate!.email.toString(),

                      style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "ProfileGuest.message".tr(),
                      style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(height: 30.h,),
                  LandingMainContentCubit.get(context).guestByIdModel!.data!.status != "Pending"
                      ? SizedBox.shrink() :
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50.h,
                          width: 152.w,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: accentColor))
                                  ),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(white),
                                  elevation: MaterialStateProperty.all<double>(0.0)
                              ),
                              onPressed: (){
                                 LandingMainContentCubit.get(context).rejectBooking(id:
                                 LandingMainContentCubit.get(context).guestByIdModel!.data!.id!.toString()

                                 );
                              },
                              child: Text("ProfileGuest.reject".tr(),style: TextStyle(
                                  fontSize: 16.sp,
                                  color: accentColor,
                                  fontWeight: FontWeight.w600
                              ),)),
                        ),
                        SizedBox(width: 20.w,),
                        SizedBox(
                          height: 48.h,
                          width: 152.w,
                          child: ElevatedButton(

                              style: ButtonStyle(
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(color: accentColor))
                                ),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(accentColor),

                              ),
                              onPressed: (){
                                LandingMainContentCubit.get(context).acceptBooking(id:
                                LandingMainContentCubit.get(context).guestByIdModel!.data!.id!.toString()
                                );
                              },
                              child: Text("ProfileGuest.accept".tr(),style: TextStyle(
                                  fontSize: 16.sp,
                                  color: white,
                                  fontWeight: FontWeight.w600
                              ),)),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text("ProfileGuest.informationGuest".tr(),style: TextStyle(
                        fontSize: 18.sp,
                        color: accentColor,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  SizedBox(height: 10.h,),
                  Center(
                    child: Container(
                      width: 327.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
                          borderRadius: BorderRadiusDirectional.circular(10.r)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(right: 10.w,left: 10.w,top: 10.h),
                        child: Column(
                          children: [
                            ProfileInformation(title: "ProfileGuest.name", title2:  LandingMainContentCubit.get(context).guestByIdModel!.data!.guestInfo!.name.toString(),
                            ),
                            SizedBox(height: 20.h,),
                            ProfileInformation(title: "ProfileGuest.email", title2: LandingMainContentCubit.get(context).guestByIdModel!.data!.guestInfo!.email.toString()),
                            SizedBox(height: 20.h,),
                            ProfileInformation(title: "ProfileGuest.birthDay", title2: LandingMainContentCubit.get(context).guestByIdModel!.data!.guestInfo!.birthDate.toString()),
                            SizedBox(height: 20.h,),
                            ProfileInformation(title: "ProfileGuest.gender", title2: LandingMainContentCubit.get(context).guestByIdModel!.data!.guestInfo!.gender.toString())

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text("ProfileGuest.BookingInformation".tr(),style: TextStyle(
                        fontSize: 18.sp,
                        color: accentColor,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  SizedBox(height: 10.h,),
                  Center(
                    child: Container(
                      width: 327.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
                          borderRadius: BorderRadiusDirectional.circular(10.r)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(right: 10.w,left: 10.w,top: 10.h),
                        child: Column(
                          children: [
                            ProfileInformation(title: "ProfileGuest.checkIn", title2: LandingMainContentCubit.get(context).guestByIdModel!.data!.bookingInfo!.checkIn.toString()),
                            SizedBox(height: 20.h,),
                            ProfileInformation(title: "ProfileGuest.checkOut", title2: LandingMainContentCubit.get(context).guestByIdModel!.data!.bookingInfo!.checkOut.toString()),
                            SizedBox(height: 20.h,),
                            ProfileInformation(title: "ProfileGuest.numberGuests", title2: LandingMainContentCubit.get(context).guestByIdModel!.data!.bookingInfo!.guestNo.toString()),
                            SizedBox(height: 20.h,),
                            SizedBox(

                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder:
                              (context,index)=>  ProfileInformation(title: "${
                                  LandingMainContentCubit.get(context).guestByIdModel!.data!.bookingInfo!.room![index].roomType
                              }", title2: LandingMainContentCubit.get(context).guestByIdModel!.data!.bookingInfo!.room![index].count.toString())

                                  , separatorBuilder: (context,index)=>SizedBox(height: 10.h,), itemCount:
                                  LandingMainContentCubit.get(context).guestByIdModel!.data!.bookingInfo!.room!.length
                              ),
                            ),
                            SizedBox(height: 15.h,),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, "getRoomDetails",arguments: {
                                  "id" : LandingMainContentCubit.get(context).guestByIdModel!.data!.id.toString(),
                                  "night" : LandingMainContentCubit.get(context).calculateDifference(
                                      startDateStr :LandingMainContentCubit.get(context).guestByIdModel!.data!.bookingInfo!.start.toString(),
                                      endDateStr :LandingMainContentCubit.get(context).guestByIdModel!.data!.bookingInfo!.end.toString()
                                  )
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("View  Rooms Details",style: TextStyle(decoration: TextDecoration.underline,fontSize: 16.sp,fontWeight: FontWeight.w600),)),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text("ProfileGuest.PaymentInformation".tr(),style: TextStyle(
                        fontSize: 18.sp,
                        color: accentColor,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  SizedBox(height: 10.h,),
                  Center(
                    child: Container(
                      width: 327.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
                          borderRadius: BorderRadiusDirectional.circular(10.r)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(right: 10.w,left: 10.w,top: 10.h),
                        child: Column(
                          children: [
                            SizedBox(height: 20.h,),

                            ProfileInformation(title: "ProfileGuest.Payment method", title2: "ProfileGuest.notVerified"),
                            SizedBox(height: 20.h,)


                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text("ProfileGuest.Ad details".tr(),style: TextStyle(
                        fontSize: 18.sp,
                        color: accentColor,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  SizedBox(height: 10.h,),
                  Center(
                    child: Container(
                      width: 327.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
                          borderRadius: BorderRadiusDirectional.circular(10.r)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(right: 10.w,left: 10.w,top: 10.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network("${LandingMainContentCubit.get(context).guestByIdModel!.data?.serviceDetails!.image.toString()}",width:99.w ,height: 89.h,),
                                SizedBox(width: 5.w,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:150.w,
                                      child: Text("${LandingMainContentCubit.get(context).guestByIdModel!.data?.serviceDetails!.title.toString()}",style: TextStyle(
                                          fontSize: 16.sp,
                                          color: accentColor,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    ),
                                    Row(children: [
                                      Image.asset("assets/images/landingHome/location.png"),
                                      Text("${LandingMainContentCubit.get(context).guestByIdModel!.data?.serviceDetails!.location.toString()}",style: TextStyle(
                                          fontSize: 14.sp,
                                          color: accentColor,
                                          fontWeight: FontWeight.w400
                                      ),),



                                    ],),
                                    Row(children: [
                                      Text("${LandingMainContentCubit.get(context).guestByIdModel!.data?.serviceDetails!.price.toString()}" + "   " + "booking.EGP".tr() ,style: TextStyle(
                                          fontSize: 14.sp,
                                          color: accentColor,
                                          fontWeight: FontWeight.w400
                                      ),),
                                      SizedBox(width: 10.w,),
                                      Text("/ "+ "booking.Nigth".tr(),style: TextStyle(
                                          fontSize: 14.sp,
                                          color: accentColor,
                                          fontWeight: FontWeight.w600
                                      ),),


                                    ],)
                                  ],
                                ),



                              ],
                            ),
                            SizedBox(height: 30.h,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),









                ],
              ),
            ),
          );
        },

      ),
    );
  }
}

Widget ProfileInformation({required String title, required String title2}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          overflow: TextOverflow.ellipsis,
          title.tr(),
          style: TextStyle(
              fontWeight: FontWeight.w700, color: black, fontSize: 16.sp),
        ),
      ),

      Spacer(),

      Expanded(
        child: Text(
          overflow: TextOverflow.ellipsis,
          title2.tr() ,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(5, 10, 42, 1),
              fontSize: 14.sp),
        ),
      ),
    ],
  );
}
