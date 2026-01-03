import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/screens/partner/services/detailsservices/detailsservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/di/service_provider.dart';
import '../cubit/partner_services_cubit.dart';
import '../cubit/partner_services_state.dart';
import '../cubit/service_submission_cubit.dart';
import '../models/partner_service_item.dart';
import '../widgets/dynamic_service_form.dart';
import '../widgets/service_card.dart';

class PartnerServicesScreen extends StatelessWidget {
  const PartnerServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<DynamicServiceFormState>();

    return BlocProvider(
      create: (context) => ServiceProvider.createServiceSubmissionCubit(),
      child: BlocConsumer<ServiceSubmissionCubit, ServiceSubmissionState>(
        listener: (context, state) {
          if (state is ServiceSubmissionSuccess) {
            formKey.currentState?.resetLoadingState();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Expanded(child: Text(state.message)),
                  ],
                ),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                margin: EdgeInsets.all(16.w),
              ),
            );
            Navigator.pop(context);
          }

          if (state is ServiceSubmissionError) {
            formKey.currentState?.resetLoadingState();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error_outline_rounded,
                        color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Expanded(child: Text(state.message)),
                  ],
                ),
                backgroundColor: Colors.red.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                margin: EdgeInsets.all(16.w),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  // Modern Header
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: appTextColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: IconButton(
                                icon:
                                    Icon(Icons.arrow_back_ios_new, size: 18.sp),
                                color: appTextColor,
                                onPressed: () => Navigator.pop(context),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'My Services',
                                    style: TextStyle(
                                      color: appTextColor,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  Text(
                                    'Manage your offerings',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _SearchAndStatusHeader(),
                      ],
                    ),
                  ),

                  // Services List
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: BlocProvider(
                        create: (_) =>
                            PartnerServicesCubit()..loadForCurrentUser(),
                        child: _PartnerServicesBlocList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: appTextColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: FloatingActionButton.extended(
                onPressed: state is ServiceSubmissionLoading
                    ? null
                    : () => _showAddServiceForm(context, formKey),
                backgroundColor: appTextColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                icon: state is ServiceSubmissionLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Icon(Icons.add_rounded, size: 24.sp),
                label: Text(
                  state is ServiceSubmissionLoading
                      ? 'Adding...'
                      : 'Add Service',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddServiceForm(
      BuildContext context, GlobalKey<DynamicServiceFormState> formKey) async {
    final storage = FlutterSecureStorage();
    final userTypeStr = await storage.read(key: 'userType');
    final userTypeId = int.tryParse(userTypeStr ?? '3');

    String partnerType = 'addAccommodation';
    if (userTypeId == 4) {
      partnerType = 'activity';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DynamicServiceForm(
            key: formKey,
            partnerType: partnerType,
            onFormSubmit: (data) =>
                _handleServiceSubmission(context, data, formKey),
            onLoadingStateChanged: () {},
          ),
        ),
      );
    } else if (userTypeId == 5) {
      partnerType = 'trip';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DynamicServiceForm(
            key: formKey,
            partnerType: partnerType,
            onFormSubmit: (data) =>
                _handleServiceSubmission(context, data, formKey),
            onLoadingStateChanged: () {},
          ),
        ),
      );
    } else if (userTypeId == 6) {
      partnerType = 'product';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DynamicServiceForm(
            key: formKey,
            partnerType: partnerType,
            onFormSubmit: (data) =>
                _handleServiceSubmission(context, data, formKey),
            onLoadingStateChanged: () {},
          ),
        ),
      );
    } else if (userTypeId == 3) {
      partnerType = 'addAccommodation';
      Navigator.pushNamed(context, "addAccommodation");
    }
  }

  void _handleServiceSubmission(BuildContext context, Map<String, dynamic> data,
      GlobalKey<DynamicServiceFormState> formKey) async {
    try {
      final serviceType = data['partner_type'] ?? 'accommodation';
      final cubit = context.read<ServiceSubmissionCubit>();
      await cubit.submitService(serviceType, data);
    } catch (e) {
      formKey.currentState?.resetLoadingState();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline_rounded, color: Colors.white),
              SizedBox(width: 12),
              Expanded(child: Text('Failed to add service. Please try again.')),
            ],
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          margin: EdgeInsets.all(16.w),
        ),
      );
    }
  }
}

