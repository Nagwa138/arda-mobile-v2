import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/traveller/homeTravelling/cardBuilder2/cardBuilder2.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/accomadationType_cubit/accomadtion_type_cubit.dart';

class Camp extends StatelessWidget {
  const Camp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextFormField(
            controller: AccommodatingCubit.get(context).searchCamp,
            onChanged: (value) {
              AccommodatingCubit.get(context).getAllAccommodatingBasedTypeCamp(
                accomondatonIdCamp: AccommodatingCubit.get(context).getAllAccommodatingModel!.data![AccommodatingCubit.get(context).camp].id.toString(),
              );
            },
            onFieldSubmitted: (value) {
              print(AccommodatingCubit.get(context).getAllAccommodatingModel!.data![AccommodatingCubit.get(context).camp].id.toString());
              AccommodatingCubit.get(context).getAllAccommodatingBasedTypeCamp(
                accomondatonIdCamp: AccommodatingCubit.get(context).getAllAccommodatingModel!.data![AccommodatingCubit.get(context).camp].id.toString(),
              );
            },
            decoration: InputDecoration(
              hintText: "search for camp",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              filled: true,
              fillColor: white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: Color(0xFFEEEEEE),
                  width: 0.5.w,
                ),
              ),
            ),
          ),
        ),
        // Use Expanded to make the ListView take up the remaining space
        Expanded(
          child: ListView.separated(
            itemCount: AccommodatingCubit.get(context).accomaondationBasedTypeModelCamp?.data?.length ?? 0,
            separatorBuilder: (context, index) => SizedBox(height: 24.h),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'roomInfo', arguments: {
                  'id': AccommodatingCubit.get(context).accomaondationBasedTypeModelCamp!.data![index].id,
                  'price': AccommodatingCubit.get(context).accomaondationBasedTypeModelCamp!.data![index].reservationPrice.toString(),
                  'text' : "Accomandation"
                });
              },
              child: CardBuilder2(
                name: AccommodatingCubit.get(context).accomaondationBasedTypeModelCamp!.data![index].serviceName.toString(),
                location: AccommodatingCubit.get(context).accomaondationBasedTypeModelCamp!.data![index].city.toString(),
                price: AccommodatingCubit.get(context).accomaondationBasedTypeModelCamp!.data![index].reservationPrice.toString(),
                image: AccommodatingCubit.get(context).accomaondationBasedTypeModelCamp!.data![index].coverPhotoUrl.toString(),
                rate: AccommodatingCubit.get(context).accomaondationBasedTypeModelCamp!.data![index].rate.toString(),
                isFavourite: false,
                AccomId: AccommodatingCubit.get(context).accomaondationBasedTypeModelCamp!.data![index].id.toString(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
