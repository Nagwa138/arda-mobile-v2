import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';
import 'package:PassPort/models/traveller/getAllReviews.dart';
import 'package:PassPort/models/traveller/review/reviewModel.dart';

import 'package:PassPort/services/traveller/review_cubit/review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());
  static ReviewCubit get(context) => BlocProvider.of(context);
  GetAllReviewModel? getAllReviewModel;
  getAllReviews? reviews;

  final storage = new FlutterSecureStorage();
  var rating;
  TextEditingController reviewComment = TextEditingController();

  /// get all review
  void getReview({required String reviewId, required String typeReview}) async {
    emit(GetReviewLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response = await ApiConsumer().get(
        uri: Api().getReview + reviewId + "&reviewType=$typeReview",
        token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      getAllReviewModel = GetAllReviewModel.fromJson(responseData);
      emit(GetReviewSuccessful());
    }
  }

  void getReviewAll({required String reviewId}) async {
    emit(GetReviewLoadingAll());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response = await ApiConsumer()
        .get(uri: Api().getReviewAll + reviewId, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      reviews = getAllReviews.fromJson(responseData);
      emit(GetReviewSuccessfulAll());
    } else {
      emit(GetReviewErrorAll(error: response.body));
    }
  }

  /// create review with enhanced validation and error handling
  Future<void> createReview(String id) async {
    try {
      // Validate inputs
      if (!_validateReviewInput()) {
        return;
      }

      emit(CreateReviewLoading());

      final token = await storage.read(key: 'token');
      if (token == null) {
        emit(CreateReviewError(
            error: "Authentication required. Please login again."));
        return;
      }

      print("🔑 Token retrieved successfully");

      Map<String, dynamic> data = {
        'comment': reviewComment.text.trim(),
        'rate': rating,
        'serviceId': id,
      };

      String jsonBody = jsonEncode(data);
      String url = "${Api.API_URL}Reviews/AddReview";

      print("📤 Submitting review to: $url");
      print(
          "📤 Review data: ${data.toString().replaceAll(RegExp(r'Bearer \w+'), 'Bearer ***')}");

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonBody,
      );

      print("📥 Create review response status: ${response.statusCode}");
      print("📥 Create review response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Review created successfully");
        emit(CreateReviewSuccessful());
      } else {
        var responseData = json.decode(response.body);
        final errorMessage = responseData['message'] ??
            responseData['errors']?.toString() ??
            'Failed to submit review';
        print("❌ Failed to create review: $errorMessage");
        emit(CreateReviewError(error: errorMessage));
      }
    } catch (e) {
      print("💥 Exception while creating review: $e");
      emit(CreateReviewError(
          error: "Network error. Please check your connection and try again."));
    }
  }

  /// Validate review input
  bool _validateReviewInput() {
    if (rating == null || rating! <= 0) {
      emit(CreateReviewError(error: "Please provide a rating"));
      return false;
    }

    if (reviewComment.text.trim().isEmpty) {
      emit(CreateReviewError(
          error: "Please write a comment about your experience"));
      return false;
    }

    if (reviewComment.text.trim().length < 10) {
      emit(CreateReviewError(error: "Please write at least 10 characters"));
      return false;
    }

    if (reviewComment.text.trim().length > 1000) {
      emit(CreateReviewError(
          error: "Comment is too long. Please keep it under 1000 characters"));
      return false;
    }

    return true;
  }
}



// Assuming your cubit method to make the HTTP request



