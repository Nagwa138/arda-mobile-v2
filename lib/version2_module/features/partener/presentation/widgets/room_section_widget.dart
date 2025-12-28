import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:PassPort/components/color/color.dart';

class RoomSectionWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onRoomsChanged;

  const RoomSectionWidget({
    Key? key,
    required this.onRoomsChanged,
  }) : super(key: key);

  @override
  State<RoomSectionWidget> createState() => _RoomSectionWidgetState();
}

class _RoomSectionWidgetState extends State<RoomSectionWidget> {
  final List<Map<String, dynamic>> _rooms = [];
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // إضافة غرفة افتراضية
    _addRoom();
  }

  void _addRoom() {
    setState(() {
      _rooms.add({
        'roomType': 'Single',
        'count': 0,
        'price': 0,
        'guestNum': 1,
        'priceIncludeBreakFast': false,
        'image': null,
        'nightController': TextEditingController(),
        'guestController': TextEditingController(),
      });
    });
    _notifyParent();
  }

  void _removeRoom(int index) {
    if (_rooms.length > 1) {
      setState(() {
        _rooms[index]['nightController'].dispose();
        _rooms[index]['guestController'].dispose();
        _rooms.removeAt(index);
      });
      _notifyParent();
    }
  }

  void _updateRoom(int index, String field, dynamic value) {
    setState(() {
      _rooms[index][field] = value;
    });
    _notifyParent();
  }

  Future<void> _pickImage(int roomIndex) async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        _rooms[roomIndex]['image'] = image;
      });
      _notifyParent();
    }
  }

  void _removeImage(int roomIndex) {
    setState(() {
      _rooms[roomIndex]['image'] = null;
    });
    _notifyParent();
  }

  void _notifyParent() {
    final roomsData = _rooms
        .map((room) => {
              'roomType': room['roomType'],
              'count': room['count'],
              'price': int.tryParse(room['nightController'].text) ?? 0,
              'guestNum': int.tryParse(room['guestController'].text) ?? 1,
              'priceIncludeBreakFast': room['priceIncludeBreakFast'],
              'image': room['image'],
            })
        .toList();

    widget.onRoomsChanged({'rooms': roomsData});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'تفاصيل الغرف',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: appTextColor,
              ),
            ),
            IconButton(
              onPressed: _addRoom,
              icon: Icon(Icons.add_circle, color: appTextColor),
              tooltip: 'إضافة غرفة',
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _rooms.length,
          itemBuilder: (context, index) {
            final room = _rooms[index];
            return Card(
              margin: EdgeInsets.only(bottom: 12.h),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الغرفة ${index + 1}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_rooms.length > 1)
                          IconButton(
                            onPressed: () => _removeRoom(index),
                            icon: Icon(Icons.delete, color: Colors.red),
                            tooltip: 'حذف الغرفة',
                          ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // نوع الغرفة
                    DropdownButtonFormField<String>(
                      value: room['roomType'],
                      decoration: InputDecoration(
                        labelText: 'نوع الغرفة',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Single', 'Double', 'Triple', 'King'].map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          _updateRoom(index, 'roomType', value);
                        }
                      },
                    ),

                    SizedBox(height: 12.h),

                    // عدد الغرف
                    Row(
                      children: [
                        Text('عدد الغرف: '),
                        IconButton(
                          onPressed: () {
                            if (room['count'] > 0) {
                              _updateRoom(index, 'count', room['count'] - 1);
                            }
                          },
                          icon: Icon(Icons.remove_circle_outline),
                        ),
                        Text('${room['count']}'),
                        IconButton(
                          onPressed: () {
                            _updateRoom(index, 'count', room['count'] + 1);
                          },
                          icon: Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // السعر وعدد الضيوف
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: room['nightController'],
                            decoration: InputDecoration(
                              labelText: 'السعر لليلة',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => _notifyParent(),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: TextFormField(
                            controller: room['guestController'],
                            decoration: InputDecoration(
                              labelText: 'عدد الضيوف',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => _notifyParent(),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // وجبة الإفطار
                    CheckboxListTile(
                      title: Text('يشمل السعر وجبة الإفطار'),
                      value: room['priceIncludeBreakFast'],
                      onChanged: (value) {
                        _updateRoom(
                            index, 'priceIncludeBreakFast', value ?? false);
                      },
                    ),

                    SizedBox(height: 12.h),

                    // صورة الغرفة
                    Text(
                      'صورة الغرفة',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    if (room['image'] != null)
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 120.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(File(room['image'].path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              onPressed: () => _removeImage(index),
                              icon: Icon(Icons.close, color: Colors.white),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      GestureDetector(
                        onTap: () => _pickImage(index),
                        child: Container(
                          width: double.infinity,
                          height: 120.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate, size: 40),
                              SizedBox(height: 8.h),
                              Text('إضافة صورة'),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    for (final room in _rooms) {
      room['nightController'].dispose();
      room['guestController'].dispose();
    }
    super.dispose();
  }
}
