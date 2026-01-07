import 'package:PassPort/models/traveller/rooms/roomlist.dart';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

class CardCubitRoom extends Cubit<List<RoomList>> {
  CardCubitRoom() : super([]);
  int singleRoomNum = 0;
  int sumOfAllProduct = 0;
  int doubleRoomNum = 0;
  int kingRoomNum = 0;
  int tripleRoomNum = 0;

  void loadCards() async {
    var box = Hive.box('cardsRoom');
    List<RoomList> cards = box.values
        .map((card) => RoomList.fromMap(Map<String, dynamic>.from(card)))
        .toList();
    print("***************************************${box.length}");
    emit(cards);
  }

  //bool changeBooking = true;
  void addCard(RoomList card) async {
    var box = Hive.box('cardsRoom');

    // Check if the card already exists
    bool cardExists = box.values.any((existingCard) {
      var existingCardMap = Map<String, dynamic>.from(existingCard);
      return existingCardMap['id'] == card.id;
    });

    if (cardExists) {
      //changeBooking = false;
      // Note: Cubit doesn't have BuildContext, so we can't show snackbar here
      // The UI layer should listen to a state and show the snackbar
    } else {
      await box.add(card.toJson());
      //changeBooking= false;
      //print(changeBooking);

      print(card);
      loadCards();
      // Note: Cubit doesn't have BuildContext, so we can't show snackbar here
      // The UI layer should listen to a state and show the snackbar
    }

    // Refresh the state
  }

  bool isRoomBooked(String roomId) {
    var box = Hive.box('cardsRoom');
    return box.values.any((existingCard) {
      var existingCardMap = Map<String, dynamic>.from(existingCard);
      return existingCardMap['id'] == roomId; // التحقق من تطابق معرف الغرفة
    });
  }

  void removeCard(int index) async {
    var box = Hive.box('cardsRoom');
    await box.deleteAt(index);
    //changeBooking = true;

    //print(changeBooking);

    loadCards();
    // Note: Cubit doesn't have BuildContext, so we can't show snackbar here
    // The UI layer should listen to a state and show the snackbar
    // Refresh the state
  }

  Future<void> clearState() async {
    var box = Hive.box('cardsRoom');
    await box.clear();
    loadCards();
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

  void addOrUpdateRoom(String roomId, int quantity) async {
    var box = Hive.box('cardsRoom');
    int index = -1;

    // Find index
    for (int i = 0; i < box.length; i++) {
      var card = Map<String, dynamic>.from(box.getAt(i));
      if (card['id'] == roomId) {
        index = i;
        break;
      }
    }

    if (quantity == 0) {
      if (index != -1) {
        await box.deleteAt(index);
        loadCards(); // Emit state
      }
    } else {
      final newCard = RoomList(id: roomId, numberOfPerson: quantity);
      if (index != -1) {
        await box.putAt(index, newCard.toJson());
      } else {
        await box.add(newCard.toJson());
      }
      loadCards();
    }
  }
}
