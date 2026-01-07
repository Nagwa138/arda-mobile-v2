import 'dart:convert';

import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
        notificationList =
            List<Map<String, dynamic>>.from(json.decode(storedNotifications));

        // Add the `isOpened` property to each notification if not present
        notificationList = notificationList
            .map((notification) {
              if (!notification.containsKey('isOpened')) {
                notification['isOpened'] = false; // Initialize as not opened
              }
              return notification;
            })
            .toList()
            .reversed
            .toList();

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
        (match) =>
            match.group(0)!.substring(0, 1).toUpperCase() +
            match.group(0)!.substring(1).toLowerCase());

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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/images/landingHome/notificationEmpty.png"),
                          ],
                        ),
                        SizedBox(height: 10.h),
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
                        onTap: () async {
                          var userType = await storage.read(key: "userType");

                          print("user type is $userType");
                          if (notification['data']['ServiceName'] ==
                                  'CompanyTrip' &&
                              userType == "0") {
                            Navigator.pushNamed(context, "detailsTrips",
                                arguments: {
                                  'id': notification['data']['Id'],
                                  'text': "trips",
                                });
                          } else if (notification['data']['ServiceName'] ==
                                  'Activite' &&
                              userType == "0") {
                            Navigator.pushNamed(context, "activitiesDetails",
                                arguments: {
                                  'activityId': notification['data']['Id'],
                                  "text": "activity"
                                });
                          } else if (notification['data']['ServiceName'] ==
                                  'Accomodation' &&
                              userType == "0") {
                            Navigator.pushNamed(context, "roomInfo",
                                arguments: {
                                  'id': notification['data']['Id'],
                                  "text": "Accomandation"
                                });
                          } else if (notification['data']['ServiceName'] ==
                                  'Order' &&
                              userType == "0") {
                            Navigator.pushNamed(context, "orders",
                                arguments: {'id': notification['data']['Id']});
                          } else if (notification['data']['ServiceName'] ==
                                  'Blog' &&
                              userType == "0") {
                            Navigator.pushNamed(context, "storyInfo",
                                arguments: {'id': notification['data']['Id']});
                          } else if (notification['data']['ServiceName'] ==
                                  'Booking Trip' &&
                              userType == "0") {
                            Navigator.pushNamed(context, "bookingDetailsTrips",
                                arguments: {
                                  'pendingId': notification['data']['Id'],
                                  'state': "Upcoming"
                                });
                          } else if (notification['data']['ServiceName'] ==
                                  'Booking Room' &&
                              userType == "0") {
                            Navigator.pushNamed(
                                context, "detailsBookingUpComing",
                                arguments: {
                                  'upComingId': notification['data']['Id'],
                                });
                          } else if (notification['data']['ServiceName'] ==
                                  'Booking Activity' &&
                              userType == "0") {
                            Navigator.pushNamed(
                                context, "detailsBookingActivity", arguments: {
                              'pendingId': notification['data']['Id'],
                              'state': "Upcoming"
                            });
                          }

                          /// partner
                          else if (notification['data']['ServiceName'] ==
                                  'Booking Room' &&
                              userType == "1") {
                            Navigator.pushNamed(context, "profilePartner",
                                arguments: {'id': notification['data']['Id']});
                          }

                          _markAsOpened(
                              index); // Mark the notification as opened
                        },
                        child: ListTile(
                          leading: Icon(Icons.notifications,
                              color: isOpened ? Colors.grey : Colors.orange),
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
                                  notification['data']['ServiceName'] == null
                                      ? Text(
                                          'No',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )
                                      : Text(
                                          notification['data']['ServiceName'] ==
                                                  ''
                                              ? ''
                                              : notification['data']
                                                  ['ServiceName'],
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                  notification['data']['DateTime'] == null
                                      ? Text(
                                          'No',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )
                                      : Text(
                                          notification['data']['DateTime'],
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
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
        ],
      ),
    );
  }
}
