import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

class FeaturesSectionWidget extends StatefulWidget {
  final Function(List<String>) onFeaturesChanged;

  const FeaturesSectionWidget({
    Key? key,
    required this.onFeaturesChanged,
  }) : super(key: key);

  @override
  State<FeaturesSectionWidget> createState() => _FeaturesSectionWidgetState();
}

class _FeaturesSectionWidgetState extends State<FeaturesSectionWidget> {
  final List<String> _selectedFeatures = [];

  // قائمة المميزات الخاصة المتاحة
  final List<String> _availableFeatures = [
    'إطلالة بانورامية',
    'مسبح خاص',
    'جاكوزي',
    'ساونا',
    'مطبخ مجهز بالكامل',
    'غرفة طعام خاصة',
    'غرفة معيشة منفصلة',
    'مكتبة',
    'غرفة ألعاب',
    'مطبخ خارجي',
    'باربيكيو',
    'حديقة خاصة',
    'ملعب تنس',
    'ملعب كرة قدم',
    'ملعب جولف',
    'مركز صحي',
    'سبا',
    'صالون تجميل',
    'غرفة تدليك',
    'غرفة يوغا',
    'مكتب عمل مجهز',
    'غرفة مؤتمرات',
    'مطبخ احترافي',
    'مخزن',
    'غرفة غسيل',
    'غرفة خادمة',
    'مصعد خاص',
    'موقف سيارات مغطى',
    'حارس أمن',
    'خدمة تنظيف يومية',
    'خدمة غسيل ملابس',
    'خدمة طعام',
    'سائق خاص',
    'مرشد سياحي',
    'خدمة نقل من المطار',
    'خدمة حجز تذاكر',
    'خدمة حجز جولات',
    'خدمة ترجمة',
    'خدمة طباعة',
    'خدمة فاكس',
    'خدمة إنترنت عالي السرعة',
    'تلفزيون ذكي',
    'نظام صوت محيطي',
    'إضاءة ذكية',
    'تحكم في درجة الحرارة',
    'نظام أمان متقدم',
    'كاميرات مراقبة',
    'نظام إنذار',
    'مطفأة حريق',
    'مخرج طوارئ',
    'معدات إسعاف أولي',
  ];

  void _toggleFeature(String feature) {
    setState(() {
      if (_selectedFeatures.contains(feature)) {
        _selectedFeatures.remove(feature);
      } else {
        _selectedFeatures.add(feature);
      }
    });
    widget.onFeaturesChanged(_selectedFeatures);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المميزات الخاصة',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: appTextColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'اختر المميزات الخاصة المتوفرة في إقامتك',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          height: 200.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            padding: EdgeInsets.all(8.w),
            itemCount: _availableFeatures.length,
            itemBuilder: (context, index) {
              final feature = _availableFeatures[index];
              final isSelected = _selectedFeatures.contains(feature);

              return CheckboxListTile(
                title: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                value: isSelected,
                onChanged: (value) => _toggleFeature(feature),
                activeColor: appTextColor,
                checkColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                dense: true,
              );
            },
          ),
        ),
        SizedBox(height: 8.h),
        if (_selectedFeatures.isNotEmpty)
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _selectedFeatures.map((feature) {
              return Chip(
                label: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: appTextColor,
                deleteIcon: Icon(Icons.close, color: Colors.white, size: 18),
                onDeleted: () => _toggleFeature(feature),
              );
            }).toList(),
          ),
      ],
    );
  }
}
