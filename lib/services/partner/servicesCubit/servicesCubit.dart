import 'dart:convert';

import 'package:PassPort/models/partner/rooms/addRoom.dart';
import 'package:PassPort/models/partner/rooms/room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';
import 'package:PassPort/models/partner/ServicesModel.dart';
import 'package:PassPort/models/partner/servicesByid/servicesById.dart';
import 'package:PassPort/services/partner/servicesCubit/servicesStates.dart';
import 'package:http/http.dart' as http;

final storage = new FlutterSecureStorage();

class ServicesCubit extends Cubit<ServicesStates> {
  ServicesCubit() : super(ServicesInitial());
  Api _api = Api();
  ServicesModel? servicesModel;
  TextEditingController roomNumber = TextEditingController();
  TextEditingController priceNumber = TextEditingController();

  getServices({required int val}) async {
    emit(ServicesLoading());
    var token = await storage.read(key: "token");
    var url =
        val == 0 ? _api.addService : _api.addService + "?status=${val - 1}";
    var request = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    var databody = json.decode(request.body);
    print(databody);
    if (request.statusCode == 200) {
      servicesModel = ServicesModel.fromJson(databody);
      emit(ServicesSuccess());
    } else {
      emit(ServicesError(databody['message'] ?? "error"));
    }
  }

  GetServicesByIdPartner? getServicesByIdPartner;

  /// services By Id
  void getServicesById(String id) async {
    emit(getServicesByIdLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response = await ApiConsumer()
        .get(uri: "${Api().getServicesById + id}", token: token);
    var responseData = await json.decode(response.body);
    print(responseData);
    if (response.statusCode == 200) {
      getServicesByIdPartner = GetServicesByIdPartner.fromJson(responseData);
      print(getServicesByIdPartner?.data);
      emit(getServicesByIdSuccessful());
    } else {
      print(response.body);
      emit(getServicesByIdError(response.body));
    }
  }

  ///
  ///
  GetRoomsAccomandtionModel? getRoomsAccomandtionModel;
  void getRoomsAccomantion({
    required String id,
  }) async {
    emit(getRoomPartnerLoading());
    final token = await storage.read(key: 'token');

    http.Response response = await ApiConsumer().get(
        uri: "${Api.API_URL}Rooms/GetRoomsInAcc?RoomTypeId=$id", token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      getRoomsAccomandtionModel =
          GetRoomsAccomandtionModel.fromJson(responseData);
      emit(getRoomPartnerSuccessful());
    } else {
      print(response.body);
      emit(getRoomPartnerError(response.body));
    }
  }

  /// add room

  Future<void> registerRoom(
      {required RoomPartner room, required String id}) async {
    final token = await storage.read(key: 'token');
    final url = '${Api.API_URL}Rooms/RegisterRooms?RoomTypeId=$id';

    try {
      emit(RegisterRoomLoading());
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(room.toJson()),
      );
      var jsonBody = json.decode(response.body);

      if (response.statusCode == 200) {
        // Handle success
        emit(RegisterRoomLoaded());

        print('Room registered successfully');
      } else {
        // Handle error
        //print('Failed to register room: ${response.statusCode}');
        emit(RegisterRoomError(jsonBody['message']));
      }
    } catch (e) {
      // Handle exception
      emit(RegisterRoomError('Error occurred: $e'));
    }
  }
}
