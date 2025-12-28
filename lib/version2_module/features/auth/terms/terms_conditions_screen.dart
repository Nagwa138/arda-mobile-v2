import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/version2_module/core/const/app_colors.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // English Version
            Text(
              'Terms & Conditions (English)',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF233A6A),
              ),
            ),
            SizedBox(height: 16.h),

            _buildSectionTitle('Definitions'),
            _buildText(
                '"Platform" or "Application": Refers to The Ard App, owned and operated by the registered company under Egyptian law.\n'
                '"User" or "Traveler": Any individual using the application to book services.\n'
                '"Partner" or "Service Provider": Any natural or legal person registered to provide services (accommodation, trips, activities, handmade products).\n'
                '"Services": All activities, services, and products displayed on the application.'),

            _buildSectionTitle('General Terms (Apply to All Parties)'),
            _buildNumberedList([
              'The platform acts solely as an electronic intermediary between partners and users.',
              'The platform is not liable for any agreements made outside the application.',
              'All payments must be processed exclusively through the platform.',
              'The platform retains a commission percentage from each booking.',
              'The platform reserves the right to update or amend these terms at any time.',
              'Any legal dispute shall be subject to the jurisdiction of Egyptian courts.',
              'Use of the application for illegal purposes is strictly prohibited.',
              'All data provided must be accurate and truthful.',
              'The platform has the right to suspend or delete accounts in case of violations.',
              'The platform does not guarantee service quality directly but performs pre-publishing review.',
            ]),

            _buildSectionTitle('User (Traveler) Obligations'),
            _buildNumberedList([
              'Users must pay the full service fee according to the payment policy.',
              'Users are bound by the cancellation and refund policy displayed in the app.',
              'Services must be used only for personal and tourism purposes.',
              'Reselling or transferring bookings without approval is prohibited.',
              'Users are responsible for any misuse or damages caused during service usage.',
              'Users must comply with Egyptian laws (tourism, environment, safety regulations).',
              'Users may leave reviews provided they are genuine and non-abusive.',
              'Complaints must be submitted to customer support within 48 hours.',
              'The platform is not liable for any injury, damage, or death resulting from services.',
              'Any fraudulent or unlawful activity leads to immediate account termination.',
            ], startNumber: 11),

            _buildSectionTitle('Partner (Service Provider) Obligations'),
            _buildNumberedList([
              'Partners must provide accurate and updated service details (photos, description, prices).',
              'Partners must deliver services exactly as advertised.',
              'Prices must be clear and transparent.',
              'Partners must pay the agreed commission on each booking.',
              'Partners must comply with Egyptian laws (tourism, consumer protection, taxation).',
              'Partners are required to issue tax invoices in accordance with Egyptian law.',
              'Partners may modify or cancel services only with prior notification to the platform.',
              'Repeated complaints entitle the platform to suspend the partner account.',
              'Partners must not misuse customer data outside booking purposes.',
              'Partners bear full liability for damages, losses, or accidents during service delivery.',
            ], startNumber: 21),

            _buildSectionTitle('Disclaimer for Risky Activities'),
            _buildText(
                'The user acknowledges that participation in activities such as (safari trips, diving, climbing, sports) is at their own risk.\n\n'
                'The service provider is responsible for providing all legally required safety measures and insurance.\n\n'
                'The platform bears no liability for any injuries, damages, or deaths occurring during such activities.\n\n'
                'By booking, the user expressly agrees to release the platform from any claims arising from such risks.'),

            SizedBox(height: 32.h),

            // Arabic Version
            Text(
              'الشروط والأحكام (العربية)',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF233A6A),
              ),
            ),
            SizedBox(height: 16.h),

            _buildSectionTitle('التعريفات'),
            _buildText(
                '"المنصة" أو "التطبيق": يقصد بها تطبيق The Ard App المملوك والمُدار من قبل الشركة المالكة والمسجلة بجمهورية مصر العربية.\n\n'
                '"المستخدم" أو "المسافر": كل شخص طبيعي يقوم بتحميل أو استخدام التطبيق بغرض حجز خدمات.\n\n'
                '"الشريك" أو "مقدم الخدمة": كل شخص طبيعي أو اعتباري مسجل لدى التطبيق لتقديم خدمات (إقامة – رحلات – أنشطة – منتجات يدوية).\n\n'
                '"الخدمات": كافة الأنشطة والخدمات والمنتجات المعروضة على التطبيق.'),

            _buildSectionTitle('الشروط العامة (تسري على جميع الأطراف)'),
            _buildArabicNumberedList([
              'التطبيق يعمل كوسيط إلكتروني بين الشركاء والمستخدمين، ولا يتحمل أي التزام مباشر بتنفيذ الخدمة.',
              'المنصة غير مسؤولة عن أي تعاقد خارج التطبيق.',
              'جميع المدفوعات يجب أن تتم من خلال التطبيق فقط.',
              'المنصة تحتفظ بنسبة عمولة متفق عليها من كل عملية حجز.',
              'المنصة تحتفظ بحق تعديل أو تحديث الشروط في أي وقت.',
              'أي نزاع قانوني يخضع لاختصاص المحاكم المصرية.',
              'يمنع استخدام التطبيق في أي نشاط مخالف للقانون المصري.',
              'جميع البيانات المقدمة من المستخدم أو الشريك يجب أن تكون صحيحة ودقيقة.',
              'المنصة لها الحق في تعليق أو حذف أي حساب في حالة مخالفة القوانين أو الشروط.',
              'لا تضمن المنصة جودة الخدمة بشكل مباشر، وإنما تلتزم بالرقابة الإدارية والمراجعة قبل النشر.',
            ]),

            _buildSectionTitle('التزامات المستخدم (المسافر)'),
            _buildArabicNumberedList([
              'يلتزم المستخدم بدفع قيمة الخدمة كاملة وفق سياسة الدفع.',
              'يلتزم المستخدم بسياسة الإلغاء وعدم الاسترداد المعلنة في التطبيق.',
              'يلتزم المستخدم باستخدام الخدمة لأغراض شخصية وسياحية فقط.',
              'يمنع على المستخدم إعادة بيع أو تحويل الحجز للغير دون موافقة المنصة.',
              'يتحمل المستخدم أي أضرار أو خسائر ناتجة عن إساءة استخدام الخدمة.',
              'يلتزم المستخدم بالالتزام بالقوانين المصرية خلال استخدام الخدمات (مثل قوانين البيئة، السياحة، الأمن).',
              'للمستخدم الحق في تقييم الشركاء بعد إتمام الخدمة، بشرط أن يكون التقييم حقيقي وغير مسيء.',
              'أي شكوى يجب أن تُقدم عبر خدمة العملاء خلال 48 ساعة من الواقعة.',
              'يقر المستخدم أن التطبيق غير مسؤول عن أي إصابة، ضرر، أو وفاة ناتجة عن الخدمة.',
              'أي استخدام غير مشروع للتطبيق (مثل الاحتيال، تزوير بيانات) يؤدي لإغلاق الحساب فورًا.',
            ], startNumber: 11),

            _buildSectionTitle('التزامات الشريك (مقدم الخدمة)'),
            _buildArabicNumberedList([
              'يلتزم الشريك بتقديم بيانات صحيحة ومحدثة عن الخدمة (صور، وصف، أسعار).',
              'يلتزم الشريك بتقديم الخدمة بنفس المواصفات المعلن عنها.',
              'يلتزم الشريك بتسعير الخدمة بشكل واضح وشفاف داخل التطبيق.',
              'يلتزم الشريك بدفع العمولة المستحقة للمنصة عن كل عملية حجز.',
              'يلتزم الشريك بالالتزام بالقوانين المصرية المنظمة (السياحة، حماية المستهلك، الضرائب).',
              'يلتزم الشريك بإصدار الفواتير الضريبية وفق القوانين المصرية.',
              'للشريك الحق في تعديل أو إلغاء خدمة بشرط إخطار المنصة مسبقًا.',
              'أي إخلال أو شكوى متكررة من العملاء يتيح للمنصة وقف حساب الشريك.',
              'يلتزم الشريك بعدم استغلال بيانات العملاء خارج نطاق الحجز.',
              'الشريك مسؤول قانونًا عن أي أضرار أو خسائر يتعرض لها العميل خلال تقديم الخدمة.',
            ], startNumber: 21),

            _buildSectionTitle('إخلاء المسؤولية للأنشطة الخطرة'),
            _buildText(
                'يقر المستخدم أن مشاركته في أنشطة مثل (رحلات السفاري – الغوص – التسلق – الأنشطة الرياضية) تتم على مسؤوليته الشخصية.\n\n'
                'يلتزم مقدم الخدمة بتوفير كافة وسائل السلامة والتأمين المطلوبة قانونًا.\n\n'
                'المنصة غير مسؤولة عن أي إصابات أو أضرار أو وفيات تحدث أثناء ممارسة هذه الأنشطة.\n\n'
                'باستخدامه للخدمة، يوافق المستخدم صراحة على إخلاء مسؤولية المنصة عن أي مخاطر ناتجة عن هذه الأنشطة.'),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Color(0xFF233A6A),
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
          fontSize: 12.sp,
          color: Colors.black87,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildNumberedList(List<String> items, {int startNumber = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((entry) {
        int index = entry.key;
        String item = entry.value;
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            '${startNumber + index}. $item',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildArabicNumberedList(List<String> items, {int startNumber = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((entry) {
        int index = entry.key;
        String item = entry.value;
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            '${startNumber + index}. $item',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black87,
              height: 1.4,
            ),
            textDirection: TextDirection.rtl,
          ),
        );
      }).toList(),
    );
  }
}
