import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geideapay/api/response/order_api_response.dart';
import 'package:geideapay/common/geidea.dart';
import 'package:geideapay/common/server_environments.dart';
import 'package:geideapay/widgets/checkout/checkout_options.dart';
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/consts/api/apiMethod/api_method.dart';

import 'package:http/http.dart' as http;
import 'package:PassPort/models/traveller/orders/order.dart';
import 'package:PassPort/models/traveller/orders/orderDetails.dart';
import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:PassPort/models/traveller/products/get_all_product.dart';
import 'package:PassPort/models/traveller/products/get_all_product_by_id.dart';
import 'package:PassPort/models/traveller/products/get_one_product_by_id.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/product_cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of(context);
  final storage = new FlutterSecureStorage();
  GetAllProductModel? productModel;
  GetAllProductById? allProductByIdModel;
  GetProductOneById? getProductOneById;
  GetAllOrder? getAllOrder;

  bool favourite = false;
  TextEditingController search = TextEditingController();
  TextEditingController phoneNumberOrder = TextEditingController();
  TextEditingController government = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController buildNumber = TextEditingController();

  void changeFav(value) {
    // getProductOneById?.data?.isFav = !value;
    emit(FavChange());
  }

  /// get All Product

  void getAllProduct() async {
    emit(getProductLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().getAllProduct, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      productModel = GetAllProductModel.fromJson(responseData);
      print(productModel?.data?.length);
      emit(getProductSuccessful());
    } else {
      print(response.body);
      emit(getProductError(error: response.body));
    }
  }

  /// get all product By Id
  void getAllProductById({required String id}) async {
    emit(getAllProductByIdLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    http.Response response = await ApiConsumer().get(
        uri: search.text.trim().isEmpty
            ? Api().getAllProductById + id
            : "${Api.API_URL}Product/Product/GetAllById?id=$id&ProductName=${search.text.trim()}",
        token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      allProductByIdModel = GetAllProductById.fromJson(responseData);
      print("ffjvjfjfvnjfnvjf${allProductByIdModel?.data?.length}");

      emit(getAllProductByIdSuccessful());
    } else {
      print(response.statusCode);
      emit(getAllProductByIdError(error: response.body));
    }
  }

  /// get one product By Id
  void getOneProductById({required String id}) async {
    emit(getProductByIdLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    http.Response response = await ApiConsumer()
        .get(uri: Api().getOneProductById + id, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      getProductOneById = GetProductOneById.fromJson(responseData);
      print("message hhhhhhhhhh${getProductOneById?.message}");

      emit(getProductByIdSuccessful());
    } else {
      print(response.statusCode);
      emit(getProductByIdError(error: response.body));
    }
  }

  /// add Favourite Of product
  void addFavouriteOfProduct({required String productId}) async {
    emit(AddFavouriteOfProductLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person blog = $token");
    http.Response response = await http.post(
        Uri.parse(
          "${Api().addFavouriteOfProduct + productId}",
        ),
        headers: {'Authorization': 'Bearer $token'});
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData);
      emit(AddFavouriteOfProductSuccessful());
    } else {
      print(response.body);
      emit(AddFavouriteOfProductError(error: response.body));
    }
  }

  /// delete Favourite From Product
  void deleteFavouriteOfProduct({required String productId}) async {
    emit(deleteFavouriteOfProductLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person  = $token");
    http.Response response = await http.delete(
        Uri.parse(
          "${Api().deleteFavouriteOfProduct + productId}",
        ),
        headers: {'Authorization': 'Bearer $token'});
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData);
      emit(deleteFavouriteOfProductSuccessful());
    } else {
      print(response.body);
      emit(deleteFavouriteOfProductError(error: response.body));
    }
  }

  /// get all Products

  void getAllOrders() async {
    emit(getOrderLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().getAllOrder, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      getAllOrder = GetAllOrder.fromJson(responseData);
      print(getAllOrder?.data?.length);
      emit(getOrderSuccessful());
    } else {
      print(response.body);
      emit(getOrderError(error: responseData['message']));
    }
  }

  /// made order
  void madeOrder(List<CardModel> cards) async {
    emit(MadeOrderLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    final List<Map<String, dynamic>> cardsList =
        cards.map((card) => card.toMap()).toList();
    final String cardsJson = json.encode(cardsList);

    try {
      var response = await http.post(
        Uri.parse(Api().MadeOrder),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          "phoneNumber": phoneNumberOrder.text.trim(),
          "goverName": government.text.trim(),
          "city": city.text.trim(),
          "street": street.text.trim(),
          "buildingNo": buildNumber.text.trim(),
          "products": cardsList
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        // Try to decode as JSON
        try {
          var responseData = json.decode(response.body);
          print(responseData);
          emit(MadeOrderSuccessful());
        } catch (e) {
          // If JSON decode fails, treat as success if status is 200
          print("Response is not JSON, but status is 200");
          emit(MadeOrderSuccessful());
        }
      } else {
        // Handle error response
        String errorMessage;
        try {
          var responseData = json.decode(response.body);
          errorMessage = responseData['message'] ?? response.body;
        } catch (e) {
          // If response is plain text (not JSON)
          errorMessage = response.body;
        }

        print("Error: $errorMessage");
        emit(MadeOrderError(error: errorMessage));
      }
    } catch (e) {
      print("Exception in madeOrder: $e");
      emit(MadeOrderError(error: e.toString()));
    }
  }

  orderDetailsModel? orderDetails;

  /// get detaild order
  void getDetailsOrder(String id) async {
    emit(GetDetailsLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    http.Response response =
        await ApiConsumer().get(uri: Api().getDetailsOrder + id, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      orderDetails = orderDetailsModel.fromJson(responseData);
      emit(GetDetailsSuccessful());
    } else {
      print(response.body);
      emit(GetDetailsError(error: responseData['message']));
    }
  }

  /// again
  void MadeOrderAgain(String id) async {
    emit(OrderAgainLoading());
    final token = await storage.read(key: 'token');
    print("tokn is person product = $token");
    http.Response response = await ApiConsumer()
        .post(uri: Api().madeOrderAgain + id, rawData: {}, token: token);
    var responseData = await json.decode(response.body);
    if (response.statusCode == 200) {
      emit(OrderAgainSuccessful());
    } else {
      print(response.body);
      emit(OrderAgainError(error: responseData['message']));
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
      emit(PaymentOrNotError(error: jsonBody['message']));
    }
  }

  /// payment
  Future<void> startPayment(
      {required BuildContext context,
      required String id,
      required amount}) async {
    emit(PaymentLoading());
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
      backgroundColor: Colors.white,
      textColor: Colors.black,
      cardColor: Colors.green,
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
        addProfitProduct(bookingId: id);
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

  Future<void> addProfitProduct({required String bookingId}) async {
    emit(AddProfitLoading());

    try {
      var token = await storage.read(key: 'token');
      if (token == null) {
        emit(AddProfitError(error: 'Token is missing.'));
        return;
      }

      final response = await http.post(
        Uri.parse("${Api.API_URL}Profits"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "PartnerId": bookingId,
        }),
      );

      if (response.statusCode == 200) {
        emit(AddProfitSuccessful());
      } else {
        var jsonBody = json.decode(response.body);
        print(jsonBody['message']);
        emit(AddProfitError(error: jsonBody['message'] ?? 'An error occurred'));
      }
    } catch (e) {
      print(e.toString());
      emit(AddProfitError(error: e.toString()));
    }
  }
}
