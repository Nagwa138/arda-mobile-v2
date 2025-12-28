import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/main.dart';

class FirebaseNotification {
  final storage = FlutterSecureStorage();
  final firebaseMessaging = FirebaseMessaging.instance;

  List<Map<String, dynamic>> notificationList =
      []; // Use a map to store specific notification data

  Future<void> initNotification() async {
    var tokenFireBase;
    await firebaseMessaging.requestPermission();

    String? newToken = '';
    int retryCount = 0;
    const int maxRetries = 3;
    while (retryCount < maxRetries) {
      try {
        newToken = await firebaseMessaging.getToken();
        if (newToken != null) {
          sendTokenToServer(newToken);
          tokenFireBase = newToken;
        } else {
          print("Failed to get FCM token. Token is null.");
        }
        break; // Success, exit loop
      } catch (e) {
        retryCount++;
        print("Error getting FCM token (attempt $retryCount): $e");
        await Future.delayed(Duration(seconds: 2));
        if (retryCount == maxRetries) {
          print("Max retries reached. Could not get FCM token.");
        }
      }
    }

    // الاستماع لتحديثات التوكن
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      sendTokenToServer(newToken);
      tokenFireBase = newToken;
    });

    // التعامل مع الإشعارات أثناء تشغيل التطبيق في المقدمة
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _loadNotificationList();

      // Add the specific fields you want to store
      notificationList.add({
        'title': message.notification?.title,
        'body': message.notification?.body,
        'data': message.data,
      });

      await _storeNotificationList();
      print("Notification count: ${notificationList.length}");

      if (message.notification != null) {
        isUserNotification.value = false;
        // Handle notification UI or other actions here
      }
    });

    // التعامل مع الإشعارات عندما يكون التطبيق في الخلفية أو مغلقًا
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await _loadNotificationList();

      notificationList.add({
        'title': message.notification?.title,
        'body': message.notification?.body,
        'data': message.data,
      });

      await _storeNotificationList();
      navigatorKey.currentState!
          .pushNamed("travellerNotification", arguments: notificationList);
    });

    // التعامل مع الإشعارات عندما يتم فتح التطبيق من حالة مغلقة
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print(
          "Message received when app is terminated: ${initialMessage.notification?.title}");

      await _loadNotificationList();

      notificationList.add({
        'title': initialMessage.notification?.title,
        'body': initialMessage.notification?.body,
        'data': initialMessage.data,
      });

      await _storeNotificationList();

      //navigatorKey.currentState!.pushNamed("travellerNotification", arguments: notificationList);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState!
            .pushNamed("travellerNotification", arguments: notificationList);
      });
    }

    // تخزين FCM token في التخزين المحلي إذا لم يكن null
    if (tokenFireBase != null) {
      await storage.write(key: "tokenFireBase", value: tokenFireBase);
      print("FCM Token: $tokenFireBase");
    } else {
      print("Failed to store FCM token. Token is null.");
    }
  }

  // Loading notification list from local storage
  Future<void> _loadNotificationList() async {
    String? storedList = await storage.read(key: "notificationList");
    if (storedList != null) {
      notificationList =
          List<Map<String, dynamic>>.from(json.decode(storedList));
    }
  }

  // Storing notification list in local storage
  Future<void> _storeNotificationList() async {
    String jsonString = jsonEncode(notificationList);
    await storage.write(key: "notificationList", value: jsonString);
    print("Notification List stored.");
  }

  /// send token
  void sendTokenToServer(String newToken) async {
    var token = await storage.read(key: "token");
    var tokenFirebase = await storage.read(key: "tokenFireBase");
    try {
      final url = Uri.parse("${Api.API_URL}FireBaseToken/update-token");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'token': tokenFirebase}),
      );

      if (response.statusCode == 200) {
        print("Token sent to server successfully.");
      } else {
        print("Failed to send token to server: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending token to server: $e");
    }
  }
}
