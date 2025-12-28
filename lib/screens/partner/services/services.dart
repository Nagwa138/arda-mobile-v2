// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:PassPort/components/color/color.dart';
// import 'package:PassPort/services/partner/servicesCubit/servicesCubit.dart';
// import 'package:PassPort/services/partner/servicesCubit/servicesStates.dart';

// import 'allServices/allservices.dart';

// class ServicesLanding extends StatelessWidget {
//   ServicesLanding({super.key});
//   PageController controllerServices = PageController();

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: BlocProvider(
//         create: (context) => ServicesCubit()..getServices(val: 0),
//         child: BlocConsumer<ServicesCubit, ServicesStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return Scaffold(
//               backgroundColor: white,
//               appBar: AppBar(
//                 backgroundColor: white,
//                 elevation: 0.0,
//                 centerTitle: true,

//                 automaticallyImplyLeading: false,

//                 title: Text(
//                   "Services.services".tr(),
//                   style: TextStyle(
//                     color: black,
//                     fontSize: 23.sp,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 bottom: TabBar(
//                   padding: EdgeInsets.zero,
//                   dividerHeight: 0,
//                   overlayColor: WidgetStateProperty.all(Colors.transparent),
//                   indicatorPadding: EdgeInsets.symmetric(horizontal: -20.w),
//                   isScrollable: true,
//                   indicatorColor: orange,
//                   indicatorSize: TabBarIndicatorSize.label,
//                   labelColor: orange,
//                   unselectedLabelColor: black,
//                   labelStyle: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16.sp,
//                   ),
//                   indicator: BoxDecoration(
//                     borderRadius: BorderRadius.circular(26.r),
//                     border: Border.all(color: orange),
//                     color: Colors.transparent,
//                   ),
//                   onTap: (value) {
//                     context.read<ServicesCubit>().getServices(val: value);
//                   },
//                   tabs: [
//                     'Services.all'.tr(),
//                     'Services.confirm'.tr(),
//                     'Services.reject'.tr(),
//                     'Services.accept'.tr(),
//                   ]
//                       .map(
//                         (e) => Container(
//                           // width: 100.w,
//                           padding: EdgeInsets.symmetric(horizontal: 10.w),
//                           child: Tab(
//                             text: e,
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//               body: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20.w),
//                 child: state is ServicesLoading
//                     ? Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : state is ServicesError
//                         ? Center(
//                             child: Text(state.error),
//                           )
//                         : ListView.separated(
//                             // physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemBuilder: (context, index) {
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.pushNamed(
//                                         context,
//                                         "detailsServices",
//                                         arguments: context.read<ServicesCubit>().servicesModel!.data[index],

//                                       );
//                                       // Navigator.pushNamed(
//                                       //   context,
//                                       //   "detailsServices",
//                                       //   arguments: {
//                                       //     "id" : context.read<ServicesCubit>().servicesModel!.data[index].id
//                                       //   },
//                                       // );
//                                     },
//                                     child: Center(
//                                       child: Container(
//                                         width: 327.w,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadiusDirectional.circular(25.r),
//                                         ),
//                                         child: Stack(
//                                           alignment: Alignment.topRight,
//                                           children: [
//                                             Image.network(
//                                               context.read<ServicesCubit>().servicesModel!.data[index].coverPhotoUrl!,
//                                               width: 327.w,
//                                               fit: BoxFit.fill,
//                                               loadingBuilder: (context, child, loadingProgress) {
//                                                 if (loadingProgress == null) {
//                                                   return child; // Image has finished loading
//                                                 }
//                                                 return Center(
//                                                   child: CircularProgressIndicator(
//                                                     value: loadingProgress.expectedTotalBytes != null
//                                                         ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
//                                                         : null, // Show progress if available
//                                                   ),
//                                                 );
//                                               },
//                                               errorBuilder: (context, error, stackTrace) => Icon(
//                                                 Icons.error,
//                                                 color: Colors.red,
//                                               ),
//                                             ),

//                                             Padding(
//                                               padding: EdgeInsets.only(top: 20.h, right: 10.w),
//                                               child: Container(
//                                                 width: 115.w,
//                                                 height: 41.h,
//                                                 decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(24.r), color: white),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                   children: [
//                                                     Icon(
//                                                       Icons.circle,
//                                                       size: 10.sp,
//                                                       color: orange,
//                                                     ),
//                                                     SizedBox(
//                                                       width: 5.w,
//                                                     ),
//                                                     Text(
//                                                         context.read<ServicesCubit>().servicesModel!.data[index].status!,
//                                                       style: TextStyle(color: black, fontSize: 14.sp, fontWeight: FontWeight.w700),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10.h,
//                                   ),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(horizontal: 25.w),
//                                         child: Text(
//                                           context.read<ServicesCubit>().servicesModel!.data![index].accomodationType!,
//                                           textAlign: TextAlign.start,
//                                           style: TextStyle(color: black, fontSize: 18.sp, fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 15.h,
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(horizontal: 25.w),
//                                         child: Text(
//                                           context.read<ServicesCubit>().servicesModel!.data![index].serviceName!,
//                                           style: TextStyle(color: orange, fontSize: 18.sp, fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               );
//                             },
//                             separatorBuilder: (context, index) => Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 25.w),
//                               child: Divider(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             itemCount: context.read<ServicesCubit>().servicesModel!.data!.length,
//                           ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
