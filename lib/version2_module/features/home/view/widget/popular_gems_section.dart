import 'package:PassPort/version2_module/features/home/data/models/top_rated_model.dart';
import 'package:PassPort/version2_module/features/home/view/widget/accommodation_card.dart';
import 'package:PassPort/version2_module/features/home/view/widget/build_error_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../components/color/color.dart';
import '../../view_model/top_rated_cubit.dart';
import '../../view_model/top_rated_state.dart';
import 'build_loading_section.dart';

class PopularGemsSection extends StatelessWidget {
  const PopularGemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedCubit, TopRatedState>(
      builder: (context, state) {
        if (state is TopRatedSuccess) {
          if (state.topRated.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              // Section Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Popular Gems',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w800,
                              color: accentColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Crowd favorites worth sharing',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to see all
                      },
                      child: Row(
                        children: [
                          Text(
                            'See All',
                            style: TextStyle(
                              color: orange,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: orange,
                            size: 14.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Horizontal List
              SizedBox(
                height: 280.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: state.topRated.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: AccommodationCard(
                        accommodation: TopRatedModel(
                          accomodationId: state.topRated[index].accomodationId,
                          accomodationName:
                              state.topRated[index].accomodationName,
                          address: state.topRated[index].address,
                          imageUrl: state.topRated[index].imageUrl,
                          price: state.topRated[index].price,
                          rate: state.topRated[index].rate,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'roomInfo', arguments: {
                            'id': state.topRated[index].accomodationId,
                            'price': state.topRated[index].price.toString(),
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        if (state is TopRatedError) {
          return buildErrorState(state.message);
        }

        return buildLoadingSection(
          title: 'Popular Gems',
          subtitle: 'Crowd favorites worth sharin',
          height: 280,
          skeletonWidget: AccommodationCard(accommodation: TopRatedModel()),
        );
      },
    );
  }
}
