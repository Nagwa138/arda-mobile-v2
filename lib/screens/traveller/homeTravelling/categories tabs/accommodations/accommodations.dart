import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/traveller/homeTravelling/cardBuilder2/cardBuilder2.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/accomadationType_cubit/accomadtion_type_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/accomadationType_cubit/acommedtion_type_state.dart';

class Accommodations extends StatelessWidget {
  const Accommodations({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AccommodatingCubit()..accomandation(),
      child: BlocConsumer<AccommodatingCubit, AccommodatingState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextFormField(
                    controller: AccommodatingCubit.get(context).searchCamp,
                    onChanged: (value) {
                      AccommodatingCubit.get(context)
                          .getAllAccommodatingBasedTypeCamp(
                        accomondatonIdCamp: AccommodatingCubit.get(context)
                            .getAllAccommodatingModel!
                            .data![AccommodatingCubit.get(context).camp]
                            .id
                            .toString(),
                      );
                    },
                    onFieldSubmitted: (value) {
                      print(AccommodatingCubit.get(context)
                          .getAllAccommodatingModel!
                          .data![AccommodatingCubit.get(context).camp]
                          .id
                          .toString());
                      AccommodatingCubit.get(context)
                          .getAllAccommodatingBasedTypeCamp(
                        accomondatonIdCamp: AccommodatingCubit.get(context)
                            .getAllAccommodatingModel!
                            .data![AccommodatingCubit.get(context).camp]
                            .id
                            .toString(),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "search ",
                      hintStyle: TextStyle(
                        color: accentColor,
                        fontSize: 14.sp,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: accentColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      filled: true,
                      fillColor: appBackgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: appBackgroundColor,
                          width: 0.5.w,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                state is GetAccommodatingLoading ||
                        state is GetAccommodatingBasedTypeCampLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: accentColor,
                      ))
                    : AccommodatingCubit.get(context)
                            .accomaondationBasedTypeModelCamp!
                            .data!
                            .isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 180.h,
                                  ),
                                  Image.asset(
                                      "assets/images/landingHome/notificationEmpty.png"),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "You haven’t any Camps Now",
                                    style: TextStyle(
                                      color: accentColor,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: AccommodatingCubit.get(context)
                                      .accomaondationBasedTypeModelCamp
                                      ?.data
                                      ?.length ??
                                  0,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 24.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 24.h),
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'roomInfo',
                                      arguments: {
                                        'id': AccommodatingCubit.get(context)
                                            .accomaondationBasedTypeModelCamp!
                                            .data![index]
                                            .id,
                                        'price': AccommodatingCubit.get(context)
                                            .accomaondationBasedTypeModelCamp!
                                            .data![index]
                                            .reservationPrice
                                            .toString(),
                                        'text': "Accomandation"
                                      });
                                },
                                child: CardBuilder2(
                                  name: AccommodatingCubit.get(context)
                                      .accomaondationBasedTypeModelCamp!
                                      .data![index]
                                      .serviceName
                                      .toString(),
                                  location: AccommodatingCubit.get(context)
                                      .accomaondationBasedTypeModelCamp!
                                      .data![index]
                                      .city
                                      .toString(),
                                  price: AccommodatingCubit.get(context)
                                      .accomaondationBasedTypeModelCamp!
                                      .data![index]
                                      .reservationPrice
                                      .toString(),
                                  image: AccommodatingCubit.get(context)
                                      .accomaondationBasedTypeModelCamp!
                                      .data![index]
                                      .coverPhotoUrl
                                      .toString(),
                                  rate: AccommodatingCubit.get(context)
                                      .accomaondationBasedTypeModelCamp!
                                      .data![index]
                                      .rate
                                      .toString(),
                                  isFavourite: false,
                                  AccomId: AccommodatingCubit.get(context)
                                      .accomaondationBasedTypeModelCamp!
                                      .data![index]
                                      .id
                                      .toString(),
                                ),
                              ),
                            ),
                          ),
              ],
            ),
          );
        },
      ),
    );
  }
}
