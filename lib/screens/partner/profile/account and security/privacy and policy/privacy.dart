import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'accountSecurity.privacy'.tr(),
          style: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF233A6A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/ard_logo.png",
                    height: 80.h,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // English Version
            Text(
              'Privacy Policy (English)',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
            SizedBox(height: 16.h),

            _buildText(
                'The platform complies with Egyptian Personal Data Protection Law No. 151 of 2020.\n\n'
                'Collected data includes: name, email, phone number, payment details, and optional location data.\n\n'
                'Data is used solely for booking, payment processing, and improving user experience.\n\n'
                'No data will be sold or shared with third parties, except as necessary to deliver the service (e.g., to the partner).\n\n'
                'Users have the right to request modification or deletion of their data.\n\n'
                'The platform applies technical and organizational measures to protect data against unauthorized access.'),

            SizedBox(height: 32.h),

            // Arabic Version
            Text(
              'سياسة الخصوصية (العربية)',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
            SizedBox(height: 16.h),

            _buildArabicText(
                'تلتزم المنصة بجمع ومعالجة بيانات المستخدمين بما يتوافق مع قانون حماية البيانات الشخصية المصري رقم 151 لسنة 2020.\n\n'
                'البيانات التي يتم جمعها: الاسم – البريد الإلكتروني – رقم الهاتف – بيانات الدفع – الموقع (إذا تم تفعيله).\n\n'
                'يتم استخدام البيانات حصريًا لأغراض الحجز، الدفع، وتحسين تجربة المستخدم.\n\n'
                'لا يتم بيع أو مشاركة البيانات مع أي طرف ثالث إلا بقدر ما يلزم لتنفيذ الخدمة (مثل مقدم الخدمة).\n\n'
                'للمستخدم الحق في طلب تعديل أو حذف بياناته عبر التواصل مع الدعم.\n\n'
                'المنصة تتخذ جميع التدابير التقنية لحماية البيانات من الوصول غير المصرح به.'),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          color: accentColor,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildArabicText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          color: accentColor,
          height: 1.5,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}
