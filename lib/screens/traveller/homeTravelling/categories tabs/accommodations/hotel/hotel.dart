import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/traveller/homeTravelling/cardBuilder2/cardBuilder2.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/accomadationType_cubit/accomadtion_type_cubit.dart';

class Hotel extends StatelessWidget {
  const Hotel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBackgroundColor, // Set background color
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextFormField(
              controller: AccommodatingCubit.get(context).search,
              onChanged: (value) {
                AccommodatingCubit.get(context)
                    .getAllAccommodatingBasedTypeHotel(
                  accomondatonIdHotel: AccommodatingCubit.get(context)
                      .getAllAccommodatingModel!
                      .data![AccommodatingCubit.get(context).hotel]
                      .id
                      .toString(),
                );
              },
              onFieldSubmitted: (value) {
                print(AccommodatingCubit.get(context)
                    .getAllAccommodatingModel!
                    .data![AccommodatingCubit.get(context).hotel]
                    .id
                    .toString());
                AccommodatingCubit.get(context)
                    .getAllAccommodatingBasedTypeHotel(
                  accomondatonIdHotel: AccommodatingCubit.get(context)
                      .getAllAccommodatingModel!
                      .data![AccommodatingCubit.get(context).hotel]
                      .id
                      .toString(),
                );
              },
              decoration: InputDecoration(
                hintText: "search for hotel ",
                hintStyle: TextStyle(
                  color: accentColor.withOpacity(0.5), // Updated hint text color
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: accentColor, // Updated icon color
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                filled: true,
                fillColor: appBackgroundColor, // Updated fill color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: accentColor.withOpacity(0.3), // Updated border color
                    width: 0.5.w,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: accentColor.withOpacity(0.3), // Updated border color
                    width: 0.5.w,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: accentColor, // Updated focus border color
                    width: 1.w,
                  ),
                ),
              ),
              style: TextStyle(color: accentColor), // Text color
              cursorColor: accentColor, // Cursor color
            ),
          ),
          // Use Expanded to make the ListView take up the remaining space
          Expanded(
            child: ListView.separated(
              itemCount: AccommodatingCubit.get(context)
                      .accomaondationBasedTypeModelHotel
                      ?.data
                      ?.length ??
                  0,
              separatorBuilder: (context, index) => SizedBox(height: 24.h),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'roomInfo', arguments: {
                    'id': AccommodatingCubit.get(context)
                        .accomaondationBasedTypeModelHotel!
                        .data![index]
                        .id,
                    'price': AccommodatingCubit.get(context)
                        .accomaondationBasedTypeModelHotel!
                        .data![index]
                        .reservationPrice
                        .toString(),
                    'text': "Accomandation"
                  });
                },
                child: CardBuilder2(
                  name: AccommodatingCubit.get(context)
                      .accomaondationBasedTypeModelHotel!
                      .data![index]
                      .serviceName
                      .toString(),
                  location: AccommodatingCubit.get(context)
                      .accomaondationBasedTypeModelHotel!
                      .data![index]
                      .city
                      .toString(),
                  price: AccommodatingCubit.get(context)
                      .accomaondationBasedTypeModelHotel!
                      .data![index]
                      .reservationPrice
                      .toString(),
                  image: AccommodatingCubit.get(context)
                      .accomaondationBasedTypeModelHotel!
                      .data![index]
                      .coverPhotoUrl
                      .toString(),
                  rate: AccommodatingCubit.get(context)
                      .accomaondationBasedTypeModelHotel!
                      .data![index]
                      .rate
                      .toString(),
                  AccomId: AccommodatingCubit.get(context)
                      .accomaondationBasedTypeModelHotel!
                      .data![index]
                      .id
                      .toString(),
                  isFavourite: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
