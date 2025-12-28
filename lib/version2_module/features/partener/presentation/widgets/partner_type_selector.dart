import 'package:PassPort/version2_module/core/enums/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

class PartnerTypeSelector extends StatefulWidget {
  final Function(UserType) onPartnerTypeSelected;
  final UserType? selectedType;

  const PartnerTypeSelector({
    super.key,
    required this.onPartnerTypeSelected,
    this.selectedType,
  });

  @override
  State<PartnerTypeSelector> createState() => _PartnerTypeSelectorState();
}

class _PartnerTypeSelectorState extends State<PartnerTypeSelector> {
  UserType? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.selectedType;
  }

  @override
  Widget build(BuildContext context) {
    final partnerTypes =
        UserType.values.where((type) => type.isPartnerType).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF2C8B8B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C8B8B),
        elevation: 0,
        title: Text(
          'Choose Partner Type',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            color: const Color(0xFF2C8B8B),
            child: Column(
              children: [
                Icon(
                  Icons.business,
                  size: 64.sp,
                  color: Colors.white,
                ),
                SizedBox(height: 12.h),
                Text(
                  'Select Your Partner Type',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Choose the type of service you want to provide',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFBF0E3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    // Partner Type Cards
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: partnerTypes.length,
                        itemBuilder: (context, index) {
                          final partnerType = partnerTypes[index];
                          final isSelected = _selectedType == partnerType;

                          return _buildPartnerTypeCard(partnerType, isSelected);
                        },
                      ),
                    ),

                    // Continue Button
                    if (_selectedType != null) ...[
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onPartnerTypeSelected(_selectedType!);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appTextColor,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerTypeCard(UserType partnerType, bool isSelected) {
    IconData icon;
    Color cardColor;

    switch (partnerType) {
      case UserType.accommodation:
        icon = Icons.hotel;
        cardColor = Colors.blue;
        break;
      case UserType.activity:
        icon = Icons.local_activity;
        cardColor = Colors.orange;
        break;
      case UserType.trip:
        icon = Icons.flight_takeoff;
        cardColor = Colors.green;
        break;
      case UserType.product:
        icon = Icons.shopping_bag;
        cardColor = Colors.purple;
        break;
      default:
        icon = Icons.business;
        cardColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = partnerType;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? appTextColor : Colors.grey[300]!,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: cardColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32.sp,
                color: cardColor,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              partnerType.displayName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: appTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            if (isSelected) ...[
              SizedBox(height: 8.h),
              Icon(
                Icons.check_circle,
                color: appTextColor,
                size: 20.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
