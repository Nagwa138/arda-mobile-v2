import 'package:PassPort/version2_module/features/home/view/widget/unique_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../components/color/color.dart';

class UniqueStaysListPage extends StatelessWidget {
  final List stays;

  const UniqueStaysListPage({
    super.key,
    required this.stays,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: lightBrown,
                size: 24.sp,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Unique Stays',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: lightBrown,
              ),
            ),
          ),
          body: SafeArea(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              physics: const BouncingScrollPhysics(),
              itemCount: stays.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: UniqueCard(
                    accommodation: stays[index],
                    onTap: () {
                      Navigator.pushNamed(context, 'roomInfo', arguments: {
                        'id': stays[index].accomodationId,
                        'price': stays[index].price.toString(),
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
