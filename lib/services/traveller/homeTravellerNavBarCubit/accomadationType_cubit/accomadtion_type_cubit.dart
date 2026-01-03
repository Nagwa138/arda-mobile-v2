import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';
import 'package:PassPort/models/traveller/accomandating/accomadingBasedonTypeModel.dart';
import 'package:PassPort/models/traveller/accomandating/accomandtionByIdone.dart';
import 'package:PassPort/models/traveller/accomandating/accomonsting.dart';
import 'package:PassPort/models/traveller/favourite_model/accomandation_model.dart';

import 'acommedtion_type_state.dart';

class AccommodatingCubit extends Cubit<AccommodatingState> {
  AccommodatingCubit() : super(AccommodatingInitial());
  static AccommodatingCubit get(context) => BlocProvider.of(context);
  final storage = new FlutterSecureStorage();
  GetAllAccommodatingModel? getAllAccommodatingModel;
  GetAccomaondationBasedTypeModel? accomaondationBasedTypeModelHotel;
  GetAccomaondationBasedTypeModel? accomaondationBasedTypeModelCamp;
  AccomandtionByIdModelone? accomandtionByIdModel;
  GetAccomaondationBasedTypeModel? filtertionModel;

  void changeFavHotel(value) {
    accomandtionByIdModel?.data?.isFav = !value;
    emit(FavChangeHotel());
  }

  /// get Accommodating
  var camp;
  var hotel;

  TextEditingController search = TextEditingController();
  TextEditingController searchAccomandtion = TextEditingController();
  TextEditingController searchCamp = TextEditingController();

  void accomandation() async {
    await getAllAccommodating();
    await getAllAccommodatingBasedTypeCamp(
        accomondatonIdCamp:
            getAllAccommodatingModel!.data![camp].id.toString());
    //await getAllAccommodatingBasedTypeHotel(accomondatonIdHotel: getAllAccommodatingModel!.data![hotel].id.toString());
  }

  Future getAllAccommodating() async {
    emit(GetAccommodatingLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    var response =
        await ApiConsumer().get(uri: Api().getAllAccommodating, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      getAllAccommodatingModel =
          GetAllAccommodatingModel.fromJson(responseData);
      camp = await getAllAccommodatingModel!.data!
          .indexWhere((element) => element.name == 'Camp');
      hotel = await getAllAccommodatingModel!.data!
          .indexWhere((element) => element.name != 'Camp');
      print(getAllAccommodatingModel?.data?.length);
      print("hotel${hotel}");
      emit(GetAccommodatingSuccessful());
    } else {
      print(response.body);
      emit(GetAccommodatingError(error: response.body));
    }
  }

  /// get Accommodating Based Type

  Future getAllAccommodatingBasedTypeHotel(
      {required String accomondatonIdHotel}) async {
    emit(GetAccommodatingBasedTypeLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    var response = await ApiConsumer().get(
        uri: search.text.trim().isEmpty
            ? Api().getAllAccommodatingType + accomondatonIdHotel
            : "${Api.API_URL}Accomodation/Traveller/GetAllAccomodation?id=$accomondatonIdHotel&searchQuery=${search.text.trim()}",
        token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      //getAllAccommodatingModel = GetAllAccommodatingModel.fromJson(responseData);
      accomaondationBasedTypeModelHotel =
          GetAccomaondationBasedTypeModel.fromJson(responseData);
      print(
          "**************++++++++++++${accomaondationBasedTypeModelHotel?.data?.length}");
      emit(GetAccommodatingBasedTypeSuccessful());
    } else {
      print(response.body);
      emit(GetAccommodatingBasedTypeError(error: response.body));
    }
  }

  Future getAllAccommodatingBasedTypeCamp(
      {required String accomondatonIdCamp}) async {
    emit(GetAccommodatingBasedTypeCampLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    var response = await ApiConsumer().get(
        uri: searchCamp.text.trim().isEmpty
            ? Api().getAllAccommodatingType + accomondatonIdCamp
            : "${Api.API_URL}Accomodation/Traveller/GetAllAccomodation?id=$accomondatonIdCamp&searchQuery=${searchCamp.text.trim()}",
        token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      //getAllAccommodatingModel = GetAllAccommodatingModel.fromJson(responseData);
      accomaondationBasedTypeModelCamp =
          GetAccomaondationBasedTypeModel.fromJson(responseData);
      print("**************${accomaondationBasedTypeModelCamp?.data?.length}");
      emit(GetAccommodatingBasedTypeSuccessfulCamp());
    } else {
      print(response.body);
      emit(GetAccommodatingBasedTypeErrorCamp(error: response.body));
    }
  }

  /// get one Accomandtion By Id

  Future getOneAccommodating({required String oneAccomandationPrivate}) async {
    emit(GetOneAccommodatingLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    var response = await ApiConsumer().get(
        uri: Api().getOneAccommodatingTypeById + oneAccomandationPrivate,
        token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      accomandtionByIdModel = AccomandtionByIdModelone.fromJson(responseData);

      print(
          "////////////////////////////////////////////////////////////${accomandtionByIdModel?.data?.isFav}");
      emit(GetOneAccommodatingSuccessful());
    }
  }

  void addFavouriteOfAccommodating({required String AccomId}) async {
    emit(AddFavouriteOfAccomandationLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response = await http.post(
        Uri.parse(
          "${Api().addFavouriteOfAccomandation + AccomId}",
        ),
        headers: {'Authorization': 'Bearer $token'});
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData);
      emit(AddFavouriteOfAccomandationSuccessful());
    } else {
      print(response.body);
      emit(AddFavouriteOfAccomandationError(error: response.body));
    }
  }

  /// delete Favourite From Product
  void deleteFavouriteOfAccommodating({required String AccomId}) async {
    emit(deleteFavouriteOfAccomandationLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person  = $token");
    http.Response response = await http.delete(
        Uri.parse(
          "${Api().deleteFavouriteOfAccomandation + AccomId}",
        ),
        headers: {'Authorization': 'Bearer $token'});
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData);
      emit(deleteFavouriteOfAccomandationSuccessful());
    } else {
      print(response.body);
      emit(deleteFavouriteOfAccomandationError(error: response.body));
    }
  }

  GetFavouriteModelAccomandation? accomandationModelFavourite;

  void getAllFavouriteAccomandtion() async {
    emit(GetAllFavouriteAccomandationLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person user = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().getAllFavourite + "0", token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      accomandationModelFavourite =
          GetFavouriteModelAccomandation.fromJson(responseData);

      emit(GetAllFavouriteAccomandationSuccessful());
    } else {
      print(response.body);
      emit(GetAllFavouriteAccomandationError(response.body));
    }
  }

  /// search filtertion
  Future getFiltertion() async {
    emit(GetFiltertionLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    var response = await ApiConsumer().get(
        uri:
            "${Api.API_URL}Accomodation/Traveller/HomeAccomodationFilter?searchQuery=${searchAccomandtion.text.trim()}&skip=0&take=10",
        token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      filtertionModel = GetAccomaondationBasedTypeModel.fromJson(responseData);

      print(
          "////////////////////////////////////////////////////////////${accomandtionByIdModel?.data?.serviceName}");
      emit(GetFiltertionSuccessful());
    }
  }
}

  ///





