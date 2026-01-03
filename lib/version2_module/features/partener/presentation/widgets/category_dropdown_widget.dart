import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:PassPort/consts/api/api.dart';

class CategoryDropdownWidget extends StatefulWidget {
  final String label;
  final String? placeholder;
  final Function(String) onChanged;
  final String? initialValue;
  final bool isRequired;

  const CategoryDropdownWidget({
    super.key,
    required this.label,
    this.placeholder,
    required this.onChanged,
    this.initialValue,
    this.isRequired = true,
  });

  @override
  State<CategoryDropdownWidget> createState() => _CategoryDropdownWidgetState();
}

class _CategoryDropdownWidgetState extends State<CategoryDropdownWidget> {
  List<Map<String, String>>? _categories;
  bool _isLoading = false;
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      print(
          '🔄 Loading categories from: ${Api.BASE_URL}/api/ProductCategories');

      final response = await http.get(
        Uri.parse('${Api.BASE_URL}/api/ProductCategories'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('📥 Categories response status: ${response.statusCode}');
      print('📥 Categories response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('📋 Decoded categories data: $data');

        if (data['statusCode'] == 200 && data['data'] != null) {
          final categories =
              (data['data'] as List).map<Map<String, String>>((category) {
            return {
              'id': category['id'].toString(),
              'name': category['name'].toString(),
            };
          }).toList();

          print('✅ Successfully loaded ${categories.length} categories');
          print('📋 Categories: $categories');

          setState(() {
            _categories = categories;
            _isLoading = false;
          });
        } else {
          print(
              '❌ Invalid response format: statusCode=${data['statusCode']}, data=${data['data']}');
          await _tryAlternativeEndpoint();
        }
      } else {
        print('❌ Failed to load categories: ${response.statusCode}');
        await _tryAlternativeEndpoint();
      }
    } catch (e) {
      print('💥 Error loading categories: $e');
      await _tryAlternativeEndpoint();
    }
  }

  Future<void> _tryAlternativeEndpoint() async {
    try {
      print(
          '🔄 Trying alternative endpoint: ${Api.BASE_URL}/api/Product/Product/GetAllProductCategory');

      final response = await http.get(
        Uri.parse('${Api.BASE_URL}/api/Product/Product/GetAllProductCategory'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('📥 Alternative endpoint response status: ${response.statusCode}');
      print('📥 Alternative endpoint response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['statusCode'] == 200 && data['data'] != null) {
          final categories =
              (data['data'] as List).map<Map<String, String>>((category) {
            return {
              'id': category['id'].toString(),
              'name': category['name'].toString(),
            };
          }).toList();

          print(
              '✅ Successfully loaded ${categories.length} categories from alternative endpoint');

          setState(() {
            _categories = categories;
            _isLoading = false;
          });
          return;
        }
      }

      // If alternative endpoint also fails, use fallback
      _setFallbackCategories();
    } catch (e) {
      print('💥 Alternative endpoint also failed: $e');
      _setFallbackCategories();
    }
  }

  void _setFallbackCategories() {
    setState(() {
      _isLoading = false;
      // Fallback to default categories
      _categories = [
        {'id': '00000001-0000-0000-0000-000000000000', 'name': 'Farms'},
        {'id': '00000002-7df5-4947-ac47-e05ea89d21e4', 'name': 'Handicrafts'},
        {'id': '00000003-7df5-4947-ac47-e05ea89d21e4', 'name': 'Pottery'},
        {'id': '00000004-7df5-4947-ac47-e05ea89d21e4', 'name': 'Weavers'},
        {'id': '00000005-7df5-4947-ac47-e05ea89d21e4', 'name': 'Others'},
      ];
    });
    print('🔄 Using fallback categories: $_categories');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: appTextColor,
              ),
            ),
            if (!widget.isRequired) ...[
              SizedBox(width: 4.w),
              Text(
                'Optional',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),

        SizedBox(height: 8.h),

        // Dropdown
        _isLoading
            ? Container(
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(appTextColor),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Loading categories...',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              )
            : (_categories == null || _categories!.isEmpty)
                ? Container(
                    height: 48.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      border: Border.all(color: Colors.red[300]!),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline,
                            color: Colors.red[600], size: 16.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Failed to load categories',
                          style: TextStyle(
                            color: Colors.red[600],
                            fontSize: 14.sp,
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: _loadCategories,
                          child: Text(
                            'Retry',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                  )
                : DropdownButtonFormField<String>(
                    initialValue: _selectedValue,
                    onChanged: (value) {
                      print('🔽 Category dropdown changed: $value');
                      setState(() {
                        _selectedValue = value;
                      });
                      if (value != null) {
                        print(
                            '✅ Calling onChanged callback with value: $value');
                        widget.onChanged(value);
                      } else {
                        print('⚠️  Selected value is null');
                      }
                    },
                    decoration: InputDecoration(
                      hintText: widget.placeholder ?? 'Select category',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14.sp,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: appTextColor, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                    ),
                    items: _categories?.map((category) {
                      return DropdownMenuItem<String>(
                        value: category['id'],
                        child: Text(
                          category['name']!,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      );
                    }).toList(),
                    validator: (value) {
                      if (widget.isRequired &&
                          (value == null || value.isEmpty)) {
                        return '${widget.label} is required';
                      }
                      return null;
                    },
                  ),
      ],
    );
  }
}
