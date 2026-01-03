import 'package:PassPort/models/traveller/activity/activity_random_model.dart'
    as activity_model;
import 'package:PassPort/version2_module/features/home/view/widget/build_loading_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../components/color/color.dart';
import '../../view_model/activities_cubit.dart';
import '../../view_model/activities_state.dart';
import 'activity_card.dart';

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
      builder: (context, state) {
        if (state is ActivitiesSuccess) {
          if (state.activities.isEmpty) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: EdgeInsets.only(bottom: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Local Adventures',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: lightBrown,
                          letterSpacing: 1,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Horizontal List
                SizedBox(
                  height: 390.h,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: state.activities.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: ActivityCard(
                          activity: state.activities[index],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              'activitiesDetails',
                              arguments: state.activities[index].id,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        if (state is ActivitiesError) {
          return const SizedBox.shrink();
        }

        return buildLoadingSection(
          title: 'Local Adventures',
          subtitle: '',
          height: 300,
          skeletonWidget: ActivityCard(activity: activity_model.Data()),
        );
      },
    );
  }
}
