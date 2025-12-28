import 'package:PassPort/screens/traveller/booking/accomandation/detailsbooking/detaialsbookingPending.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customButton/customButton.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerCubit.dart';
import 'package:PassPort/services/traveller/bookingTravellerCubit/bookingTravellerStates.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsBookingCCanceled extends StatelessWidget {
  const DetailsBookingCCanceled({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return  BlocProvider(

      create: (BuildContext context)=>BookingTravellerCubit()..getBookingDetails(id: arguments['cancelId']),
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
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text("booking.Details".tr(),style: TextStyle(
                color: black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),),

            ),
            body:
            state is getBookingDetailsLoading ? Center(child: CircularProgressIndicator(color: orange,)):
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 300.h,
                    child:

                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.roomImages?.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>Stack(
                          children: [
                            Image.network(BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.roomImages![index],width: 250.w,height : 300.h,fit: BoxFit.cover),
                            Padding(
                              padding:  EdgeInsets.only(top: 20.h,right: 10.w,left: 10.w),
                              child: Container(
                                width: 83.w,
                                height: 43.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(27.r),
                                    color: white
                                ),
                                child: Center(
                                  child: Text(
                                    BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.accomodationType.toString(),
                                    // "Services.hotels".tr(),

                                    style: TextStyle(
                                        color: accentColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700
                                    ),),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,right: 2,
                              child: Padding(
                                padding:  EdgeInsets.only(top: 20.h,right: 10.w,left: 10.w),
                                child: Container(
                                  width: 45.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadiusDirectional.circular(27.r),
                                      color: white
                                  ),
                                  child: Center(
                                    child: Text("${index + 1}/${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.roomImages?.length}",style: TextStyle(
                                        color: accentColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700
                                    ),),
                                  ),
                                ),
                              ),
                            )

                          ],
                        )),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text(
                        BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.serviceName.toString(),
                        // "Sonesta St. George Hotel - Convention.",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(children: [
                      Image.asset("assets/images/landingHome/location.png"),
                      Text(
                        "${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.location}",
                        // "booking.Luxor".tr() + "   ",

                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Color.fromRGBO(140, 140, 140, 1),
                            fontWeight: FontWeight.w400
                        ),),
                      SizedBox(width: 20.w,),
                      Text("booking.Egypt".tr(),style: TextStyle(
                          fontSize: 14.sp,
                          color: Color.fromRGBO(140, 140, 140, 1),
                          fontWeight: FontWeight.w400
                      ),),

                      Spacer(),
                      Icon(Icons.star_rounded,color: Colors.amber,size: 20.sp,),
                      Text("${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.rate}",style: TextStyle(
                        fontSize: 12.sp,
                        color:accentColor,
                        fontWeight: FontWeight.w500,

                      ),),




                    ],),
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    width: 327.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
                        borderRadius: BorderRadiusDirectional.circular(20.r)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "booking.HostDetails".tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            children: [
                              Image.asset("assets/images/traveller/location.png"),
                              SizedBox(width: 5.w,),
                              SizedBox(
                                width: 250.w,
                                child: Text(
                                    BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.location.toString(),
                                    // "23 Abbas El Aqqad st - Naser city - Cairo",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            children: [
                              Image.asset("assets/images/traveller/call.png"),
                              SizedBox(width: 5.w,),
                              SizedBox(
                                width: 250.w,
                                child: Text(
                                    "Call the Host through +${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.phone.toString()}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h,),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    width: 327.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
                        borderRadius: BorderRadiusDirectional.circular(20.r)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          detailsBooking(title: "ProfileGuest.checkIn", title2: BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.checkIn.toString()),
                          SizedBox(height: 5.h,),
                          detailsBooking(title: "ProfileGuest.checkOut", title2: BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.checkOut.toString()),
                          SizedBox(height: 5.h,),
                          detailsBooking(title: "ProfileGuest.numberGuests", title2: BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.guestNo.toString()),
                          SizedBox(height: 5.h,),
                          ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context,index)=>Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.roomType![index].roomType.toString()),
                                  Text(BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.roomType![index].count.toString()),
                                ],
                              ),
                              separatorBuilder: (context,index)=>SizedBox(height : 5.h), itemCount: BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.roomType!.length),
                          SizedBox(height: 10.h,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, "getRoomDetails",arguments: {
                                "id" : BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.id.toString(),
                                "night" : BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.totalNight
                              });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                child: Text("View  Rooms Details",style: TextStyle(decoration: TextDecoration.underline,fontSize: 16.sp,fontWeight: FontWeight.w600),)),
                          ),

                          SizedBox(height: 10.h,),



                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    width: 327.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
                        borderRadius: BorderRadiusDirectional.circular(20.r)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                "${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.totalNight.toString()} " + "booking.Nigth".tr() ,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,  fontSize: 16.sp),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 140.w,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  "${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.pricePerNight.toString()}" + "booking.EGP".tr() + "/" + "Night" ,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,

                                      fontSize: 14.sp),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                              "booking.IncludingTax".tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                "booking.Total".tr(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,  fontSize: 16.sp),
                              ),
                              Spacer(),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                "${BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.totalPrice.toString()} " + "booking.EGP".tr() ,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  
                                    fontSize: 16.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h,),



                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  SizedBox(
                    width: 327.w,height: 55.h,
                    child: ElevatedButton(

                        style: ButtonStyle(
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: accentColor))
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(orange),

                        ),
                        onPressed: (){
                          BookingTravellerCubit.get(context).bookAgainAccomandtion(
                              id:
                              BookingTravellerCubit.get(context).accomandationDetailsModel!.data!.id.toString()
                          );
                        },
                        child: Text("booking.BookAgain".tr(),style: TextStyle(
                            fontSize: 16.sp,
                            color: white,
                            fontWeight: FontWeight.w600
                        ),)),
                  ),
                  SizedBox(height: 20.h,),

                ],
              ),
            ),

          );
        },

      ),
    );
  }
}


