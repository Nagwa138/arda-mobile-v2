import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';


import 'package:http/http.dart' as http;
import 'package:PassPort/models/traveller/favourite_model/accomandation_model.dart';
import 'package:PassPort/models/traveller/favourite_model/activity_model_favourite.dart';
import 'package:PassPort/models/traveller/favourite_model/product_favourite_model.dart';
import 'package:PassPort/models/traveller/favourite_model/trip_favourite_model.dart';

import 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  static FavouriteCubit get(context) => BlocProvider.of(context);
  final storage = new FlutterSecureStorage();
  GetFavouriteModelAccomandation? accomandation;
  GetFavouriteModelActivity? activity;
  GetFavouriteModelProduct? product;
  GetFavouriteModelTrip?  trip;


  /// get all information
  void getAllFavourite({required String state}) async {

      emit(GetAllFavouriteLoading());
      final token = await storage.read(key: 'token');
      print("tokn is person user = $token");
      http.Response response = await ApiConsumer().get(uri: Api().getAllFavourite + state, token: token);
      var responseData = await json.decode(response.body);
      if (response.statusCode == 200) {
        if(state == '0'){
          accomandation = GetFavouriteModelAccomandation.fromJson(responseData);
          print("*****************${accomandation?.data?.length}");
        }
        else if(state == '1'){
          product = GetFavouriteModelProduct.fromJson(responseData);
          print("++++++++++++++++${product?.data?.length}");

        }
        else if(state == '2'){
          trip = GetFavouriteModelTrip.fromJson(responseData);
          print("------------${trip?.data?.length}");
        }
        else if(state == '3'){
          activity = GetFavouriteModelActivity.fromJson(responseData);
          print("++++++++++++++++++${activity?.data?.length}");

        }
        emit(GetAllFavouriteSuccessful());
      } else {
        print(response.body);
        emit(GetAllFavouriteError(error: response.body));
      }
    }




}
