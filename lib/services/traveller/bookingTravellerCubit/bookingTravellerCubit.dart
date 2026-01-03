import 'dart:convert';
import 'dart:developer';

import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';
import 'package:PassPort/models/traveller/booking/Room/booking_Room_Model.dart';
import 'package:PassPort/models/traveller/booking/accomandtion/bookingaccomandation_model.dart';
import 'package:PassPort/models/traveller/booking/accomandtion/detais/bookingDetails.dart';
import 'package:PassPort/models/traveller/booking/activity/bookingactivity_model.dart';
import 'package:PassPort/models/traveller/booking/activity/details/bookingdetaisactivity.dart';
import 'package:PassPort/models/traveller/booking/trips/bookingtrip_model.dart';
import 'package:PassPort/models/traveller/booking/trips/details/detailstripmodel.dart';
import 'package:PassPort/models/traveller/rooms/getAllroommodel.dart';
import 'package:PassPort/models/traveller/rooms/roomlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geideapay/geideapay.dart';
import 'package:http/http.dart' as http;

import 'bookingTravellerStates.dart';

class BookingTravellerCubit extends Cubit<BookingTravellerStates> {
  BookingTravellerCubit() : super(BookingTravellerInitial());
  static BookingTravellerCubit get(context) => BlocProvider.of(context);

  int toggle = 0;
  final storage = new FlutterSecureStorage();

  GetAllRoomModel? getAllAvailableRom;

  /// accomandation Models
  bookingAccomandationModel? pending;
  bookingAccomandationModel? upComing;
  bookingAccomandationModel? complete;
  bookingAccomandationModel? cancel;

  /// actvity Models

  bookingActivityModel? pendingActivity;
  bookingActivityModel? upComingActivity;
  bookingActivityModel? completeActivity;
  bookingActivityModel? cancelActivity;

  /// trips Models
  TripsModel? pendingTrips;
  TripsModel? completeTrips;
  TripsModel? upComingTrips;
  TripsModel? cancelTrips;

  /// detailsBooking Models

  detailsActivityModel? activityModelDetails;
  AccomandationDetailsModel? accomandationDetailsModel;
  TripsModelDetails? tripsDetailsModel;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController national = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController GuestNumber = TextEditingController();

  /// booking room
  TextEditingController phoneRoom = TextEditingController();
  TextEditingController specialRequests = TextEditingController();
  int nationalityType = 0;

  /// booking trips
  TextEditingController specialRequestsTrip = TextEditingController();
  TextEditingController numOfPersonsTrip = TextEditingController();
  TextEditingController numOfChildrenTrip = TextEditingController();

  /// booking Activity
  TextEditingController phoneActivity = TextEditingController();
  TextEditingController activityDate = TextEditingController();
  TextEditingController healthLimitations = TextEditingController();
  TextEditingController experienceInActivity = TextEditingController();
  TextEditingController specialRequestsActivity = TextEditingController();
  TextEditingController languagesActivity = TextEditingController();
  TextEditingController numOfGuestsActivity = TextEditingController();

  /// notification
  TextEditingController titleNotification = TextEditingController();
  TextEditingController contentNotification = TextEditingController();

  List<String> cancelReason = ["0", "1", "2", "3", "4"];

  List room = [];

  bool agreeCheck = false;

  String cancelre = "0";

  void replaceCancelReason(value) {
    cancelre = value;
    emit(ReplaceSuccessful());
  }

  ///
  int calculateDifference() {
    DateTime start = DateTime.parse(startDate.text);
    DateTime end = DateTime.parse(endDate.text);
    final difference = end.difference(start).inDays;
    return difference;
  }

  void changeNationalityType(value) {
    emit(CheckGenderLoading());
    nationalityType = value;
    emit(CheckGenderSuccessful());
  }

  void toggleBooking(int index) {
    toggle = index;
    emit(ToggleBookingSucsses());
  }

  /// Get All Booking

