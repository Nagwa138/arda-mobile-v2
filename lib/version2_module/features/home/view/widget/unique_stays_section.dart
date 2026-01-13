import 'package:PassPort/models/traveller/accomandating/randomAccomandtion.dart';
import 'package:PassPort/version2_module/features/home/view/widget/build_error_section.dart';
import 'package:PassPort/version2_module/features/home/view/widget/section_header.dart';
import 'package:PassPort/version2_module/features/home/view/widget/unique_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/unique_stays_cubit.dart';
import '../../view_model/unique_stays_state.dart';
import 'build_loading_section.dart';

class UniqueStaysSection extends StatelessWidget {
  const UniqueStaysSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UniqueStaysCubit, UniqueStaysState>(
      builder: (context, state) {
        if (state is UniqueStaysSuccess) {
          if (state.uniqueStays.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header with See More
              SectionHeader(
                title: 'Unique Stays',
                subtitle:
                    'Sleep Somewhere Extraordinary from desert glamps to eco-lodges and historic homes',
                onSeeMoreTap: () {
                  Navigator.pushNamed(
                    context,
                    'uniqueStaysListPage',
                    arguments: {'uniqueStays': state.uniqueStays},
                  );
                },
              ),

              SizedBox(height: 18.h),

              SizedBox(
                height: 380.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: state.uniqueStays.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: UniqueCard(
                        accommodation: state.uniqueStays[index],
                        onTap: () {
                          Navigator.pushNamed(context, 'roomInfo', arguments: {
                            'id': state.uniqueStays[index].accomodationId,
                            'price': state.uniqueStays[index].price.toString(),
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

        if (state is UniqueStaysError) {
          return buildErrorState(state.message);
        }

        return buildLoadingSection(
          title: 'Unique Stays',
          subtitle:
              'Sleep Somewhere Extraordinary from desert glamps to eco-lodges and historic homes',
          height: 510,
          skeletonWidget: UniqueCard(accommodation: Data()),
        );
      },
    );
  }
}
