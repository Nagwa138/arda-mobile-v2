import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';

import 'package:http/http.dart' as http;
import 'package:PassPort/models/traveller/trips_model/gettripebyid_model.dart';
import 'package:PassPort/models/traveller/trips_model/trips_model.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/trips_cubit/trips_state.dart';

class TripsCubit extends Cubit<TripsStates> {
  TripsCubit() : super(TripsInitial());
  static TripsCubit get(context) => BlocProvider.of(context);
  final storage = new FlutterSecureStorage();
  TextEditingController nameSupervisor = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameTrips = TextEditingController();
  TextEditingController aboutTrips = TextEditingController();
  TextEditingController toGo = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController specialNotesOrRequests = TextEditingController();
  TextEditingController estimatedBudgetPerPerson = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController tripType = TextEditingController();

  GetAllTripsModel? tripsModel;
  GetTripsByIdModel? tripsByIdModel;

  void getAllTrips() async {
    emit(GetTripsLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().getAllTrips, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      tripsModel = GetAllTripsModel.fromJson(responseData);
      print(tripsModel?.data?.length);
      emit(GetTripsSuccessful());
    } else {
      print(response.body);
      emit(GetTripsError(error: response.body));
    }
  }

  /// get trips by Id
  void getAllTripById({required String id}) async {
    emit(GetTripByIdLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().getTripsById + id, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      tripsByIdModel = GetTripsByIdModel.fromJson(responseData);
      emit(GetTripByIdSuccessful());
    } else {
      print(response.body);
      emit(GetTripByIdError(error: response.body));
    }
  }

  /// create trips
  void createTrips({required String NumOfPerson}) async {
    emit(CreateTripLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    print("name : ${nameTrips.text.trim()}");
    print("date : ${date.text.trim()}");

    // Send as Form Data directly
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    http.Response response = await http.post(
      Uri.parse(Api().addTrips),
      body: {
        'Name': nameTrips.text.trim(),
        'Date': date.text.trim(),
        'To': toGo.text.trim(),
        'NumOfPersons': NumOfPerson,
        'Description': aboutTrips.text.trim(),
        'Supervisor': nameSupervisor.text.trim(),
        'SpecialNotesOrRequests': specialNotesOrRequests.text.trim(),
        'EstimatedBudgetPerPerson': estimatedBudgetPerPerson.text.trim(),
        'MobileNumber': mobileNumber.text.trim(),
        'TripType': tripType.text.trim(),
      },
      headers: headers,
    );

    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData);
      emit(CreateTripSuccessful());
    } else {
      print(response.body);
      emit(CreateTripError(error: responseData['message']));
    }
  }

  void addFavouriteOfTrips({required String tripId}) async {
    emit(AddFavouriteOfTripsLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response = await http.post(
        Uri.parse(
          "${Api().addFavouriteTrips + tripId}",
        ),
        headers: {'Authorization': 'Bearer $token'});
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData);
      emit(AddFavouriteOfTripsSuccessful());
    } else {
      print(response.body);
      emit(AddFavouriteOfTripsError(error: response.body));
    }
  }

  /// delete Favourite From Trips
  void deleteFavouriteOfTrips({required String tripId}) async {
    emit(deleteFavouriteOfTripsLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person  = $token");
    http.Response response = await http.delete(
        Uri.parse(
          "${Api().deleteFavouriteTrips + tripId}",
        ),
        headers: {'Authorization': 'Bearer $token'});
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData);
      emit(deleteFavouriteOfTripsSuccessful());
    } else {
      print(response.body);
      emit(deleteFavouriteOfTripsError(error: response.body));
    }
  }

  void changeFav(value) {
    tripsByIdModel?.data?.fav = !value;
    emit(FavChange());
  }

  void PickDate(
      {context,
      required TextEditingController controller,
      required DateTime firstTime,
      required DateTime lastTime}) async {
    emit(PickDateBlocLoading());
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstTime,
      lastDate: lastTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );

    if (pickDate != null) {
      controller.text = pickDate.toString().split(" ")[0];
    }
    emit(PickDateBlocSSuccessfulState());
  }

  /// Clear all form fields
  void clearFormFields() {
    nameTrips.clear();
    aboutTrips.clear();
    toGo.clear();
    date.clear();
    nameSupervisor.clear();
    specialNotesOrRequests.clear();
    estimatedBudgetPerPerson.clear();
    mobileNumber.clear();
    tripType.clear();
  }

  ///
}