  void getAllBooking(
      {required String state, required String serviceName}) async {
    emit(getBookingLoading());
    final token = await storage.read(key: 'token');
    http.Response response = await ApiConsumer().get(
        uri: serviceName == "accommodations"
            ? "${Api().getAllBooking}=$state&ServiceName=accommodations"
            : serviceName == "activities"
                ? "${Api().getAllBooking}=$state&ServiceName=activities"
                : "${Api().getAllBooking}=$state&ServiceName=trips",
        token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      if (serviceName == "accommodations") {
        switch (state) {
          case "0":
            {
              pending = bookingAccomandationModel.fromJson(responseData);
              print("********************* pending ${pending?.data?.length}");
            }
            break;
          case "1":
            {
              upComing = bookingAccomandationModel.fromJson(responseData);
              print(
                  "********************* upcomming ${upComing?.data?.length}");
            }
            break;
          case "2":
            {
              complete = bookingAccomandationModel.fromJson(responseData);
              print("********************* complete ${complete?.data?.length}");
            }
            break;
          case "3":
            {
              cancel = bookingAccomandationModel.fromJson(responseData);
              print("********************* cancel ${cancel?.data?.length}");
            }
            break;
          default:
            print(' invalid entry');
        }
      } else if (serviceName == "activities") {
        switch (state) {
          case "0":
            {
              pendingActivity = bookingActivityModel.fromJson(responseData);
              print(
                  "********************* pending ${pendingActivity?.data?.length}");
            }
            break;
          case "1":
            {
              upComingActivity = bookingActivityModel.fromJson(responseData);
              print(
                  "********************* upComming ${upComingActivity?.data?.length}");
            }
            break;
          case "2":
            {
              completeActivity = bookingActivityModel.fromJson(responseData);
              print(
                  "********************* complete ${completeActivity?.data?.length}");
            }
            break;
          case "3":
            {
              cancelActivity = bookingActivityModel.fromJson(responseData);
              print(
                  "********************* cancel ${cancelActivity?.data?.length}");
            }
            break;
          default:
            print(' invalid entry');
        }
      } else if (serviceName == "trips") {
        switch (state) {
          case "0":
            {
              pendingTrips = TripsModel.fromJson(responseData);
            }
            break;
          case "1":
            {
              upComingTrips = TripsModel.fromJson(responseData);
            }
            break;
          case "2":
            {
              completeTrips = TripsModel.fromJson(responseData);
            }
            break;
          case "3":
            {
              cancelTrips = TripsModel.fromJson(responseData);
            }
        }
      }

      emit(getBookingByIdSuccessful());
    } else {
      print(response.body);
      emit(getBookingError(response.body));
    }
  }

  /// get Booking Details
  void getBookingDetails({required String id}) async {
    emit(getBookingDetailsLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response = await ApiConsumer()
        .get(uri: "${Api.API_URL}Booking/GetBookingById?id=$id", token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseData['data']['serviceType'] == "Accomodation") {
        accomandationDetailsModel =
            AccomandationDetailsModel.fromJson(responseData);
        print(
            "//////////////////////////////*${accomandationDetailsModel?.data?.location}");
      } else if (responseData['data']['serviceType'] == "Activity") {
        activityModelDetails = detailsActivityModel.fromJson(responseData);
        print(
            "//////////////////////////////*${activityModelDetails?.data?.serviceType}");
      } else if (responseData['data']['serviceType'] == "Trip") {
        tripsDetailsModel = TripsModelDetails.fromJson(responseData);
        print("**********dgfhghh******${tripsDetailsModel!.data}");
      }

      emit(getBookingDetailsSuccessful());
    } else {
      print(response.body);
      emit(getBookingDetailsError(response.body));
    }
  }

