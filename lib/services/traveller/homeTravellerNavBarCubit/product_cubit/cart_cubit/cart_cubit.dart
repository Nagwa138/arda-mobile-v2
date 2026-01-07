// import 'dart:convert';
//
// import 'package:bloc/bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:PassPort/models/traveller/products/card_model.dart';
//
// // Define the states
// class CartState {
//   final List<CartItem> items;
//
//   const CartState({this.items = const []});
//
//   @override
//   List<Object?> get props => [items];
// }
//
// // Define the cubit
// class CartCubit extends Cubit<CartState> {
//   CartCubit() : super(CartState()) {
//     loadCart();
//   }
//   List<CartItem> items =[];
//   void addItem({required CartItem item, required String id}) {
//
//     // final index = items.indexWhere((i) => i.id == item.id);
//     //
//     // if (index != -1) {
//     //   items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
//     // } else {
//     //   items.add(item);
//     //   print(state.items.length);
//     // }
//
//       items.add(item);
//
//     emit(CartState(items: items));
//     print(state.items.length);
//     saveCart();
//   }
//
//   void removeItem(String id) {
//     final items = state.items.where((item) => item.id != id).toList();
//     emit(CartState(items: items));
//     saveCart();
//   }
//
//   void clearCart() {
//     emit(CartState());
//     saveCart();
//   }
//
//   Future<void> saveCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartJson = jsonEncode(state.items.map((item) => item.toJson()).toList());
//     prefs.setString('cart', cartJson);
//   }
//
//   Future<void> deleteCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartJson = jsonEncode(state.items.map((item) => item.toJson()).toList());
//     prefs.setString('cart', cartJson);
//   }
//
//
//   Future<void> loadCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartJson = prefs.getString('cart');
//     if (cartJson != null) {
//       final List decodedList = jsonDecode(cartJson);
//       final items = decodedList.map((json) => CartItem.fromJson(json)).toList();
//       emit(CartState(items: items));
//     }
//   }
// }

import 'package:PassPort/models/traveller/products/card_model.dart';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

class CardCubit extends Cubit<List<CardModel>> {
  CardCubit() : super([]);
  int singleRoomNum = 0;
  int sumOfAllProduct = 0;
  int doubleRoomNum = 0;
  int kingRoomNum = 0;
  int tripleRoomNum = 0;

  void loadCards() async {
    var box = Hive.box('cardsBox');
    List<CardModel> cards = box.values
        .map((card) => CardModel.fromMap(Map<String, dynamic>.from(card)))
        .toList();
    emit(cards);
  }

  // void addCard(CardModel card) async {
  //   var box = Hive.box('cardsBox');
  //   await box.add(card.toMap());
  //
  //   loadCards();  // Refresh the state
  // }
  void addCard(CardModel card) async {
    var box = Hive.box('cardsBox');

    // Check if the card already exists
    bool cardExists = box.values.any((existingCard) {
      var existingCardMap = Map<String, dynamic>.from(existingCard);
      return existingCardMap['productId'] == card.productId &&
          existingCardMap['description'] == card.description;
    });

    if (cardExists) {
      print('Card already exists');
      // Note: Cubit doesn't have BuildContext, so we can't show snackbar here
      // The UI layer should listen to a state and show the snackbar
      // Optionally, show a message to the user
    } else {
      await box.add(card.toMap());
      // Note: Cubit doesn't have BuildContext, so we can't show snackbar here
      // The UI layer should listen to a state and show the snackbar
      loadCards(); // Refresh the state
    }
  }

  void removeCard(int index) async {
    var box = Hive.box('cardsBox');
    await box.deleteAt(index);
    loadCards(); // Refresh the state
  }

  // Update quantity of a specific card
  void updateCardQuantity(int index, int newQuantity) async {
    var box = Hive.box('cardsBox');
    var cardMap = Map<String, dynamic>.from(box.getAt(index));
    cardMap['amount'] = newQuantity;
    await box.putAt(index, cardMap);
    loadCards(); // Refresh the state
  }

  // Increment quantity - no limit
  void incrementQuantity(int index) async {
    var box = Hive.box('cardsBox');
    var cardMap = Map<String, dynamic>.from(box.getAt(index));
    int currentAmount = cardMap['amount'] ?? 1;

    cardMap['amount'] = currentAmount + 1;
    await box.putAt(index, cardMap);
    loadCards();
  }

  // Decrement quantity - minimum is 1
  void decrementQuantity(int index) async {
    var box = Hive.box('cardsBox');
    var cardMap = Map<String, dynamic>.from(box.getAt(index));
    int currentAmount = cardMap['amount'] ?? 1;

    if (currentAmount > 1) {
      cardMap['amount'] = currentAmount - 1;
      await box.putAt(index, cardMap);
      loadCards();
    }
  }

  changeSingleRoomNum({bool isAdded = false}) {
    if (isAdded) {
      singleRoomNum++;
    } else {
      if (singleRoomNum != 0) {
        singleRoomNum--;
      }
    }
    sumOfRooms();
  }

  sumOfRooms() {
    sumOfAllProduct =
        singleRoomNum + doubleRoomNum + tripleRoomNum + kingRoomNum;
    // return singleRoomNum
    // emit(AddServiceRoomNumChanged());
  }
}
