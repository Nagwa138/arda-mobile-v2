import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/partner/landingMainContentCubit/landingMainContentCubit.dart';
import 'package:PassPort/services/partner/landingMainContentCubit/landingMainContentStates.dart';

class ShowAllGuests extends StatelessWidget {
  const ShowAllGuests({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    return  BlocProvider(

      create: (BuildContext context)=>LandingMainContentCubit()..getAllGuestsShowAll(
       args['state']
      ),
      child: BlocConsumer<LandingMainContentCubit,LandingMainContentStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              centerTitle: true,
              title: Text("homeLanding.guests".tr(),style: TextStyle(
                color: accentColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),),

            ),
            body:
            state is getAllGuestShowAllLoadingState ? Center(child: CircularProgressIndicator(color: orange,)) :
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.w),
                        child: GestureDetector(
                          onTap: (){
                            print(args['state']);
                          },
                          child: Text("homeLanding.countGuests".tr(),style: TextStyle(
                            color: Color.fromRGBO(140, 140, 140, 1),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),

                          ),
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(  LandingMainContentCubit.get(context).guestModel!.totalCount.toString(),
                            style: TextStyle(
                          color: Color.fromRGBO(140, 140, 140, 1),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),

                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index) =>

                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, "profilePartner",arguments: {
                                'id' : LandingMainContentCubit.get(context).guestModel!.data![index].id.toString()
                              });
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/images/landingHome/male.png"),
                                SizedBox(width: 10.w,),
                                Column(
                                  children: [
                                    Text(
                                    LandingMainContentCubit.get(context).guestModel!.data![index].name.toString(),
                                      //"homeLanding.nameGuest".tr(),
                                      style: TextStyle(
                                          color: accentColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp),
                                    ),
                                    Text(
                                        LandingMainContentCubit.get(context).guestModel!.data![index].email.toString(),

                                      style: TextStyle(
                                          color: accentColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Icon(Icons.arrow_forward_ios_outlined)
                                ),

                              ],
                            ),
                          ),

                      separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
                      itemCount: LandingMainContentCubit.get(context).guestModel!.data!.length),
                ],
              ),
            ),
          );
        },
        
      ),
    );
  }
}
