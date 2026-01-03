import 'package:PassPort/models/traveller/activity/activity_random_model.dart'
    as activity_model;
import 'package:PassPort/version2_module/features/home/view/screens/activities_list_page.dart';
import 'package:PassPort/version2_module/features/home/view/widget/build_loading_section.dart';
import 'package:PassPort/version2_module/features/home/view/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

          // Limit to 5 items for home screen
          final displayActivities = state.activities.take(5).toList();

          return Padding(
            padding: EdgeInsets.only(bottom: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  title: 'Local Adventures',
                  onSeeMoreTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ActivitiesListPage(activities: state.activities),
                      ),
                    );
                  },
                ),

                SizedBox(height: 20.h),

                // Horizontal List
                SizedBox(
                  height: 390.h,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: displayActivities.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: ActivityCard(
                          activity: displayActivities[index],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              'activitiesDetails',
                              arguments: displayActivities[index].id,
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
