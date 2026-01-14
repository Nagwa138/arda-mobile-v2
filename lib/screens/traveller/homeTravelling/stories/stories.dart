import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/services/traveller/homeTravellingcubit/home_traveller_state.dart';
import 'package:PassPort/services/traveller/homeTravellingcubit/home_travellet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_view/story_view.dart';

class Stories extends StatelessWidget {
  final StoryController controller = StoryController();

  Stories({super.key});

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return BlocProvider(
        create: (BuildContext context) =>
            HomeTravellerCubit()..getBloc(categoryId: args!['id']),
        child: BlocConsumer<HomeTravellerCubit, HomeTravellerState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is getBlocLoading) {
                return Scaffold(
                    body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Center(child: CircularProgressIndicator(color: black)),
                    ]));
              }

              return Scaffold(
                backgroundColor: white,
                appBar: AppBar(
                    backgroundColor: white,
                    elevation: 0.0,
                    title: Text(
                        HomeTravellerCubit.get(context)
                            .getAllBlogModel!
                            .data![0]
                            .title
                            .toString(),
                        style: TextStyle(
                            color: black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700)),
                    centerTitle: true),
                body: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: ListView.separated(
                    // physics: NeverScrollableScrollPhysics(),

                    scrollDirection: Axis.vertical,
                    controller:
                        HomeTravellerCubit.get(context).scrollController,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "storyInfo", arguments: {
                          "id": HomeTravellerCubit.get(context)
                              .getAllBlogModel!
                              .data![index]
                              .id
                              .toString()
                        });
                      },
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20.r),
                                  border: Border.all(color: black)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                              20.r),
                                      child: CustomImage(
                                        HomeTravellerCubit.get(context)
                                            .getAllBlogModel!
                                            .data![index]
                                            .imageName
                                            .toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Center(
                                        child: Text(
                                            HomeTravellerCubit.get(context)
                                                .getAllBlogModel!
                                                .data![index]
                                                .title
                                                .toString(),
                                            style: TextStyle(
                                                color: black,
                                                fontSize: 24.sp))),
                                  ])),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 20.h),
                    itemCount: HomeTravellerCubit.get(context)
                        .getAllBlogModel!
                        .data!
                        .length,
                  ),
                ),
              );
            }));
  }
}
