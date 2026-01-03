import 'package:PassPort/consts/cache manger/cache.dart';
import 'package:PassPort/version2_module/core/services/api_services.dart';
import 'package:PassPort/version2_module/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:PassPort/version2_module/features/home/data/repositories/activities_repo.dart';
import 'package:PassPort/version2_module/features/home/data/repositories/home_repo_impl.dart';
import 'package:PassPort/version2_module/features/home/data/repositories/products_repo.dart';
import 'package:PassPort/version2_module/features/home/data/repositories/trips_repo.dart';
import 'package:PassPort/version2_module/features/home/data/repositories/unique_stays_repo.dart';
import 'package:PassPort/version2_module/features/home/domain/use_cases/get_top_rated_use_case.dart';
import 'package:PassPort/version2_module/features/home/view/widget/activities_section.dart';
import 'package:PassPort/version2_module/features/home/view/widget/explore_search.dart';
import 'package:PassPort/version2_module/features/home/view/widget/golden_hands_section.dart';
import 'package:PassPort/version2_module/features/home/view/widget/notification_bar.dart';
import 'package:PassPort/version2_module/features/home/view/widget/trips_section.dart';
import 'package:PassPort/version2_module/features/home/view/widget/unique_stays_section.dart';
import 'package:PassPort/version2_module/features/home/view_model/activities_cubit.dart';
import 'package:PassPort/version2_module/features/home/view_model/products_cubit.dart';
import 'package:PassPort/version2_module/features/home/view_model/top_rated_cubit.dart';
import 'package:PassPort/version2_module/features/home/view_model/trips_cubit.dart';
import 'package:PassPort/version2_module/features/home/view_model/unique_stays_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../components/color/color.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    String? name = await CacheManger.getData('userName');
    if (name != null && name.isNotEmpty) {
      setState(() {
        userName = name;
      });
    } else {
      setState(() {
        userName = 'Traveller';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TopRatedCubit(
              GetTopRatedUseCase(
                HomeRepositoryImpl(
                  HomeRemoteDataSourceImpl(
                    ApiService(
                      Dio(),
                    ),
                  ),
                ),
              ),
            )..getTopRated(),
          ),
          BlocProvider(
            create: (context) => UniqueStaysCubit(
              UniqueStaysRepositoryImpl(
                ApiService(
                  Dio(),
                ),
              ),
            )..getUniqueStays(),
          ),
          BlocProvider(
            create: (context) => ActivitiesCubit(
              ActivitiesRepositoryImpl(
                ApiService(
                  Dio(),
                ),
              ),
            )..getActivities(),
          ),
          BlocProvider(
            create: (context) => TripsCubit(
              TripsRepositoryImpl(
                ApiService(
                  Dio(),
                ),
              ),
            )..getTrips(),
          ),
          BlocProvider(
            create: (context) => ProductsCubit(
              ProductsRepositoryImpl(
                ApiService(
                  Dio(),
                ),
              ),
            )..getProducts(),
          ),
        ],
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    // Hero Header Section
                    SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          Container(
                            height: 380.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/home_background.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // child: Container(
                            //   decoration: BoxDecoration(
                            //     gradient: LinearGradient(
                            //       begin: Alignment.topCenter,
                            //       end: Alignment.bottomCenter,
                            //       colors: [
                            //         Colors.black.withValues(alpha:0.1),
                            //         Colors.black.withValues(alpha:0.3),
                            //         AppColors.backgroundColor,
                            //       ],
                            //       stops: [0.0, 0.7, 1.0],
                            //     ),
                            //   ),
                            // ),
                          ),

                          // Content Overlay
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.h),

                                // Search Bar - بدون GestureDetector خارجي!
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Hero(
                                        tag: 'search_bar',
                                        child: Material(
                                          color: Colors.transparent,
                                          child:
                                              ExploreSearch(), // بس كده! الـ navigation جواه
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Hero(
                                        tag: 'notificaton_bar',
                                        child: Material(
                                          color: Colors.transparent,
                                          child:
                                              NotificationBar(), // بس كده! الـ navigation جواه
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 165.h),

                                // Welcome Message
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha:0.3),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Text(
                                          'Hello, $userName',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: white,
                                            letterSpacing: 0.9,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 46.sp,
                                            fontWeight: FontWeight.w900,
                                            height: 1.1,
                                            letterSpacing: 0,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black
                                                    .withValues(alpha:0.3),
                                                blurRadius: 10,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          children: [
                                            TextSpan(text: 'Connect with\n'),
                                            TextSpan(
                                              text: 'Culture',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h).toBoxAdapter(),

                    // // Popular Gems Section
                    // SliverToBoxAdapter(
                    //   child: const PopularGemsSection(),
                    // ),

                    // SizedBox(height: 16.h).toBoxAdapter(),

                    // Unique Stays Section
                    // Trips Section
                    SliverToBoxAdapter(
                      child: const TripsSection(),
                    ),

                    SizedBox(height: 16.h).toBoxAdapter(),

                    SliverToBoxAdapter(
                      child: const UniqueStaysSection(),
                    ),
                    SizedBox(height: 16.h).toBoxAdapter(),

                    // Activities Section
                    SliverToBoxAdapter(
                      child: const ActivitiesSection(),
                    ),

                    // Golden Hands Section
                    SliverToBoxAdapter(
                      child: const GoldenHandsSection(),
                    ),

                    // Bottom Padding
                    SliverToBoxAdapter(child: SizedBox(height: 32.h)),
                  ],
                ),
              ),
              floatingActionButton: Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [accentColor, accentColor.withValues(alpha:0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withValues(alpha:0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'addTripe');
                  },
                  backgroundColor:
                      Colors.transparent, // لأننا استخدمنا gradient
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withValues(alpha:0.3), width: 2),
                    ),
                    child: Icon(
                      Icons.map_rounded, // أيقونة الخريطة 📍
                      size: 30.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

// Extension helper
extension SizedBoxExtension on SizedBox {
  Widget toBoxAdapter() => SliverToBoxAdapter(child: this);
}
