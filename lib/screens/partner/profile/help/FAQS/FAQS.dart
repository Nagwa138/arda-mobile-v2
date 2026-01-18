import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/background_container.dart';
import 'package:PassPort/components/widgets/watermark_logo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Map<String, String>> faqsList = [
  {
    'title': 'The Arda App',
    'body': 'A Journey Through Heritage and Adventure.',
  },
  {
    'title': 'Name & Meaning',
    'body':
        'The Arda" is inspired by the deep-rooted cultural and historical essence of Arab and Egyptian heritage. The name reflects authenticity, tradition, and the spirit of exploration.',
  },
  {
    'title': 'Concept & Purpose',
    'body':
        'The Arda is a travel and booking app designed for adventurers, travelers, and experience seekers. It offers a seamless way to explore and book camps, hotels, activities (such as water sports and desert adventures), and trips. Additionally, users can purchase local products and read special articles about different cities and travel destinations.',
  },
  {
    'title': 'Target Audience',
    'body':
        'The app caters to both Egyptians and international travelers who love discovering new places, immersing themselves in authentic experiences, and enjoying unique cultural and adventure-based activities.\n With The Arda, every trip becomes an unforgettable journey, blending heritage with modern travel convenience.',
  }
];

class FAQS extends StatelessWidget {
  const FAQS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'FAQS.title'.tr(),
          style: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: Stack(
        children: [
          const BackgroundContainer(),
          SingleChildScrollView(
            child: Column(
              children: List.generate(
                faqsList.length,
                (index) => Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      faqsList[index]['title'] ?? '',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    childrenPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    children: [
                      Text(
                        faqsList[index]['body'] ?? '',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const WatermarkLogo(),
        ],
      ),
    );
  }
}
