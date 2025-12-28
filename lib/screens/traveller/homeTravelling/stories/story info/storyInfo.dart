import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellingcubit/home_traveller_state.dart';
import 'package:PassPort/services/traveller/homeTravellingcubit/home_travellet_cubit.dart';

class StoryInfo extends StatelessWidget {
  const StoryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return BlocProvider(

      create: (BuildContext context) =>HomeTravellerCubit()..getBlogById(args?['id']),
      child: BlocConsumer<HomeTravellerCubit,HomeTravellerState>(
        listener: (context,state){},
        builder: (context,state){
         if(state is getBlocByIdLoading ){
           return Center(child: CircularProgressIndicator());
         }
          return Scaffold(
            backgroundColor: white,

            appBar: AppBar(
              backgroundColor: white,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                HomeTravellerCubit.get(context).blogByIdModel!.data!.title.toString(),
                style: TextStyle(
                  color: black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body:

            ListView(
              children: [
                // assets/images/traveller/home/bg.png
                Container(
                  width: double.infinity,
                  height: 210.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        HomeTravellerCubit.get(context).blogByIdModel!.data!.imageName.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.network(
                        HomeTravellerCubit.get(context).blogByIdModel!.data!.imageName.toString(),
                        width: double.infinity,
                        height: 210.h,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: black,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 50.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                if (HomeTravellerCubit.get(context).blogByIdModel?.data?.isFavourite == true) {
                                  HomeTravellerCubit.get(context).deleteFavourite(
                                    HomeTravellerCubit.get(context).blogByIdModel!.data!.id.toString(),
                                  );
                                  HomeTravellerCubit.get(context).changeFav(HomeTravellerCubit.get(context).blogByIdModel?.data?.isFavourite);
                                } else {
                                  HomeTravellerCubit.get(context).postBlogFavourite(
                                    HomeTravellerCubit.get(context).blogByIdModel!.data!.id.toString(),
                                  );
                                  HomeTravellerCubit.get(context).changeFav(HomeTravellerCubit.get(context).blogByIdModel?.data?.isFavourite);
                                }
                              },
                              child: Icon(
                                Icons.favorite,
                                color: HomeTravellerCubit.get(context).blogByIdModel!.data!.isFavourite == true ? Colors.red : white,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/landingHome/profile.png",
                            width: 20.w,
                            height: 20.h,
                            color: orange,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            HomeTravellerCubit.get(context).blogByIdModel!.data!.author.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Text(
                            HomeTravellerCubit.get(context).blogByIdModel!.data!.publishedOn.toString(),
                            style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Column(
                        children: [
                          Text(
                            HomeTravellerCubit.get(context).blogByIdModel!.data!.title.toString(),
                            style: TextStyle(
                              color: black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            HomeTravellerCubit.get(context).blogByIdModel!.data!.contant.toString(),
                            style: TextStyle(
                              color: black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
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