class _SearchAndStatusHeader extends StatefulWidget {
  @override
  State<_SearchAndStatusHeader> createState() => _SearchAndStatusHeaderState();
}

class _SearchAndStatusHeaderState extends State<_SearchAndStatusHeader> {
  final TextEditingController _search = TextEditingController();
  int? _status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFFE8EAED), width: 1.5),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: Colors.grey[500], size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _search,
              decoration: InputDecoration(
                hintText: 'Search services...',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              onChanged: (_) => _notify(),
            ),
          ),
        ],
      ),
    );
  }

  void _notify() {
    context.read<PartnerServicesCubit>().loadForCurrentUser(
          query: _search.text.trim(),
          status: _status,
        );
  }
}

class _PartnerServicesBlocList extends StatelessWidget {
  const _PartnerServicesBlocList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartnerServicesCubit, PartnerServicesState>(
      builder: (context, state) {
        if (state is PartnerServicesLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: appTextColor),
                SizedBox(height: 16.h),
                Text(
                  'Loading services...',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          );
        }

        if (state is PartnerServicesError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: Colors.red,
                      size: 40.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Oops! Something went wrong',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: appTextColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton.icon(
                    onPressed: () => context
                        .read<PartnerServicesCubit>()
                        .loadForCurrentUser(),
                    icon: Icon(Icons.refresh_rounded),
                    label: Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appTextColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is PartnerServicesLoaded) {
          final items = state.items;

          if (items.isEmpty) {
            final isAccommodation =
                state.type == PartnerServiceType.accommodation;
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        color: appTextColor.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.business_rounded,
                        size: 60.sp,
                        color: appTextColor.withValues(alpha: 0.5),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      isAccommodation ? 'No services yet' : 'No services found',
                      style: TextStyle(
                        color: appTextColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      isAccommodation
                          ? 'Tap the + button below to add your first service'
                          : 'Try adjusting your search or add a new service',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    OutlinedButton.icon(
                      onPressed: () => context
                          .read<PartnerServicesCubit>()
                          .loadForCurrentUser(query: ''),
                      icon: Icon(Icons.refresh_rounded),
                      label: Text('Refresh'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: appTextColor,
                        side: BorderSide(color: appTextColor),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final item = items[index];
              return ServiceCard(
                title: (item.title ?? item.name) ?? 'No Title',
                location: item.location,
                price: item.priceText.toString(),
                rating: item.rating,
                imageUrl: item.imageUrl.isEmpty
                    ? 'assets/images/traveller/accomodtion.png'
                    : item.imageUrl,
                status: item.status,
                onTap: () {
                  if (state.type == PartnerServiceType.accommodation) {
                    final cubit = context.read<ServiceSubmissionCubit>();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (newContext) => BlocProvider.value(
                          value: cubit,
                          child: DetailsServices(),
                        ),
                        settings: RouteSettings(arguments: item.id),
                      ),
                    );
                  } else if (state.type == PartnerServiceType.activity) {
                    Navigator.pushNamed(context, 'activitiesDetails',
                        arguments: item.id);
                  } else if (state.type == PartnerServiceType.product) {
                    Navigator.pushNamed(
                      context,
                      'productDetails1',
                      arguments: item.id,
                    );
                  } else {
                    Navigator.pushNamed(context, 'partnerTripDetails',
                        arguments: item);
                  }
                },
                onEdit: () {},
                onDelete: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Delete not implemented'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  );
                },
              );
            },
          );
        }

        return Center(
          child: Text(
            'No data',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14.sp,
            ),
          ),
        );
      },
    );
  }
}
