import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/review_cubit/review_cubit.dart';
import 'package:PassPort/services/traveller/review_cubit/review_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../version2_module/core/const/app_colors.dart';

class CommentsAndRating extends StatefulWidget {
  const CommentsAndRating({super.key});

  @override
  State<CommentsAndRating> createState() => _CommentsAndRatingState();
}

class _CommentsAndRatingState extends State<CommentsAndRating>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return BlocProvider(
      create: (BuildContext context) =>
          ReviewCubit()..getReviewAll(reviewId: arguments['id']),
      child: BlocConsumer<ReviewCubit, ReviewState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: _buildModernAppBar(),
            body: _buildBody(context, state),
            floatingActionButton: _buildAddReviewFAB(context),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon:
              Icon(Icons.arrow_back_ios_new, color: appTextColor, size: 18.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Text(
        "Ratting.rating".tr(),
        style: TextStyle(
          color: appTextColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context, ReviewState state) {
    if (state is GetReviewLoadingAll) {
      return _buildLoadingState();
    }

    final cubit = context.read<ReviewCubit>();
    final reviews = cubit.reviews;

    if (reviews?.data?.usersReviews?.isEmpty ?? true) {
      return _buildEmptyState();
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: RefreshIndicator(
        onRefresh: () async {
          final arguments = (ModalRoute.of(context)?.settings.arguments ??
              <String, dynamic>{}) as Map;
          cubit.getReviewAll(reviewId: arguments['id']);
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildReviewsHeader(reviews!.data!),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final review = reviews.data!.usersReviews![index];
                    return _buildReviewCard(review, index);
                  },
                  childCount: reviews.data!.usersReviews!.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(appTextColor),
              strokeWidth: 3,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Loading Reviews...',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Icon(
                  Icons.rate_review_outlined,
                  size: 64.sp,
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Ratting.opinion1".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: appTextColor,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Ratting.opinuon2".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsHeader(data) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appTextColor, appTextColor.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: appTextColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${data.totalRate ?? 0}',
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 32.sp,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${data.reviewrsCount ?? 0} Reviews',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Text(
                  '${data.recomendPercent ?? 0}%',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(review, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getAvatarColor(review.userName ?? ''),
                        _getAvatarColor(review.userName ?? '')
                            .withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Center(
                    child: Text(
                      (review.userName ?? 'U').substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName ?? 'Anonymous',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: appTextColor,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 12.sp,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${review.date ?? ''} ${review.time ?? ''}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: _getRatingColor((review.rate ?? 0).toDouble())
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: _getRatingColor((review.rate ?? 0).toDouble())
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${review.rate ?? 0}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: _getRatingColor((review.rate ?? 0).toDouble()),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.star_rounded,
                        size: 16.sp,
                        color: _getRatingColor((review.rate ?? 0).toDouble()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                review.comment ?? 'No comment provided',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];
    return colors[name.hashCode % colors.length];
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.0) return Colors.green;
    if (rating >= 3.0) return Colors.amber;
    if (rating >= 2.0) return Colors.orange;
    return Colors.red;
  }

  Widget _buildAddReviewFAB(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return FloatingActionButton.extended(
      onPressed: () => _showAddReviewDialog(context, arguments),
      backgroundColor: appTextColor,
      icon: Icon(Icons.add_comment_rounded, color: Colors.white),
      label: Text(
        'Add Review',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevation: 8,
    );
  }

  void _showAddReviewDialog(BuildContext context, Map arguments) {
    final parentCubit = context.read<ReviewCubit>();
    final parentScaffoldMessenger = ScaffoldMessenger.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider(
        create: (context) => ReviewCubit(),
        child: QuickReviewBottomSheet(
          serviceId: arguments['id'] ?? '',
          serviceName: arguments['name'] ?? 'Service',
          parentScaffoldMessenger: parentScaffoldMessenger,
          onReviewAdded: (String reviewId) {
            // Refresh reviews after adding new review using parent cubit
            if (reviewId.isNotEmpty) {
              parentCubit.getReviewAll(reviewId: reviewId);
            }
          },
        ),
      ),
    );
  }
}

class QuickReviewBottomSheet extends StatefulWidget {
  final String serviceId;
  final String serviceName;
  final Function(String) onReviewAdded;
  final ScaffoldMessengerState parentScaffoldMessenger;

  const QuickReviewBottomSheet({
    super.key,
    required this.serviceId,
    required this.serviceName,
    required this.onReviewAdded,
    required this.parentScaffoldMessenger,
  });

  @override
  State<QuickReviewBottomSheet> createState() => _QuickReviewBottomSheetState();
}

class _QuickReviewBottomSheetState extends State<QuickReviewBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  double _currentRating = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewCubit(),
      child: BlocConsumer<ReviewCubit, ReviewState>(
        listener: (context, state) {
          if (state is CreateReviewSuccessful) {
            _showSuccessMessage();
          } else if (state is CreateReviewError) {
            _showErrorMessage(state.error);
          }
        },
        builder: (context, state) {
          return AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _slideAnimation.value * 50),
                child: Container(
                  margin: EdgeInsets.only(top: 50.h),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      topRight: Radius.circular(25.r),
                    ),
                  ),
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.9,
                    minChildSize: 0.5,
                    maxChildSize: 0.95,
                    builder: (context, scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        padding: EdgeInsets.all(24.w),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(),
                              SizedBox(height: 24.h),
                              _buildServiceInfo(),
                              SizedBox(height: 32.h),
                              _buildRatingSection(),
                              SizedBox(height: 24.h),
                              _buildCommentSection(),
                              SizedBox(height: 32.h),
                              _buildSubmitButton(context, state),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).viewInsets.bottom),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: appTextColor,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            'Write Your Review',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: appTextColor,
            ),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildServiceInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: appTextColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.business,
              color: appTextColor,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.serviceName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: appTextColor,
                  ),
                ),
                Text(
                  'Share your experience with this service',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overall Rating',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: appTextColor,
          ),
        ),
        SizedBox(height: 12.h),
        Center(
          child: Column(
            children: [
              RatingBar.builder(
                initialRating: _currentRating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40.sp,
                glow: true,
                glowColor: Colors.amber.withValues(alpha: 0.3),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: _currentRating > index
                        ? [
                            BoxShadow(
                              color: Colors.amber.withValues(alpha: 0.3),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _currentRating = rating;
                  });
                  context.read<ReviewCubit>().rating = rating;
                },
              ),
              SizedBox(height: 16.h),
              if (_currentRating > 0)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color:
                        _getRatingColor(_currentRating).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: _getRatingColor(_currentRating)
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getRatingIcon(_currentRating),
                        color: _getRatingColor(_currentRating),
                        size: 16.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _getRatingText(_currentRating),
                        style: TextStyle(
                          color: _getRatingColor(_currentRating),
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Comment',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: appTextColor,
          ),
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: _commentController,
          maxLines: 5,
          style: TextStyle(
            fontSize: 16.sp,
            color: appTextColor,
            height: 1.5,
          ),
          decoration: InputDecoration(
            hintText:
                'Write about your experience with this service...\n\nWhat did you like most? How was the service quality? Any suggestions for improvement?',
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14.sp,
              height: 1.5,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: appTextColor, width: 2),
            ),
            contentPadding: EdgeInsets.all(16.w),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please write a comment about your experience';
            }
            if (value.trim().length < 10) {
              return 'Please write at least 10 characters';
            }
            if (value.trim().length > 1000) {
              return 'Comment is too long. Please keep it under 1000 characters';
            }
            return null;
          },
          onChanged: (value) {
            context.read<ReviewCubit>().reviewComment.text = value;
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, ReviewState state) {
    final isLoading = state is CreateReviewLoading;

    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appTextColor, appTextColor.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: appTextColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: isLoading ? null : () => _submitReview(context),
          child: Container(
            alignment: Alignment.center,
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Submitting Review...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Submit Review',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _submitReview(BuildContext context) {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate rating
    if (_currentRating == 0) {
      _showValidationError('Please provide a rating');
      return;
    }

    // Validate comment length
    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      _showValidationError('Please write a comment about your experience');
      return;
    }

    if (comment.length < 10) {
      _showValidationError('Please write at least 10 characters');
      return;
    }

    if (comment.length > 1000) {
      _showValidationError(
          'Comment is too long. Please keep it under 1000 characters');
      return;
    }

    // Submit review with proper data
    final cubit = context.read<ReviewCubit>();
    cubit.rating = _currentRating;
    cubit.reviewComment.text = comment;
    cubit.createReview(widget.serviceId);
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.white),
            SizedBox(width: 8.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessMessage() {
    // Clear form data
    _commentController.clear();
    setState(() {
      _currentRating = 0;
    });

    // Close bottom sheet and get the parent context
    Navigator.pop(context);

    // Refresh reviews list
    widget.onReviewAdded(widget.serviceId);

    // Show enhanced success message using the parent scaffold messenger
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.parentScaffoldMessenger.mounted) {
        widget.parentScaffoldMessenger.showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Icon(Icons.check_circle,
                      color: Colors.white, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Review Submitted!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        'Thank you for your feedback',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            duration: Duration(seconds: 4),
            margin: EdgeInsets.all(16.w),
          ),
        );
      }
    });
  }

  void _showErrorMessage(String error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.parentScaffoldMessenger.mounted) {
        widget.parentScaffoldMessenger.showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Icon(Icons.error_rounded,
                      color: Colors.white, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Submission Failed',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        error.length > 100
                            ? '${error.substring(0, 100)}...'
                            : error,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            duration: Duration(seconds: 5),
            margin: EdgeInsets.all(16.w),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () => _submitReview(context),
            ),
          ),
        );
      }
    });
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.5) return Colors.green;
    if (rating >= 3.5) return Colors.amber;
    if (rating >= 2.5) return Colors.orange;
    return Colors.red;
  }

  IconData _getRatingIcon(double rating) {
    if (rating >= 4.5) return Icons.sentiment_very_satisfied_rounded;
    if (rating >= 3.5) return Icons.sentiment_satisfied_rounded;
    if (rating >= 2.5) return Icons.sentiment_neutral_rounded;
    return Icons.sentiment_dissatisfied_rounded;
  }

  String _getRatingText(double rating) {
    if (rating >= 4.5) return 'Excellent';
    if (rating >= 3.5) return 'Good';
    if (rating >= 2.5) return 'Average';
    return 'Poor';
  }
}
