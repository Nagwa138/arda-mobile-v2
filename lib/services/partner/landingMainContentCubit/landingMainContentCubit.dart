import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';
import 'package:PassPort/models/partner/getAllGuests/getGuestById.dart';
import 'package:PassPort/models/partner/getAllGuests/getGuestById.dart';
import 'package:PassPort/models/partner/getAllGuests/getallGuest.dart';

import 'landingMainContentStates.dart';
import 'package:http/http.dart' as http;

class LandingMainContentCubit extends Cubit<LandingMainContentStates> {
  LandingMainContentCubit() : super(LandingMainContentInitial());

  static LandingMainContentCubit get(context) => BlocProvider.of(context);

  int toggle = 0;
  final storage = new FlutterSecureStorage();
  getAllGuestModel? guestModel;

  getAllGuestModel? upComingModel;

  getAllGuestModel? completeModel;
  getAllGuestModel? cancelModel;
  GetGuestByIdModel? guestByIdModel;
  String takePagention = "6";
  String skip = "0";

// ScrollController allAcademyScrollController = ScrollController();
  //
  // checkAllScrollController() {
  //   allAcademyScrollController.addListener(() {
  //     print(pageIndex);
  //
  //     if (allAcademyScrollController.position.pixels == allAcademyScrollController.position.maxScrollExtent) {
  //       pageIndex++;
  //       print('end of the page');
  //       GetStudentsAcademy();
  //     }
  //   });

  Future load() async {
    await getAllGuests("0");
    await getAllGuests("1");
    await getAllGuests("2");
    await getAllGuests("3");
  }

  void toggleServices(int index) {
    toggle = index;
    emit(ToggleServicesSucsses());
  }

  ///

  int calculateDifference({required String startDateStr, required String endDateStr}) {
    DateTime start = DateTime.parse(startDateStr);
    DateTime end = DateTime.parse(endDateStr);

    final difference = end.difference(start).inDays;
    return difference;
  }


  /// get all Guests
  Future getAllGuests(String? state) async {

      emit(getAllGuestLoadingState());
      final token = await storage.read(key: 'token');
      print("tokn is person partner = $token");
      http.Response response = await ApiConsumer().get(
          uri: Api.API_URL +
              "Booking/GetMyRequests?status=$state&skip=0&take=$takePagention",
          token: token);
      var responseData = await json.decode(response.body);
      if (response.statusCode == 200) {
        if(state == "0"){
          guestModel = getAllGuestModel.fromJson(responseData);
          print("*************************************************${guestModel?.data?.length}");

        }
        else if (state == "1"){
          upComingModel = getAllGuestModel.fromJson(responseData);
          print("*************************************************${upComingModel?.data?.length}");
        }
        else if (state == "2"){
          completeModel = getAllGuestModel.fromJson(responseData);
          print("*************************************************${completeModel?.data?.length}");
        }
        else if (state == "3"){
          cancelModel = getAllGuestModel.fromJson(responseData);
          print("*************************************************${cancelModel?.data?.length}");
        }
        emit(getAllGuestSuccessfulState());
      } else {
        emit(getAllGuestErrorState(error: response.body));
      }

  }

  ///
  Future getAllGuestsShowAll(String? state) async {

    emit(getAllGuestShowAllLoadingState());
    final token = await storage.read(key: 'token');
    print("tokn is person partner = $token");
    http.Response response = await ApiConsumer().get(
        uri: Api.API_URL +
            "Booking/GetMyRequests?status=$state&skip=0&take=$takePagention",
        token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {

        guestModel = getAllGuestModel.fromJson(responseData);
        print("*************************************************${guestModel?.data?.length}");

      emit(getAllGuestShowAllSuccessfulState());
    } else {
      emit(getAllGuestShowAllErrorState(error: response.body));
    }

  }


  /// get all Upcoming



  ///
  void getGuestById({required String id}) async {
    emit(getGuestByIdLoadingCancel());
    final token = await storage.read(key: 'token');
    print("tokn is person partner = $token");
    http.Response response = await ApiConsumer().get(
        uri: "${Api.API_URL}Booking/GetGetOnePendingRequests/$id",
        token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      guestByIdModel = GetGuestByIdModel.fromJson(responseData);
      emit(getGuestByIdSuccessfulCancel());
    }
    else{
      emit(getGuestByIdErrorCancel(error: responseData['message']));
    }
  }


  ///
  void acceptBooking({required String id}) async {
    emit(AcceptLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person partner = $token");
    http.Response response = await ApiConsumer().post(
        uri: "${Api.API_URL}Booking/AcceptBooking?id=$id",
        token: token, rawData: {

    });
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {

      emit(AcceptSuccessful());
    }
    else{
      emit(AcceptError(error: responseData['message']));
    }
  }

  ///
  void rejectBooking({required String id}) async {
    emit(RejectLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person partner = $token");
    http.Response response = await ApiConsumer().post(
        uri: "${Api.API_URL}Booking/CancelBookingByPartner?id=$id",
        token: token, rawData: {

    });
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {

      emit(RejectSuccessful());
    }
    else{
      emit(RejectError(error: responseData['message']));
    }
  }





  @override
  void onChange(Change<LandingMainContentStates> change) {
    // TODO: implement onChange
    print(change);
    super.onChange(change);
  }
}
