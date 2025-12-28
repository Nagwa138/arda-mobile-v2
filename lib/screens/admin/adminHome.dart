import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/customText.dart';
import 'package:PassPort/main.dart';
import 'package:PassPort/services/notification/notificationLogic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/auth/splash.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),

            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, 'onBoarding');
                    },
                    child: Image.asset("assets/images/ard_logo.png"),

                  ),
                  SizedBox(
                    height: 100.h,
                  ),

                  CustomText(text: "Anti-Afrocentric#", size: 14.sp, color: white, fontWeight: FontWeight.w700)


                ],
              ),
            ),

            Positioned(
              right: 10.w,
              top: 20.w,
              child: ValueListenableBuilder<bool>(
                valueListenable: isUserNotification,
                builder: (context,value,child){
                  return IconButton(
                    onPressed: () {
                      FirebaseNotification list = FirebaseNotification();
                      Navigator.pushNamed(context, 'travellerNotification',arguments:list.notificationList );
                    },
                    icon: Icon(
                        Icons.notification_add,
                        size: 24.sp,
                        color:
                        value ?
                        white : Colors.green
                    ),
                  );
                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
