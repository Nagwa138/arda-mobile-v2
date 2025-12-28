import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

/// Integration Guide for the Enhanced Review System
///
/// This file demonstrates how to use the improved review system
/// with proper API integration and English language support.
class ReviewIntegrationGuide extends StatelessWidget {
  const ReviewIntegrationGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('Review System Integration Guide'),
        backgroundColor: appTextColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: '1. Navigate to Reviews Screen',
              description:
                  'Use this code to navigate to the reviews screen from any service page:',
              code: '''
// Navigate to reviews screen
Navigator.pushNamed(
  context,
  '/commentsAndRating',  // Route name
  arguments: {
    'id': serviceId,          // Required: Service ID for API
    'name': serviceName,      // Optional: Service name for display
    'image': serviceImageUrl, // Optional: Service image URL
  },
);

// Example with real data:
Navigator.pushNamed(
  context,
  '/commentsAndRating',
  arguments: {
    'id': '123e4567-e89b-12d3-a456-426614174000',
    'name': 'Luxury Hotel Cairo',
    'image': 'https://example.com/hotel-image.jpg',
  },
);''',
            ),
            SizedBox(height: 24.h),
            _buildSection(
              title: '2. API Endpoints Used',
              description: 'The system integrates with these API endpoints:',
              code: '''
// Get all reviews for a service
GET /api/Reviews/GetAllReview?reviewId={serviceId}

// Add new review
POST /api/Reviews/AddReview
Body: {
  "comment": "Great service! Highly recommended.",
  "rate": 4.5,
  "serviceId": "123e4567-e89b-12d3-a456-426614174000"
}

// Headers required:
Authorization: Bearer {jwt_token}
Content-Type: application/json''',
            ),
            SizedBox(height: 24.h),
            _buildSection(
              title: '3. Review Validation Rules',
              description: 'The system validates reviews with these rules:',
              code: '''
Rating Validation:
✓ Required: Must be between 1-5 stars
✓ Supports half ratings (e.g., 3.5 stars)

Comment Validation:
✓ Required: Cannot be empty
✓ Minimum length: 10 characters
✓ Maximum length: 1000 characters
✓ Automatic trimming of whitespace

Authentication:
✓ User must be logged in
✓ JWT token automatically included in API calls''',
            ),
            SizedBox(height: 24.h),
            _buildSection(
              title: '4. User Experience Features',
              description: 'Enhanced UX features included:',
              code: '''
Visual Feedback:
• Animated rating stars with glow effects
• Color-coded ratings (Green=Excellent, Amber=Good, etc.)
• Real-time rating text updates (Excellent, Good, Average, Poor)

Form Handling:
• Smart validation with clear error messages
• Auto-save draft while typing
• Form reset after successful submission

Loading States:
• Skeleton loading for reviews list
• Button loading states during submission
• Pull-to-refresh for reviews list

Error Handling:
• Network error recovery
• Retry buttons for failed submissions
• User-friendly error messages''',
            ),
            SizedBox(height: 24.h),
            _buildSection(
              title: '5. Integration Example',
              description: 'Complete example of integrating the review system:',
              code: '''
class ServiceDetailsScreen extends StatelessWidget {
  final String serviceId;
  final String serviceName;
  final String serviceImage;

  const ServiceDetailsScreen({
    required this.serviceId,
    required this.serviceName,
    required this.serviceImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(serviceName)),
      body: Column(
        children: [
          // Service details...
          
          // Reviews button
          Padding(
            padding: EdgeInsets.all(16.w),
            child: ElevatedButton.icon(
              onPressed: () => _viewReviews(context),
              icon: Icon(Icons.rate_review),
              label: Text('View Reviews & Ratings'),
              style: ElevatedButton.styleFrom(
                backgroundColor: appTextColor,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _viewReviews(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/commentsAndRating',
      arguments: {
        'id': serviceId,
        'name': serviceName,
        'image': serviceImage,
      },
    );
  }
}''',
            ),
            SizedBox(height: 24.h),
            _buildSection(
              title: '6. Testing the Integration',
              description: 'How to test the review system:',
              code: '''
1. Test Review Display:
   • Navigate to reviews screen with valid service ID
   • Verify reviews load correctly
   • Test pull-to-refresh functionality

2. Test Review Submission:
   • Tap "Add Review" floating button
   • Try submitting without rating (should show error)
   • Try submitting with empty comment (should show error)
   • Try submitting with valid data (should succeed)

3. Test Error Scenarios:
   • Test with invalid service ID
   • Test with network disconnected
   • Test with invalid authentication

4. Test UI Responsiveness:
   • Test on different screen sizes
   • Verify animations work smoothly
   • Test keyboard interactions''',
            ),
            SizedBox(height: 32.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue),
                      SizedBox(width: 8.w),
                      Text(
                        'Integration Complete!',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'The review system is now fully integrated with:\n'
                    '• English language support\n'
                    '• Proper API integration\n'
                    '• Enhanced validation\n'
                    '• Modern UI/UX\n'
                    '• Error handling & recovery',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required String code,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: appTextColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.green.shade300,
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
