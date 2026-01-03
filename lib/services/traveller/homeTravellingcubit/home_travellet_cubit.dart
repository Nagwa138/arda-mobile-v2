import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';
import 'package:PassPort/models/traveller/accomandating/randomAccomandtion.dart';
import 'package:PassPort/models/traveller/activity/activity_random_model.dart';
import 'package:PassPort/models/traveller/blog/blocCategory.dart';
import 'package:PassPort/models/traveller/blog/blog_model.dart';
import 'package:PassPort/models/traveller/blog/blogbyid_model.dart';
import 'package:PassPort/models/traveller/blog/getallblog_model.dart';
import 'package:PassPort/models/traveller/randomProduct/random_product.dart';
import 'package:PassPort/models/traveller/top_rated/top_rated.dart';

import 'home_traveller_state.dart';
import 'package:http/http.dart' as http;

class HomeTravellerCubit extends Cubit<HomeTravellerState> {
  HomeTravellerCubit() : super(HomeTravellerInitial());
  static HomeTravellerCubit get(context) => BlocProvider.of(context);
  final storage = new FlutterSecureStorage();
  BlogModel? blogModel;
  BlogCategoryModel? blogCategoryModel;
  GetAllBlogModel? getAllBlogModel;
  GetBlogByIdModel? blogByIdModel;
  TopRatedModel? ratedModel;
  RandomProductModel? modelProduct;
  AccomandationRandomModel? randomModelHotel;
  final ScrollController scrollController = ScrollController();
  randomActivityModel? randomModel;

  //

  void scrollLeft(double width) {
    scrollController.animateTo(
      scrollController.offset - width,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollRight(double width) {
    scrollController.animateTo(
      scrollController.offset + width,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future load() async {
    await getCategoryBlog();
    await topRated();
    await randomActivity();
    await randomCamp();
    await randomHotel();
  }

  /// get Blog
  void changeFav(value) {
    blogByIdModel?.data?.isFavourite = !value;
    emit(FavChange());
  }

  void changeFavRated(value, int i) {
    ratedModel?.data?[i].isFav = !value;
    emit(FavChangeRated());
  }

  Future getCategoryBlog() async {
    emit(getCategoryBlogLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().blogCategory, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      blogCategoryModel = BlogCategoryModel.fromJson(responseData);

      emit(getCategoryBlogSuccessful());
    } else {
      print(response.body);
      emit(getCategoryBlogError(error: response.body));
    }
  }

  ///
  void getBloc({required String categoryId}) async {
    emit(getBlocLoading());
    final token = await storage.read(key: 'token');
    print("response.body = ${Api().blog + categoryId}");
    http.Response response =
        await ApiConsumer().get(uri: Api().blog + categoryId, token: token);
    print("response.body = ${response.body}");
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      getAllBlogModel = GetAllBlogModel.fromJson(responseData);
      print(getAllBlogModel?.data?.length);
      emit(getBlocByIdSuccessful());
    } else {
      print(response.body);
      emit(getBlocError(error: response.body));
    }
  }

  /// get Blog By ID
  void getBlogById(String id) async {
    emit(getBlocByIdLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response =
        await ApiConsumer().get(uri: "${Api().blogById + id}", token: token);
    var responseData = await json.decode(response.body);
    print(responseData);
    if (response.statusCode == 200) {
      blogByIdModel = GetBlogByIdModel.fromJson(responseData);
      print(blogModel?.data?.length);
      emit(getBlocByIdSuccessful());
    } else {
      print(response.body);
      emit(getBlocByIdError(error: response.body));
    }
  }

  /// post blog Favourite
  void postBlogFavourite(String id) async {
    emit(postFavouriteLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response = await http.post(
        Uri.parse(
          "${Api().blogFav + id}",
        ),
        headers: {'Authorization': 'Bearer $token'});
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData);
      emit(postFavouriteSuccessful());
    } else {
      print(response.body);
      emit(postFavouriteError(error: response.body));
    }
  }

  /// delete Favourite

  void deleteFavourite(String id) async {
    emit(deleteFavouriteLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response = await ApiConsumer()
        .delete(uri: "${Api().deleteFav + id}", token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData);
      emit(deleteFavouriteSuccessful());
    } else {
      print(response.body);
      emit(deleteFavouriteError(error: response.body));
    }
  }

  /// top rated
  Future topRated() async {
    emit(TopRatedLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().topRated, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      ratedModel = TopRatedModel.fromJson(responseData);
      emit(TopRatedSuccessful());
    } else {
      print(response.body);
      emit(TopRatedError(error: response.body));
    }
  }

  /// activity random
  Future randomActivity() async {
    emit(RandomActivityLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().randomActivity, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      randomModel = randomActivityModel.fromJson(responseData);
      emit(RandomActivitySuccessful());
    } else {
      print(response.body);
      emit(RandomActivityError(error: response.body));
    }
  }

  /// random Camp
  Future randomCamp() async {
    emit(RandomCampLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().randomProduct, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      modelProduct = RandomProductModel.fromJson(responseData);
      emit(RandomCampSuccessful());
    } else {
      print(response.body);
      emit(RandomCampError(error: response.body));
    }
  }

  /// random accomandtion Hotel
  Future randomHotel() async {
    emit(RandomHotelLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().randomHotel, token: token);
    var responseData = await json.decode(response.body);
    print('---\n ${response.body}');
    if (response.statusCode == 200) {
      randomModelHotel = AccomandationRandomModel.fromJson(responseData);
      print('---\n ${randomModelHotel}');
      emit(RandomHotelSuccessful());
    } else {
      print(response.body);
      emit(RandomHotelError(error: response.body));
    }
  }
}
