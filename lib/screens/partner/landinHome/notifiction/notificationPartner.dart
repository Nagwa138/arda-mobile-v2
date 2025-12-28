// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:PassPort/components/color/color.dart';
//
// class NotificationLanding extends StatelessWidget {
//   const NotificationLanding({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     bool notificationEmpty = true;
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             "homeLanding.notification".tr(),
//             style: TextStyle(
//               color: black,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         body: notificationEmpty
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset("assets/images/landingHome/notificationEmpty.png"),
//                     Text(
//                       textAlign: TextAlign.center,
//                       "homeLanding.notificationEmpty".tr(),
//                       style: TextStyle(
//                         color: const Color.fromRGBO(21, 11, 61, 1),
//                         fontSize: 24.sp,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             : ListView.separated(
//                 itemBuilder: (context, index) => Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.w),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Color.fromRGBO(178, 187, 198, 1)), borderRadius: BorderRadiusDirectional.circular(20.r)),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 15.w),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "homeLanding.notificationReview".tr(),
//                                 style: TextStyle(
//                                   color: black,
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "homeLanding.day".tr() + " | ",
//                                     style: TextStyle(
//                                       color: black,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                   Text(
//                                     "09:56 صباحا",
//                                     style: TextStyle(
//                                       color: black,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10.h,
//                               ),
//                               Text(
//                                 "homeLanding.contentNotification".tr(),
//                                 style: TextStyle(
//                                   color: black,
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                 separatorBuilder: (context, index) => SizedBox(
//                       height: 10.h,
//                     ),
//                 itemCount: 5));
//   }
// }
// // ignore_for_file: dead_code
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:PassPort/components/color/color.dart';
// import 'package:PassPort/services/notification/notificationLogic.dart';
//
//
// class TravellerNotification extends StatelessWidget {
//  //final List<RemoteMessage> list;
//    TravellerNotification({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     final List<RemoteMessage> cards = ModalRoute.of(context)!.settings.arguments as List<RemoteMessage>;
//
//     FirebaseNotification notification = FirebaseNotification();
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Notification",
//           style: TextStyle(
//             color: black,
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: false
//           ? Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset("assets/images/landingHome/notificationEmpty.png"),
//                   Text(
//                     textAlign: TextAlign.center,
//                     "homeLanding.notificationEmpty".tr(),
//                     style: TextStyle(
//                       color: black,
//                       fontSize: 24.sp,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   )
//                 ],
//               ),
//             )
//           :
//       ListView.builder(
//               itemCount: cards.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                     contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//                     leading: Image.asset('assets/images/landingHome/male.png'),
//                     title: Text.rich(
//                       TextSpan(
//                         children: [
//                           TextSpan(
//                             text: '${cards[index].notification?.title}\n ',
//                             style: TextStyle(
//                               color: orange,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           TextSpan(
//                             text: '${cards[index].notification?.body}',
//                             style: TextStyle(
//                               color: black,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ));
//               },
//             ),
//     );
//   }
// }

import 'dart:convert'; // For JSON encoding and decoding
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Adjust based on your storage package
import 'package:PassPort/components/color/color.dart';

class NotificationLandingPartner extends StatefulWidget {
  const NotificationLandingPartner({Key? key}) : super(key: key);

  @override
  _NotificationLandingState createState() => _NotificationLandingState();
}

class _NotificationLandingState extends State<NotificationLandingPartner> {
  final storage = FlutterSecureStorage(); // Replace with your storage instance
  List<RemoteMessage> cards = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    // Read the JSON string from local storage
    String? jsonString = await storage.read(key: 'notificationList');

    if (jsonString != null) {
      // Convert JSON string to list of maps
      List<dynamic> jsonList = jsonDecode(jsonString);

      // Convert list of maps to list of RemoteMessage objects
      setState(() {
        cards = jsonList.map((json) => RemoteMessage.fromMap(json)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "NotificationPartner",
          style: TextStyle(
            color: accentColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: cards.isEmpty
          ? Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/landingHome/notificationEmpty.png"),
            Text(
              textAlign: TextAlign.center,
              "homeLanding.notificationEmpty".tr(),
              style: TextStyle(
                color: accentColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            leading: Image.asset('assets/images/landingHome/male.png'),
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${cards[index].notification?.title}\n ',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: '${cards[index].notification?.body}',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Assuming you have a method to convert RemoteMessage to a Map
extension RemoteMessageExtension on RemoteMessage {
  // Method to convert from Map
  static RemoteMessage fromMap(Map<String, dynamic> map) {
    return RemoteMessage(
      messageId: map['messageId'],
      notification: RemoteNotification.fromMap(map['notification']),
      data: Map<String, dynamic>.from(map['data']),
      from: map['from'],
      sentTime: DateTime.parse(map['sentTime']),
    );
  }
}

extension RemoteNotificationExtension on RemoteNotification {
  // Method to convert from Map
  static RemoteNotification fromMap(Map<String, dynamic> map) {
    return RemoteNotification(
      title: map['title'],
      body: map['body'],
    );
  }
}
