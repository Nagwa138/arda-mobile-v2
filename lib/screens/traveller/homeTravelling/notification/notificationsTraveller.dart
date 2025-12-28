//
//
// import 'dart:convert'; // For JSON encoding and decoding
// import 'package:PassPort/components/widgets/customText.dart';
// import 'package:PassPort/main.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Adjust based on your storage package
// import 'package:PassPort/components/color/color.dart';
//
// class TravellerNotification extends StatefulWidget {
//   const TravellerNotification({Key? key}) : super(key: key);
//
//   @override
//   _TravellerNotificationState createState() => _TravellerNotificationState();
// }
//
// class _TravellerNotificationState extends State<TravellerNotification> {
//   final storage = FlutterSecureStorage(); // Replace with your storage instance
//   List<RemoteMessage> cards = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadNotifications();
//   }
//
//   Future<void> _loadNotifications() async {
//     // Read the JSON string from local storage
//     String? jsonString = await storage.read(key: 'notificationList');
//
//     if (jsonString != null) {
//       // Convert JSON string to list of maps
//       List<dynamic> jsonList = jsonDecode(jsonString);
//
//       // Convert list of maps to list of RemoteMessage objects
//       setState(() {
//         cards = jsonList.map((json) => RemoteMessage.fromMap(json)).toList().reversed.toList();
//       });
//     }
//   }
//
//   Future<void> removeNotification(int index) async {
//     // Remove the notification from the list
//     setState(() {
//       cards.removeAt(index);
//     });
//
//     // Update the local storage with the new list
//     List<Map<String, dynamic>> updatedList = cards.map((notification) => notification.toMap()).toList();
//     await storage.write(key: 'notificationList', value: jsonEncode(updatedList));
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Change the value of isUserNotification when the page is popped
//         isUserNotification.value = true;
//         return true; // Return true to allow the pop
//       },
//       child: Scaffold(
//         backgroundColor: white,
//
//         appBar: AppBar(
//           backgroundColor: white,
//           elevation: 0.0,
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           title: Text(
//             "Notification",
//             style: TextStyle(
//               color: black,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         body: cards.isEmpty
//             ? Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10.w),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset("assets/images/landingHome/notificationEmpty.png"),
//               Text(
//                 textAlign: TextAlign.center,
//                 "homeLanding.notificationEmpty".tr(),
//                 style: TextStyle(
//                   color: black,
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//         )
//             : ListView.builder(
//           itemCount: cards.length,
//
//           itemBuilder: (context, index) {
//             return ListTile(
//               contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//               leading: Icon(Icons.notifications,color: Colors.orange,),
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//
//                 children: [
//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: '${cards[index].notification?.title}\n ',
//                           style: TextStyle(
//                             color: black,
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         TextSpan(
//                           text: '${cards[index].notification?.body}',
//                           style: TextStyle(
//                             color: black,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 5.h,),
//                   Container(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                        ' ${DateFormat('hh:mm a, dd MMM yyyy').format(cards[index].sentTime!)}',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               trailing: GestureDetector(
//                   onTap: (){
//                     removeNotification(index);
//                   },
//                   child: Icon(Icons.delete,)),
//
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// // Assuming you have a method to convert RemoteMessage to a Map
// extension RemoteMessageExtension on RemoteMessage {
//   // Method to convert from Map
//   static RemoteMessage fromMap(Map<String, dynamic> map) {
//     return RemoteMessage(
//       messageId: map['messageId'],
//       notification: RemoteNotification.fromMap(map['notification']),
//       data: Map<String, dynamic>.from(map['data']),
//       from: map['from'],
//       sentTime: DateTime.parse(map['sentTime']),
//     );
//   }
// }
//
// extension RemoteNotificationExtension on RemoteNotification {
//   // Method to convert from Map
//   static RemoteNotification fromMap(Map<String, dynamic> map) {
//     return RemoteNotification(
//       title: map['title'],
//       body: map['body'],
//     );
//   }
// }

///
///
///
///
///
///
///
///
// import 'dart:convert';
// import 'package:PassPort/components/color/color.dart';
// import 'package:PassPort/main.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // Import the intl package
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class TravellerNotification extends StatefulWidget {
//   @override
//   _TravellerNotificationState createState() => _TravellerNotificationState();
// }
//
// class _TravellerNotificationState extends State<TravellerNotification> {
//   final storage = FlutterSecureStorage();
//   List<Map<String, dynamic>> notificationList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadNotifications();
//   }
//
//
//
//   Future<void> _loadNotifications() async {
//     // Load the notification list from local storage
//     String? storedNotifications = await storage.read(key: 'notificationList');
//     if (storedNotifications != null) {
//       setState(() {
//         notificationList = List<Map<String, dynamic>>.from(json.decode(storedNotifications));
//
//         // Sort the list in descending order based on the 'DateTime' key in the 'data' map
//         notificationList.sort((a, b) {
//           DateTime dateA = _parseCustomDate(a['data']['DateTime']);
//           DateTime dateB = _parseCustomDate(b['data']['DateTime']);
//           return dateB.compareTo(dateA);
//         });
//       });
//     }
//   }
//
//   DateTime _parseCustomDate(String dateString) {
//     // Convert the month abbreviation to the correct format (capitalize the first letter)
//     dateString = dateString.replaceAllMapped(
//         RegExp(r'\b([A-Z]{3})\b'),
//             (match) => match.group(0)!.substring(0, 1).toUpperCase() + match.group(0)!.substring(1).toLowerCase()
//     );
//
//     // Define the date format based on the expected date string
//     DateFormat dateFormat = DateFormat('dd MMM yyyy hh:mm a');
//     return dateFormat.parse(dateString);
//   }
//
//
//
//   Future<void> _removeNotification(int index) async {
//     // Remove the notification from the list
//     setState(() {
//       notificationList.removeAt(index);
//     });
//
//     // Update the local storage with the new list
//     await storage.write(
//         key: 'notificationList', value: jsonEncode(notificationList));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Change the value of isUserNotification when the page is popped
//         isUserNotification.value = true;
//         return true; // Re
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Notifications'),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//         ),
//         body: notificationList.isEmpty
//             ? Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                         "assets/images/landingHome/notificationEmpty.png"),
//                     Text(
//                       textAlign: TextAlign.center,
//                       "homeLanding.notificationEmpty".tr(),
//                       style: TextStyle(
//                         color: black,
//                         fontSize: 24.sp,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : ListView.builder(
//                 itemCount: notificationList.length,
//                 itemBuilder: (context, index) {
//                   var notification = notificationList[index];
//                   return GestureDetector(
//                     onTap: (){
//                       if(notification['data']['ServiceName'] == 'CompanyTrip'){
//                         Navigator.pushNamed(context, "detailsTrips",arguments: {
//                           'id' : notification['data']['Id'],
//                           'text' :"trips",
//                         });
//                       }
//
//                       else if(notification['data']['ServiceName'] == 'Activite'){
//                         Navigator.pushNamed(context, "activitiesDetails",arguments: {
//                           'activityId' : notification['data']['Id'],
//                           "text" :"activity"
//                         });
//                       }
//
//                       else if (notification['data']['ServiceName'] == 'Accomodation'){
//                         Navigator.pushNamed(context, "roomInfo",arguments: {
//                           'id' : notification['data']['Id'],
//                           "text" :"Accomandation"
//                         });
//                       }
//
//
//                     },
//                     child: ListTile(
//                       leading: Icon(Icons.notifications, color: Colors.orange),
//                       title: Text(
//                         notification['title'] ?? "No Title",
//                         style: TextStyle(
//                           color: black,
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             notification['body'] ?? "No Body",
//                             style: TextStyle(
//                               color: black,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Container(
//                             alignment: Alignment.centerRight,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   notification['data']['ServiceName'] == '' ? '' :notification['data']['ServiceName'] ,
//                                   // Display a default message if sentTime is null
//                                   style: TextStyle(color: Colors.grey, fontSize: 12),
//                                 ),
//
//                                 Text(
//                                   notification['data']['DateTime'],
//                                   // Display a default message if sentTime is null
//                                   style: TextStyle(color: Colors.grey, fontSize: 12),
//                                 ),
//
//
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           //Text(notification['data'] ?? "No Body",style: TextStyle(color: black),),
//                         ],
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete),
//                          onPressed: () => _removeNotification(index),
//                         // onPressed: () {
//                         //   print("data ${notification['data']['DateTime']}");
//                         // },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TravellerNotification extends StatefulWidget {
  @override
  _TravellerNotificationState createState() => _TravellerNotificationState();
}

class _TravellerNotificationState extends State<TravellerNotification> {
  final storage = FlutterSecureStorage();
  List<Map<String, dynamic>> notificationList = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    // Load the notification list from local storage
    String? storedNotifications = await storage.read(key: 'notificationList');
    if (storedNotifications != null) {
      setState(() {
        notificationList = List<Map<String, dynamic>>.from(json.decode(storedNotifications));

        // Add the `isOpened` property to each notification if not present
        notificationList = notificationList.map((notification) {
          if (!notification.containsKey('isOpened')) {
            notification['isOpened'] = false; // Initialize as not opened
          }
          return notification;
        }).toList().reversed.toList();

        // Sort the list in descending order based on the 'DateTime' key in the 'data' map
        // notificationList.sort((a, b) {
        //   DateTime dateA = _parseCustomDate(a['data']['DateTime']);
        //   DateTime dateB = _parseCustomDate(b['data']['DateTime']);
        //   return dateB.compareTo(dateA);
        // });
      });
    }
  }

  DateTime _parseCustomDate(String dateString) {
    // Convert the month abbreviation to the correct format (capitalize the first letter)
    dateString = dateString.replaceAllMapped(
        RegExp(r'\b([A-Z]{3})\b'),
            (match) => match.group(0)!.substring(0, 1).toUpperCase() + match.group(0)!.substring(1).toLowerCase()
    );

    // Define the date format based on the expected date string
    DateFormat dateFormat = DateFormat('dd MMM yyyy hh:mm a');
    return dateFormat.parse(dateString);
  }

  Future<void> _removeNotification(int index) async {
    // Remove the notification from the list
    setState(() {
      notificationList.removeAt(index);
    });

    // Update the local storage with the new list
    await storage.write(
        key: 'notificationList', value: jsonEncode(notificationList));
  }

  Future<void> _markAsOpened(int index) async {
    // Mark the notification as opened
    setState(() {
      notificationList[index]['isOpened'] = true;
    });

    // Update the local storage with the modified list
    await storage.write(
        key: 'notificationList', value: jsonEncode(notificationList));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Change the value of isUserNotification when the page is popped
        isUserNotification.value = true;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: notificationList.isEmpty
            ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/landingHome/notificationEmpty.png"),
              Text(
                "homeLanding.notificationEmpty".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          itemCount: notificationList.length,
          itemBuilder: (context, index) {
            var notification = notificationList[index];
            bool isOpened = notification['isOpened'];

            return GestureDetector(
              onTap: ()async {
               var userType = await storage.read(key: "userType");

               print("user type is $userType");
                if (notification['data']['ServiceName'] == 'CompanyTrip' && userType == "0") {
                  Navigator.pushNamed(context, "detailsTrips", arguments: {
                    'id': notification['data']['Id'],
                    'text': "trips",
                  });
                }

                else if (notification['data']['ServiceName'] == 'Activite' && userType == "0") {
                  Navigator.pushNamed(context, "activitiesDetails", arguments: {
                    'activityId': notification['data']['Id'],
                    "text": "activity"
                  });
                }

                else if (notification['data']['ServiceName'] == 'Accomodation' && userType == "0") {
                  Navigator.pushNamed(context, "roomInfo", arguments: {
                    'id': notification['data']['Id'],
                    "text": "Accomandation"
                  });
                }

                else if (notification['data']['ServiceName'] == 'Order' && userType == "0"){
                  Navigator.pushNamed(context, "orders",arguments: {
                    'id' : notification['data']['Id']
                  });
                }

                else if (notification['data']['ServiceName'] == 'Blog' && userType == "0"){
                  Navigator.pushNamed(context, "storyInfo",arguments: {
                    'id' : notification['data']['Id']
                  });
                }

                else if (notification['data']['ServiceName'] == 'Booking Trip' && userType == "0"){
                  Navigator.pushNamed(context, "bookingDetailsTrips",arguments: {
                    'pendingId' : notification['data']['Id'],
                    'state' : "Upcoming"
                  });
                }

                else if (notification['data']['ServiceName'] == 'Booking Room' && userType == "0"){
                  Navigator.pushNamed(context, "detailsBookingUpComing",arguments: {
                    'upComingId' : notification['data']['Id'],
                  });
                }

                else if (notification['data']['ServiceName'] == 'Booking Activity' && userType == "0") {
                  Navigator.pushNamed(context, "detailsBookingActivity",arguments: {
                    'pendingId' : notification['data']['Id'],
                    'state' : "Upcoming"
                  });
                }

                /// partner
                else if (notification['data']['ServiceName'] == 'Booking Room' && userType == "1"){
                  Navigator.pushNamed(context, "profilePartner",arguments: {
                    'id' : notification['data']['Id']
                  });
                }

                _markAsOpened(index); // Mark the notification as opened
              },
              child: ListTile(
                leading: Icon(Icons.notifications, color: isOpened ? Colors.grey : Colors.orange),
                title: Text(
                  notification['title'] ?? "No Title",
                  style: TextStyle(
                    color: black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification['body'] ?? "No Body",
                      style: TextStyle(
                        color: black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        notification['data']['ServiceName'] == null ?  Text(
                       'No',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ) :
                        Text(
                          notification['data']['ServiceName'] == '' ? '' : notification['data']['ServiceName'],
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),

                        notification['data']['DateTime'] == null ?Text(
                         'No',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )  :
                        Text(
                          notification['data']['DateTime'],
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeNotification(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
