import 'package:PassPort/screens/traveller/homeTravelling/notification/notificationsTraveller.dart';
import 'package:PassPort/version2_module/features/home/view/screens/explor_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:PassPort/screens/traveller/booking/bookingHome.dart';
import 'package:PassPort/screens/traveller/favourites/favourites.dart';
import 'package:PassPort/screens/traveller/homeTravelling/hometravelling.dart';
import 'package:PassPort/screens/traveller/profile/profile.dart';

import '../../../screens/traveller/homeTravelling/categories tabs/products/cart/cart.dart';
import 'homeTravellerNavBarStates.dart';

class HomeTravellerNavBarCubit extends Cubit<HomeTravellerNavBarStates> {
  HomeTravellerNavBarCubit() : super(HomeTravellerNavBarInitial());
  static HomeTravellerNavBarCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  int returnIndex(int index) {
    if (index == 0) {
      currentIndex = 0;
    } else if (index == 1) {
      currentIndex = 1;
    } else if (index == 2) {
      currentIndex = 2;
    } else if (index == 3) {
      currentIndex = 3;
    } else {
      currentIndex = 5;
    }

    return currentIndex;
  }

  /// List Screens HomeLanding
  List<Widget> screens = [
    // HomeTravelling(),
    ExploreScreen(),
    BookingHome(),
    const Favourites(),
    // TravellerNotification(),
    Cart(),
    ProfileTravelller(),
  ];
  List<String> titles = [
    //"travellerNavbar.home".tr(),
    "Explore",
    "travellerNavbar.booking".tr(),
    "travellerNavbar.favourite".tr(),
    "Cart",
    "travellerNavbar.profile".tr(),
  ];

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(NewBottomNavbar());
  }

  bool changeColor = false;
  void changedColor() {
    changeColor = !changeColor;
    emit(changedingColor());
  }

  @override
  void onChange(Change<HomeTravellerNavBarStates> change) {
    // TODO: implement onChange
    print(change);
    super.onChange(change);
  }
}
