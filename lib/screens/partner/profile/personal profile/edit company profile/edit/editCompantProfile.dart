import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

class EditCompanyProfile extends StatelessWidget {
  const EditCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'profile.companyEdit'.tr(),
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Icon(
                  CupertinoIcons.person_alt_circle_fill,
                  color: orange,
                  size: 110.sp,
                ),
                Positioned(
                  right: 10.w,
                  bottom: 15.h,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'editCompanyProfile');
                    },
                    child: CircleAvatar(
                      radius: 15.r,
                      backgroundColor: black,
                      child: Icon(
                        Icons.edit_square,
                        color: white,
                        size: 15.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          textFormFildBuilder(
            context,
            title: 'profile.companyName'.tr(),
            hint: "Al Amal Company",
            controller: TextEditingController(),
          ),
          SizedBox(
            height: 100.h,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                {
                  "image": 'assets/images/register/accommodation.png',
                  "title": 'register.services.accommodation'.tr(),
                },
                {
                  "image": 'assets/images/register/trips.png',
                  "title": 'register.services.trips'.tr(),
                },
                {
                  "image": 'assets/images/register/products.png',
                  "title": 'register.services.products'.tr(),
                },
                {
                  "image": 'assets/images/register/activities.png',
                  "title": 'register.services.activities'.tr(),
                }
              ]
                  .map(
                    (e) => Container(
                      width: 200.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            // color: context.read<PartnerRegisterCubit>().serviceSelected == index ? black : Color(0xFFEEEEEE),
                            ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      margin: EdgeInsets.only(right: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            e["image"]!,
                            height: 40.h,
                            width: 40.w,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            e["title"].toString(),
                            style: TextStyle(
                              color: black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          textFormFildBuilder(
            context,
            title: 'register.governate'.tr(),
            hint: "Cairo",
            controller: TextEditingController(),
          ),
          textFormFildBuilder(
            context,
            title: 'register.websiteLink'.tr(),
            hint: "https://maps.app.goo.g39Ex8sda....",
            controller: TextEditingController(),
          ),
          textFormFildBuilder(
            context,
            title: 'register.address'.tr(),
            hint: "https://maps.app.goo.g39Ex8sda....",
            controller: TextEditingController(),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 1.sw,
              height: 56.h,
              decoration: ShapeDecoration(
                color: orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'profile.save'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textFormFildBuilder(
    BuildContext context, {
    required String title,
    required String hint,
    required TextEditingController controller,
    bool obstructText = false,
    TextInputType inputType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          TextFormField(
            controller: controller,
            onChanged: (value) {},
            obscureText: obstructText,
            keyboardType: inputType,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),

              hintText: hint.tr(),
              hintStyle: TextStyle(
                color: Color(0xFFCECFD1),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Color(0xFFDFE2E6),
                ),
              ),
              // filled: true,
              // fillColor: Color(0xFFF5F7FA),
            ),
          ),
        ],
      ),
    );
  }
}
