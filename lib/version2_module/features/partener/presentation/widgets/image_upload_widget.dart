import 'dart:io';

import 'package:PassPort/components/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadWidget extends StatefulWidget {
  final String label;
  final Function(List<String>) onImagesSelected;
  final List<String> initialImages;
  final int maxImages;

  const ImageUploadWidget({
    super.key,
    required this.label,
    required this.onImagesSelected,
    this.initialImages = const [],
    this.maxImages = 10,
  });

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  List<String> _imagePaths = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _imagePaths = List.from(widget.initialImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: appTextColor,
          ),
        ),

        SizedBox(height: 12.h),

        // Upload Area
        _buildUploadArea(),

        if (_imagePaths.isNotEmpty) ...[
          SizedBox(height: 16.h),
          _buildImageGrid(),
        ],
      ],
    );
  }

  Widget _buildUploadArea() {
    return InkWell(
      onTap: _showImageSourceDialog,
      child: Container(
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: appTextColor.withValues(alpha: 0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: appTextColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_upload_outlined,
                size: 32.sp,
                color: appTextColor,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Upload Photos',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: appTextColor,
              ),
            ),
            SizedBox(height: 4.h),
            // Text(
            //   'Tap to add photos (${_imagePaths.length}/${widget.maxImages})',
            //   style: TextStyle(
            //     fontSize: 12.sp,
            //     color: Colors.grey[600],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Selected Photos (${_imagePaths.length})',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: appTextColor,
                ),
              ),
              if (_imagePaths.isNotEmpty)
                TextButton(
                  onPressed: _clearAllImages,
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
              childAspectRatio: 1,
            ),
            itemCount: _imagePaths.length +
                (_imagePaths.length < widget.maxImages ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _imagePaths.length) {
                return _buildAddImageCard();
              }
              return _buildImageCard(_imagePaths[index], index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String imagePath, int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(
              image: FileImage(File(imagePath)),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Remove button
        Positioned(
          top: 4.w,
          right: 4.w,
          child: InkWell(
            onTap: () => _removeImage(index),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 14.sp,
              ),
            ),
          ),
        ),

        // Main photo indicator
        if (index == 0)
          Positioned(
            bottom: 4.w,
            left: 4.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: appTextColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                'Main',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAddImageCard() {
    return InkWell(
      onTap: _showImageSourceDialog,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: Colors.grey[300]!,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              color: Colors.grey[600],
              size: 24.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              'Add',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              'Select Image Source',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: appTextColor,
              ),
            ),

            SizedBox(height: 20.h),

            Row(
              children: [
                Expanded(
                  child: _buildSourceOption(
                    'Camera',
                    Icons.camera_alt,
                    () => _pickImage(ImageSource.camera),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildSourceOption(
                    'Gallery',
                    Icons.photo_library,
                    () => _pickImages(),
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceOption(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: appTextColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32.sp,
              color: appTextColor,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: appTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    if (_imagePaths.length >= widget.maxImages) {
      _showMaxImagesMessage();
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _imagePaths.add(image.path);
        });
        widget.onImagesSelected(_imagePaths);
      }
    } catch (e) {
      _showErrorMessage('Failed to pick image: $e');
    }
  }

  Future<void> _pickImages() async {
    if (_imagePaths.length >= widget.maxImages) {
      _showMaxImagesMessage();
      return;
    }

    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (images.isNotEmpty) {
        final remainingSlots = widget.maxImages - _imagePaths.length;
        final imagesToAdd =
            images.take(remainingSlots).map((e) => e.path).toList();

        setState(() {
          _imagePaths.addAll(imagesToAdd);
        });

        widget.onImagesSelected(_imagePaths);

        if (images.length > remainingSlots) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Only $remainingSlots images were added due to limit'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      _showErrorMessage('Failed to pick images: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imagePaths.removeAt(index);
    });
    widget.onImagesSelected(_imagePaths);
  }

  void _clearAllImages() {
    setState(() {
      _imagePaths.clear();
    });
    widget.onImagesSelected(_imagePaths);
  }

  void _showMaxImagesMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Maximum ${widget.maxImages} images allowed'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
