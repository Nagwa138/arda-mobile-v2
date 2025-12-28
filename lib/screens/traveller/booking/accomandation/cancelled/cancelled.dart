import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customButton/customButton.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cancelled extends StatelessWidget {
  const Cancelled({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(

        create: (BuildContext context)=>BookingTravellerCubit()..getAllBooking(state: "3", serviceName: "accommodations"),
        child: BlocConsumer<BookingTravellerCubit,BookingTravellerStates>(
          listener: (context,state){
            if(state is BookingAgainRoomsSuccessful){
              BookingTravellerCubit.get(context).toggleBooking(0);

              BookingTravellerCubit.get(context)
                  .getAllBooking(state: "3", serviceName: "accommodations");
              BookingTravellerCubit.get(context)
                  .getAllBooking(state: "0", serviceName: "accommodations");
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
            else if (state is BookingAgainRoomsError){
              Fluttertoast.showToast(
                  msg: state.error,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          },
          builder: (context,state){
            if(state is   getBookingLoading ){
              return Center(child: CircularProgressIndicator()) ;
            }
            return  ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return Column(

                    children: [
                      GestureDetector(
                        onTap: (){
                          print(BookingTravellerCubit.get(context).cancel!.data![index].id.toString());
                          Navigator.pushNamed(context, "detailsBookingCanceled",
                              arguments: {
                                'cancelId'  : BookingTravellerCubit.get(context).cancel!.data![index].id.toString()}
                          );
                        },
                        child: Container(
                          width: 350.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(25.r),
                              color: Colors.white54
                          ),
                          child:Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(BookingTravellerCubit.get(context).cancel!.data![index].image.toString(),width:99.w ,height: 107.h,fit: BoxFit.fill,),
                                        SizedBox(width: 20.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 170.w,
                                              child: Text(BookingTravellerCubit.get(context).cancel!.data![index].serviceName.toString(),style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.w600
                                              ),),
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(children: [
                                              Image.asset("assets/images/landingHome/location.png"),
                                              Text(BookingTravellerCubit.get(context).cancel!.data![index].address.toString().tr(),style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color.fromRGBO(140, 140, 140, 1),
                                                  fontWeight: FontWeight.w400
                                              ),),


                                            ],),
                                            SizedBox(height: 5.h,),
                                            Row(children: [
                                              Icon(Icons.date_range_outlined,color: orange,size: 18.sp,),
                                              SizedBox(
                                                width: 130.w,
                                                child: Text(BookingTravellerCubit.get(context).cancel!.data![index].bookingDate.toString(),style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color.fromRGBO(140, 140, 140, 1),
                                                    fontWeight: FontWeight.w400
                                                ),),
                                              ),


                                            ],),
                                            SizedBox(height: 5.h,),
                                            Row(children: [
                                              Text(BookingTravellerCubit.get(context).cancel!.data![index].price.toString() +"  "+   "booking.EGP".tr() ,style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.w400
                                              ),),
                                              SizedBox(width: 6.w,),
                                              Text("booking.Nigth".tr(),style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.w600
                                              ),),


                                            ],),

                                          ],

                                        ),



                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                    Divider(color: Color.fromRGBO(224, 224, 224, 1),),
                                    CustomButton(height: 40.h, function: (){
                                      BookingTravellerCubit.get(context).bookAgainAccomandtion(
                                          id:
                                          BookingTravellerCubit.get(context).cancel!.data![index].id.toString()
                                      );
                                    }, text: "booking.BookAgain".tr(), width: 303.w),
                                    SizedBox(height: 10.h,)                            ],
                                ),
                              ),
                            ],
                          ),

                        ),
                      ),
                      SizedBox(height: 10.h,),
                    ],
                  );
                }, separatorBuilder: (context,index)=>SizedBox(height: 5.h,),
                itemCount: BookingTravellerCubit.get(context).cancel!.data!.length);
          },

        ),
      );
  }
}
