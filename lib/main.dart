import 'dart:io';

import 'package:PassPort/consts/cache%20manger/cache.dart';
import 'package:PassPort/screens/splash/splash.dart';
import 'package:PassPort/services/cubit/cubitobserve.dart';
import 'package:PassPort/services/notification/notificationLogic.dart';
import 'package:PassPort/services/ssl/ssl.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'consts/routes/route.dart' as route;

var token;
var userType;
ValueNotifier<bool> isUserNotification = ValueNotifier<bool>(true);

// Define app theme colors
const Color appBackgroundColor = Color(0xFFFBF0E3);
const Color appTextColor = Color(0xFF161651);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = new FlutterSecureStorage();
  token = await storage.read(key: "token");
  print(" token of person is \n ${token}");
  userType = await storage.read(key: "userType");
  print(" user Type is \n $userType");
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await FirebaseNotification().initNotification();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  await Hive.openBox('cardsBox');
  await Hive.openBox('cardsRoom');
  Bloc.observer = MyBlocObserver();

  await CacheManger.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode && false,
      builder: (context) => EasyLocalization(
        supportedLocales: [
          Locale('en'),
          //Locale('ar'),
        ],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MyApp(),
      ),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          title: 'THE ARD',
          theme: ThemeData(
            scaffoldBackgroundColor: appBackgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: appBackgroundColor,
              surfaceTintColor: appBackgroundColor,
              foregroundColor: appTextColor,
              elevation: 0,
            ),
            primarySwatch: createMaterialColor(appTextColor),
            colorScheme: ColorScheme.fromSeed(
              seedColor: appTextColor,
              primary: appTextColor,
              background: appBackgroundColor,
              surface: appBackgroundColor,
            ),
            cardColor: appBackgroundColor,
            primaryColor: appTextColor,
            fontFamily: 'Times',
            textTheme: TextTheme(
              displayLarge: TextStyle(fontFamily: 'Times', color: appTextColor),
              displayMedium:
                  TextStyle(fontFamily: 'Times', color: appTextColor),
              displaySmall: TextStyle(fontFamily: 'Times', color: appTextColor),
              headlineLarge:
                  TextStyle(fontFamily: 'Times', color: appTextColor),
              headlineMedium:
                  TextStyle(fontFamily: 'Times', color: appTextColor),
              headlineSmall:
                  TextStyle(fontFamily: 'Times', color: appTextColor),
              titleLarge: TextStyle(fontFamily: 'Times', color: appTextColor),
              titleMedium: TextStyle(fontFamily: 'Times', color: appTextColor),
              titleSmall: TextStyle(fontFamily: 'Times', color: appTextColor),
              bodyLarge: TextStyle(fontFamily: 'Times', color: appTextColor),
              bodyMedium: TextStyle(fontFamily: 'Times', color: appTextColor),
              bodySmall: TextStyle(fontFamily: 'Times', color: appTextColor),
              labelLarge: TextStyle(fontFamily: 'Times', color: appTextColor),
              labelMedium: TextStyle(fontFamily: 'Times', color: appTextColor),
              labelSmall: TextStyle(fontFamily: 'Times', color: appTextColor),
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: appTextColor,
              textTheme: ButtonTextTheme.primary,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: appTextColor,
                foregroundColor: appBackgroundColor,
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: appTextColor,
              ),
            ),
            iconTheme: IconThemeData(
              color: appTextColor,
            ),
            dialogTheme: DialogThemeData(backgroundColor: appBackgroundColor),
          ),
          //home: OnBoarding(),
          home: Splash(),
          onGenerateRoute: route.controller,
          //initialRoute: route.splash,
        );
      },
    );
  }
}

// Helper function to create MaterialColor from a single color
MaterialColor createMaterialColor(Color color) {
  List<double> strengths = <double>[.05, .1, .2, .3, .4, .5, .6, .7, .8, .9];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
