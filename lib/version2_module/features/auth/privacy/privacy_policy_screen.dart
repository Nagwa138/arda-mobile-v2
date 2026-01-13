import 'package:PassPort/version2_module/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
        ),
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // English Version
                Text(
                  'Privacy Policy (English)',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF233A6A),
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
                    color: Color(0xFF233A6A),
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
          // Watermark logo
          Center(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/logo.png',
                width: 200.w,
                height: 200.h,
                color: Colors.black,
              ),
            ),
          ),
        ],
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
          color: Colors.black87,
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
          color: Colors.black87,
          height: 1.5,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