  /// create Booking
  void createBookingTrip({
    required String tripId,
    required int numOfPersons,
    required String name,
    required String phone,
    required int numberOfChildren,
    required String specialRequests,
  }) async {
    emit(CreateBookingLoading());
    var token = await storage.read(key: 'token');

    try {
      http.Response response = await ApiConsumer().post(
          uri: Api().createBookingTrip,
          rawData: {
            'name': name,
            'phone': phone,
            'numOfPersons': numOfPersons,
            'tripId': tripId,
            'numberOfChildren': numberOfChildren,
            'specialRequests': specialRequests,
          },
          token: token);

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        print(response.body);
        emit(CreateBookingSuccessful());
      } else {
        // Handle error response
        String errorMessage;
        try {
          var jsonBody = json.decode(response.body);
          errorMessage = jsonBody['message'] ?? response.body;
        } catch (e) {
          // If response is plain text (not JSON)
          errorMessage = response.body;
        }

        print("Error: $errorMessage");
        emit(CreateBookingError(errorMessage));
      }
    } catch (e) {
      print("Exception in createBookingTrip: $e");
      emit(CreateBookingError(e.toString()));
    }
  }

  ///
  void PickDate({
    required BuildContext context,
    DateTime? initial,
    required TextEditingController controller,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    emit(PickDateBlocLoading());

    // ضبط التاريخ المبدئي بطريقة آمنة
    DateTime now = DateTime.now();
    DateTime safeInitial = initial ?? now;

    if (safeInitial.isBefore(firstDate)) safeInitial = firstDate;
    if (safeInitial.isAfter(lastDate)) safeInitial = lastDate;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: safeInitial,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primaryContainer: appBackgroundColor,
              primary: accentColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
              surface: appBackgroundColor,
            ),
            dialogTheme: DialogThemeData(backgroundColor: appBackgroundColor),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(1.0)),
            child: child!,
          ),
        );
      },
    );

    if (pickedDate != null) {
      // تنسيق التاريخ بشكل أنيق وواضح
      final formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

      controller.text = formattedDate;
    }

    emit(PickDateBlocSSuccessfulState());
  }

  ///
  void getAllRoomAvailable(
      {required String id,
      required String startDate,
      required String endDate,
      required roomType}) async {
    emit(getRoomLoading());
    final token = await storage.read(key: 'token');

    http.Response response = await ApiConsumer().get(
        uri:
            "${Api.API_URL}Rooms/GetAvailableRooms?accomodationId=$id&start=$startDate&end=$endDate&roomType=$roomType",
        token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      getAllAvailableRom = GetAllRoomModel.fromJson(responseData);
      print(
          "getRoomModelPending?.data?.length${getAllAvailableRom?.data?.length}");

      emit(getRoomByIdSuccessful());
    } else {
      print(response.body);
      emit(getRoomError(response.body));
    }
  }

  ///  create Booking Room
  void agree(value) {
    agreeCheck = value;
    emit(AgrreCheckSuccessful());
  }

  Future<void> bookRoom({
    required List<RoomList> room,
    required String start,
    required String end,
    required String phone,
    required String specialRequests,
    required int numberOfAdult,
    required int numberOfChildern,
    required int nationalityType,
  }) async {
    emit(CreateBookingRoomLoading());

    final url = Uri.parse('${Api.API_URL}Booking/BookRoom');
    var token = await storage.read(key: "token");
    log("dara : room $room   , start $start , end $end , phone $phone , specialRequests $specialRequests , numberOfAdult $numberOfAdult , numberOfChildern $numberOfChildern , nationalityType $nationalityType");

    // تحويل الـ rooms بشكل صحيح
    final List<Map<String, dynamic>> roomsList = room
        .map((card) => {"id": card.id, "noOfRooms": card.numberOfPerson ?? 1})
        .toList();

    final Map<String, dynamic> requestBody = {
      "numberOfAdults": numberOfAdult,
      "numberOfChildren": numberOfChildern,
      "specialRequests": specialRequests,
      "rooms": roomsList,
      "nationalityType": nationalityType,
      "start": start,
      "end": end,
      "phone": phone
    };

    // 🐛 Debug: اطبع الـ request body
    print('📤 Sending Request:');
    print(jsonEncode(requestBody));

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(requestBody),
      );

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      var jsonBody = json.decode(response.body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "✅ Booking Successful!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        room.clear();
        emit(CreateBookingRoomSuccessful());
      } else {
        Fluttertoast.showToast(
          msg: "❌ ${jsonBody['message'] ?? 'Booking Failed'}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        emit(CreateBookingRoomError(jsonBody['message']));
      }
    } catch (e) {
      print('❌ Error: $e');
      emit(CreateBookingRoomError(e.toString()));
    }
  }

  GetBookingRoomModelDetails? getBookingRoomModelDetails;

  /// Room Details 3

  void getRoomDetails({
    required String id,
  }) async {
    emit(getRoomDetailsLoading());
    final token = await storage.read(key: 'token');

    http.Response response = await ApiConsumer().get(
        uri: "${Api.API_URL}Rooms/GetBookingRooms?BookingId=$id", token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      getBookingRoomModelDetails =
          GetBookingRoomModelDetails.fromJson(responseData);
      print(
          "getRoomModelPending?.data?.length${getAllAvailableRom?.data?.length}");

      emit(getRoomDetailsSuccessful());
    } else {
      print(response.body);
      emit(getRoomDetailsError(response.body));
    }
  }

  final List<String> lang = ["Egyption", "Arabic", "OtherNationality"];
  String item = "Egyption";
  String? items;
  void selectItem(String? value) {
    item = value!;
    emit(SelectItemLoaded());
  }

  Future<void> startPayment({
    required BuildContext context,
    required id,
    required amount,
  }) async {
    emit(PaymentLoading());
    final _plugin = GeideapayPlugin();

    await _plugin.initialize(
      apiPassword: "37d9f7ab-7d2e-4fcf-8a7b-9fa7a92ea086",
      publicKey: '245e0449-3989-49dc-8dc7-bdc5163ebd32',
      serverEnvironment: ServerEnvironmentModel.EGY_PROD(),
    );

    // ملاحظة: مكتبة Geideapay لديها بعض القيود على تخصيص ألوان حقول الإدخال
    // قد تظهر حقول الإدخال بيضاء بغض النظر عن الإعدادات المستخدمة هنا
    // يمكن التواصل مع مطوري المكتبة للمزيد من خيارات التخصيص

    CheckoutOptions checkoutOptions = CheckoutOptions(
      amount, "EGP",
      lang: "en",
      merchantReferenceID: '245e0449-3989-49dc-8dc7-bdc5163ebd32',
      paymentOperation: "Pay",
      backgroundColor: appBackgroundColor,
      textColor: Colors.black, // محاولة استخدام لون أسود للنص
      cardColor: Colors.green,
      payButtonColor: accentColor,
      callbackUrl: "https://yourdomain.com/payment-callback",
      returnUrl: "https://yourdomain.com/payment-return",
    );

    try {
      OrderApiResponse response = await _plugin.checkout(
        context: context,
        checkoutOptions: checkoutOptions,
      );

      if (response.responseCode == "000") {
        Fluttertoast.showToast(
            msg: "✅ Payment Successful!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        paymentOrNot(id: id);
        addProfitTrips(bookingId: id, amount: amount);
        emit(PaymentSuccess());
        debugPrint("✅ Payment Successful: ${response.detailedResponseMessage}");
        log("✅ Payment Successful!");
      } else {
        Fluttertoast.showToast(
            msg: "❌ Payment Failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        debugPrint("❌ Payment Failed: ${response.detailedResponseMessage}");
        log("❌ Payment Failed: ${response.detailedResponseMessage}");
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "❌ Payment Failed",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      debugPrint("⚠️ OrderApiResponse Error: $e");
      log("⚠️ Error: $e");
    }
  }

  // Future<void> startPayment({required BuildContext context,required String id,required amount})async{
  //   emit(PaymentLoading());
  //   var response = await MyFatoorah.startPayment(
  //     context: context,
  //     request: MyfatoorahRequest.live(
  //         currencyIso: Country.Egypt,
  //         successUrl: "https://img.freepik.com/premium-vector/success-payment-icon-flat-style-approved-money-vector-illustration-isolated-background-successful-pay-sign-business-concept_157943-1354.jpg",
  //         errorUrl: "https://img.freepik.com/premium-vector/success-payment-icon-flat-style-approved-money-vector-illustration-isolated-background-successful-pay-sign-business-concept_157943-1354.jpg",
  //         invoiceAmount: amount.toDouble(),
  //         language: ApiLanguage.English,
  //         token: "VZKrv0KxqV3LiQXHcte4QfjuNjR_isG-J2LOH6mR-evQSVpDKg34lIaaDBzXXs8yUKlBbBAUcLN0s58CFhPW_X9ohyPVwPZGQLp0c0GSCh0GCORtwzfL4kMWNXmT-WQyTijIFdquX0btT5uwEp8PSzZHQooBc6amon2_pfycPqvqckr_tAtk2nkCCed8kB1ocC1rHmzYCaIuFz3paf97la82IBO-tcuM0ZpVyYo3PbxKI12A4OF6WVEqkByXRBUYCLFyIuc9Sun2u0oKDFxSdgQ2OEehsgUmWyY0VsvZPvg-sBVwKVsoFixy2U_dAgXkLury1iOlZK25sUGWFpbTqiVK1JOLtBa6EhsGqieknaDds2-ob2ZFaBMTRmpw6JPdPS1UCnhW9KhFwLwdH1_1-_07JR9b9vf0eNqHifgVzFmWdLCP-P0rIWS54ysmo10fNYlwoo_7Y7HyvBjNvUAR98w_SfZ9NbW5RKhnt5ncDGJJbcomKtv6V4zzY0SxF0ZAysvE4y7KKNP6dbYGeElgX7ZlVgFqW98kU3Bv2ztSYsA70QpWmczWuH-SIl2NGF9ewt1PNtzt3w_0elDUQK4GCGj-hHYbBx10XIj6CjsEpEsfV5Vjg-CjoK9LI82Pc0h6qnZFwkzt3PKcrScSE5jSfkNDHV4nA8oqR4lcG7I_YIwxhRc2"
  //     ),
  //
  //   );
  //   print('response---------\n $response');
  //   if(response.status == PaymentStatus.Success){
  //     log(response.paymentId.toString());
  //     log(response.status.toString());
  //     paymentOrNot(id: id);
  //     addProfitTrips(bookingId: id, amount: amount);
  //     log("mahmoud zahran Barkat");
  //     emit(PaymentSuccess());
  //   }
  // }

  /// calc price

  String calculateTotalPrice(double productPrice, int numberOfProducts) {
    double totalPrice = productPrice * numberOfProducts;

    return totalPrice.toStringAsFixed(2); // Format to 2 decimal places
  }

  /// create Booking activity

  void createBookingActivity({
    required String activityId,
    required int numberOfGuest,
    required String activityDate,
    // required String phone,
    required String healthLimitations,
    required String experienceInActivity,
    required String specialRequests,
    required String languages,
  }) async {
    emit(CreateBookingActivityLoading());
    var token = await storage.read(key: 'token');

    // Additional business logic validation
    print('🎯 === ACTIVITY BOOKING VALIDATION ===');
    // print('📱 Phone: "$phone" (length: ${phone.length})');
    print('🗓️ Activity Date: "$activityDate"');
    print('👥 Number of Guests: $numberOfGuest');
    print('🏃 Activity ID: "$activityId"');
    print('🔑 Token Present: ${token != null ? "Yes" : "No"}');
    print('=====================================');

    try {
      // Create JSON request body
      Map<String, dynamic> requestBody = {
        // 'phone': phone,
        'numOfPersons': numberOfGuest,
        'activityId': activityId,
        'activityDate': activityDate,
        'healthLimitations': healthLimitations,
        'experienceInActivity': experienceInActivity,
        'specialRequests': specialRequests,
        'languages': languages,
      };

      // Debug logging for request
      print('🚀 === JSON ACTIVITY BOOKING REQUEST ===');
      print('📍 URL: ${Api().createBookingActivity}');
      print('📦 Request Body: ${json.encode(requestBody)}');
      print('🕒 Timestamp: ${DateTime.now()}');
      print('========================================');

      // Send the request with JSON content type
      http.Response response = await http.post(
        Uri.parse(Api().createBookingActivity),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      // Debug logging for response
      print('📥 === ACTIVITY BOOKING RESPONSE ===');
      print('🔢 Status Code: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');
      print('🕒 Timestamp: ${DateTime.now()}');
      print('====================================');

      var jsonBody = json.decode(response.body);

      // Business logic response handling
      print('💼 === ACTIVITY BOOKING RESULT ===');
      print('✅ Success: ${response.statusCode == 200}');
      print('📋 Message: ${jsonBody['message'] ?? 'No message'}');
      print('===================================');

      if (response.statusCode == 200) {
        emit(CreateBookingActivitySuccessful());
      } else {
        emit(
            CreateBookingActivityError(jsonBody['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      print('❌ === ACTIVITY BOOKING ERROR ===');
      print('Error: $e');
      print('=================================');
      emit(CreateBookingActivityError('Network error: $e'));
    }
  }

  /// cancel
  void cancelBooking({required String id, required String reason}) async {
    emit(CancelBookingLoading());
    var token = await storage.read(key: 'token');
    http.Response response = await ApiConsumer().post(
        uri: Api().cancelBooking + id + "&reason=$reason",
        rawData: {},
        token: token);
    var jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      emit(CancelBookingSuccessful(jsonBody['data']));
    } else {
      print(response.body);
      emit(CancelBookingError(jsonBody['message']));
    }
  }

  /// book agian
  void bookAgainActivity({required String id}) async {
    emit(BookingAgainLoading());
    var token = await storage.read(key: 'token');
    http.Response response = await ApiConsumer()
        .post(uri: Api().bookAgain + id, rawData: {}, token: token);
    var jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      emit(BookingAgainSuccessful());
    } else {
      print(response.body);
      emit(BookingAgainError(jsonBody['message']));
    }
  }

  /// book trip
  void bookAgainTrips({required String id}) async {
    emit(BookingAgainTripsLoading());
    var token = await storage.read(key: 'token');
    http.Response response = await ApiConsumer().post(
        uri: "${Api.API_URL}Booking/BookTripAgain?BookingId=$id",
        rawData: {},
        token: token);
    var jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      emit(BookingAgainTripsSuccessful());
    } else {
      print(response.body);
      emit(BookingAgainTripsError(jsonBody['message']));
    }
  }

  ///
  void bookAgainAccomandtion({required String id}) async {
    emit(BookingAgainRoomsLoading());
    var token = await storage.read(key: 'token');
    http.Response response = await ApiConsumer()
        .post(uri: Api().bookAgainRooms + id, rawData: {}, token: token);
    var jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      emit(BookingAgainRoomsSuccessful());
    } else {
      print(response.body);
      emit(BookingAgainRoomsError(jsonBody['message']));
    }
  }

  ///
  void paymentOrNot({required String id}) async {
    emit(PaymentOrNotLoading());
    var token = await storage.read(key: 'token');
    http.Response response = await ApiConsumer()
        .put(uri: Api().paymentOrNot + id, rawData: {}, token: token);
    var jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      emit(PaymentOrNotSuccessful());
    } else {
      print(response.body);
      emit(PaymentOrNotError(jsonBody['message']));
    }
  }

  /// send profit

  Future<void> addProfitAccomaantion(
      {required String bookingId, required double amount}) async {
    emit(AddProfitLoading());

    try {
      var token = await storage.read(key: 'token');
      if (token == null) {
        emit(AddProfitError('Token is missing.'));
        return;
      }

      final response = await http.post(
        Uri.parse("${Api.API_URL}Profits"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "bookingId": bookingId,
          "paidAmount": amount,
        }),
      );

      if (response.statusCode == 200) {
        emit(AddProfitSuccessful());
      } else {
        var jsonBody = json.decode(response.body);
        print(jsonBody['message']);
        emit(AddProfitError(jsonBody['message'] ?? 'An error occurred'));
      }
    } catch (e) {
      print(e.toString());
      emit(AddProfitError(e.toString()));
    }
  }

  //

  Future<void> addProfitTrips(
      {required String bookingId, required double amount}) async {
    emit(AddProfitTripsLoading());

    try {
      var token = await storage.read(key: 'token');
      if (token == null) {
        emit(AddProfitError('Token is missing.'));
        return;
      }

      final response = await http.post(
        Uri.parse("${Api.API_URL}Profits/AddTripProfits"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "bookingId": bookingId,
          "paidAmount": amount,
        }),
      );

      if (response.statusCode == 200) {
        emit(AddProfitTripsSuccessful());
      } else {
        var jsonBody = json.decode(response.body);
        print(jsonBody['message']);
        emit(AddProfitTripsError(jsonBody['message'] ?? 'An error occurred'));
      }
    } catch (e) {
      print(e.toString());
      emit(AddProfitTripsError(e.toString()));
    }
  }

  Future<void> addProfitActivity(
      {required String bookingId, required double amount}) async {
    emit(AddProfitActivityLoading());

    try {
      var token = await storage.read(key: 'token');
      if (token == null) {
        emit(AddProfitError('Token is missing.'));
        return;
      }

      final response = await http.post(
        Uri.parse("${Api.API_URL}Profits/AddActivityProfits"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "bookingId": bookingId,
          "paidAmount": amount,
        }),
      );

      if (response.statusCode == 200) {
        emit(AddProfitActivitySuccessful());
      } else {
        var jsonBody = json.decode(response.body);
        print(jsonBody['message']);
        emit(
            AddProfitActivityError(jsonBody['message'] ?? 'An error occurred'));
      }
    } catch (e) {
      print(e.toString());
      emit(AddProfitTripsError(e.toString()));
    }
  }

  ///
  Future<void> startPaymentActivity(
      {required BuildContext context,
      required String id,
      required amount}) async {
    emit(PaymentActivityLoading());
    final _plugin = GeideapayPlugin();

    await _plugin.initialize(
      apiPassword: "37d9f7ab-7d2e-4fcf-8a7b-9fa7a92ea086",
      publicKey: '245e0449-3989-49dc-8dc7-bdc5163ebd32',
      serverEnvironment: ServerEnvironmentModel.EGY_PROD(),
    );
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    CheckoutOptions checkoutOptions = CheckoutOptions(
      amount,
      "EGP",
      lang: "en",
      merchantReferenceID: id,
      paymentOperation: "Pay",
      backgroundColor: appBackgroundColor,
      textColor: Colors.black,
      cardColor: Colors.green,
      payButtonColor: accentColor,
    );

    try {
      OrderApiResponse response = await _plugin.checkout(
        context: context,
        checkoutOptions: checkoutOptions,
      );

      if (response.responseCode == "000") {
        Fluttertoast.showToast(
            msg: "✅ Payment Successful!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        paymentOrNot(id: id);
        addProfitActivity(bookingId: id, amount: amount);
        emit(PaymentSuccessActivity());
        debugPrint("✅ Payment Successful: ${response.detailedResponseMessage}");
        log("✅ Payment Successful!");
      } else {
        Fluttertoast.showToast(
            msg: "❌ Payment Failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        debugPrint("❌ Payment Failed: ${response.detailedResponseMessage}");
        log("❌ Payment Failed: ${response.detailedResponseMessage}");
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "❌ Payment Failed",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      debugPrint("⚠️ OrderApiResponse Error: $e");
      log("⚠️ Error: $e");
    }
  }

  Future<void> startPaymentAccomandtion(
      {required BuildContext context,
      required String id,
      required amount}) async {
    emit(PaymentActivityLoading());
    final _plugin = GeideapayPlugin();

    await _plugin.initialize(
      apiPassword: "37d9f7ab-7d2e-4fcf-8a7b-9fa7a92ea086",
      publicKey: '245e0449-3989-49dc-8dc7-bdc5163ebd32',
      serverEnvironment: ServerEnvironmentModel.EGY_PROD(),
    );

    CheckoutOptions checkoutOptions = CheckoutOptions(
      amount,
      "EGP",
      lang: "en",
      merchantReferenceID: '245e0449-3989-49dc-8dc7-bdc5163ebd32',
      paymentOperation: "Pay",
      backgroundColor: appBackgroundColor,
      cardColor: Colors.green,
      payButtonColor: accentColor,
      // callbackUrl: "https://yourdomain.com/payment-callback",
      // returnUrl: "https://yourdomain.com/payment-return",
    );

    try {
      OrderApiResponse response = await _plugin.checkout(
        context: context,
        checkoutOptions: checkoutOptions,
      );

      if (response.responseCode == "000") {
        Fluttertoast.showToast(
            msg: "✅ Payment Successful!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        paymentOrNot(id: id);
        addProfitAccomaantion(bookingId: id, amount: amount);
        emit(PaymentSuccessActivity());
        debugPrint("✅ Payment Successful: ${response.detailedResponseMessage}");
        log("✅ Payment Successful!");
      } else {
        Fluttertoast.showToast(
            msg: "❌ Payment Failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        debugPrint("❌ Payment Failed: ${response.detailedResponseMessage}");
        log("❌ Payment Failed: ${response.detailedResponseMessage}");
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "❌ Payment Failed",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      debugPrint("⚠️ OrderApiResponse Error: $e");
      log("⚠️ Error: $e");
    }
  }

  /// send notification to admin

  void sendNotification() async {
    emit(SendNotificationLoading());
    var token = await storage.read(key: 'token');
    http.Response response = await ApiConsumer().post(
        uri: "${Api.API_URL}Notification/SendNotificationToAdmin",
        rawData: {
          "Title": "someOne",
          "Body": contentNotification.text.trim(),
        },
        token: token);
    var jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      emit(SendNotificationSuccessful());
    } else {
      print(response.body);
      emit(SendNotificationError(jsonBody['message']));
    }
  }

  int toggleRoom = 0;
  void toggleRoomMethod(int index) {
    toggleRoom = index;
    emit(ToggleRoomSucsses());
  }
}
