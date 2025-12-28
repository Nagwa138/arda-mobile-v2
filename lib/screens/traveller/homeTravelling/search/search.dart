import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/cart/empty_Cart.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/traveller/homeTravelling/cardBuilder2/cardBuilder2.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/accomadationType_cubit/accomadtion_type_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/accomadationType_cubit/acommedtion_type_state.dart';

class Serach extends StatelessWidget {
  const Serach({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AccommodatingCubit()..getFiltertion(),
      child: BlocConsumer<AccommodatingCubit, AccommodatingState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = AccommodatingCubit.get(context);
          final hasSearchText = cubit.searchAccomandtion.text.trim().isNotEmpty;
          final resultsCount = cubit.filtertionModel?.data?.length ?? 0;

          return Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  // Modern Search Header
                  Container(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button and title row
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: accentColor.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: accentColor,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Text(
                                'Search',
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Enhanced Search Bar
                        Hero(
                          tag: 'search_bar',
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: accentColor.withOpacity(0.15),
                                  width: 1.5.w,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor.withOpacity(0.08),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: cubit.searchAccomandtion,
                                autofocus: true,
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                onChanged: (value) {
                                  cubit.getFiltertion();
                                },
                                onFieldSubmitted: (value) {
                                  cubit.getFiltertion();
                                },
                                decoration: InputDecoration(
                                  hintText: "Search destinations, hotels...",
                                  hintStyle: TextStyle(
                                    color: accentColor.withOpacity(0.4),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: Icon(
                                      Icons.search_rounded,
                                      color: accentColor.withOpacity(0.5),
                                      size: 24.sp,
                                    ),
                                  ),
                                  suffixIcon: hasSearchText
                                      ? GestureDetector(
                                          onTap: () {
                                            cubit.searchAccomandtion.clear();
                                            cubit.getFiltertion();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(12.w),
                                            child: Icon(
                                              Icons.close_rounded,
                                              color:
                                                  accentColor.withOpacity(0.5),
                                              size: 20.sp,
                                            ),
                                          ),
                                        )
                                      : null,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 16.h,
                                  ),
                                  filled: true,
                                  fillColor: backgroundColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Results count
                        if (hasSearchText && resultsCount > 0)
                          Padding(
                            padding: EdgeInsets.only(top: 12.h, left: 4.w),
                            child: Text(
                              '$resultsCount ${resultsCount == 1 ? 'result' : 'results'} found',
                              style: TextStyle(
                                color: accentColor.withOpacity(0.6),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Search Results or Empty State
                  Expanded(
                    child: !hasSearchText
                        ? _buildEmptySearchState(context)
                        : resultsCount == 0
                            ? _buildNoResultsState(context)
                            : _buildSearchResults(context, cubit),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Empty Search State (when no text entered)
  Widget _buildEmptySearchState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_rounded,
                size: 64.sp,
                color: accentColor.withOpacity(0.4),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "homeLanding.searchEmpty".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: accentColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Start typing to discover amazing places",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: accentColor.withOpacity(0.5),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // No Results State (when search returns nothing)
  Widget _buildNoResultsState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/landingHome/notificationEmpty.png",
              height: 160.h,
            ),
            SizedBox(height: 24.h),
            Text(
              "No Results Found",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: accentColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Try different keywords or check your spelling",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: accentColor.withOpacity(0.5),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Search Results List
  Widget _buildSearchResults(BuildContext context, AccommodatingCubit cubit) {
    return ListView.separated(
      itemCount: cubit.filtertionModel?.data?.length ?? 0,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      itemBuilder: (context, index) {
        final item = cubit.filtertionModel!.data![index];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'roomInfo', arguments: {
              'id': item.id,
              'price': item.reservationPrice.toString()
            });
          },
          child: Hero(
            tag: 'accommodation_${item.id}',
            child: Material(
              color: Colors.transparent,
              child: CardBuilder2(
                name: item.serviceName.toString(),
                location: item.city.toString(),
                price: item.reservationPrice.toString(),
                image: item.coverPhotoUrl.toString(),
                rate: item.rate.toString(),
                AccomId: item.id.toString(),
                isFavourite: false,
              ),
            ),
          ),
        );
      },
    );
  }
}
