import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';
import 'package:PassPort/models/traveller/activity/activity_id_model.dart';
import 'package:PassPort/models/traveller/activity/get_all_activity.dart';

import 'activity_stata.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitial());
  static ActivityCubit get(context) => BlocProvider.of(context);
  final storage = new FlutterSecureStorage();
  GetAllActivity? getAllActivityModel;
  bool favourite = false;
  GetActivityByIdModel? getActivityByIdModel;

  void changeFavourite(value) {
    getActivityByIdModel?.data?.isFav = !value;
    emit(FavouriteChange());
  }

  /// get All Activity
  void getAllActivity() async {
    emit(GetActivityLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().getAllActivity, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      getAllActivityModel = GetAllActivity.fromJson(responseData);
      print(getAllActivityModel?.data?.length);
      emit(GetActivitySuccessful());
    } else {
      print(response.body);
      emit(GetActivityError(error: response.body));
    }
  }

  /// add Favourite activity
  void getActivityById({required String activityId}) async {
    emit(GetActivityByIdLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    http.Response response = await ApiConsumer()
        .get(uri: Api().getActivityById + activityId, token: token);

    // Check if response body is not empty before decoding
    if (response.body.isEmpty) {
      print("Response body is empty");
      emit(GetActivityByIdError(error: "Empty response from server"));
      return;
    }

    if (response.statusCode == 200) {
      try {
        var responseData = json.decode(response.body);
        getActivityByIdModel = GetActivityByIdModel.fromJson(responseData);
        print(getActivityByIdModel?.data);
        emit(GetActivityByIdSuccessful());
      } catch (e) {
        print("Error parsing JSON: $e");
        print("Response body: ${response.body}");
        emit(GetActivityByIdError(error: "Invalid response format: $e"));
      }
    } else {
      print("Error status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      emit(GetActivityByIdError(
          error: response.body.isNotEmpty
              ? response.body
              : "Server error: ${response.statusCode}"));
    }
  }

  void addFavouriteOfActivity({required String activityId}) async {
    emit(AddFavouriteOfActivityLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response = await http.post(
        Uri.parse(
          "${Api().addFavouriteOfActivity + activityId}",
        ),
        headers: {'Authorization': 'Bearer $token'});
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData);
      emit(AddFavouriteOfActivitySuccessful());
    } else {
      print(response.body);
      emit(AddFavouriteOfActivityError(error: response.body));
    }
  }

  /// delete Favourite activity
  void deleteFavouriteOfActivity({required String activityId}) async {
    emit(deleteFavouriteOfActivityLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person  = $token");
    http.Response response = await http.delete(
        Uri.parse(
          "${Api().deleteFavouriteOfActivity + activityId}",
        ),
        headers: {'Authorization': 'Bearer $token'});
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData);
      emit(deleteFavouriteOfActivitySuccessful());
    } else {
      print(response.body);
      emit(deleteFavouriteOfActivityError(error: response.body));
    }
  }
}
