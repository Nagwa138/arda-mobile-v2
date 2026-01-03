import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PassPort/screens/partner/landinHome/landingHome.dart';
import 'package:PassPort/screens/partner/profile/profileLanding.dart';

import 'landingHomeStates.dart';

class LandingMainHomeCubit extends Cubit<LandingHomeStates> {
  LandingMainHomeCubit() : super(LandingHomeInitial());
  static LandingMainHomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  /// List Screens HomeLanding
  List<Widget> screens = [
    LandingHome(),
    // ServicesLanding(),
    const ProfileLanding(),
  ];
  List<String> titles = [
    "homeLanding.main".tr(),
    "homeLanding.services".tr(),
    "homeLanding.profile".tr(),
  ];

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(NewBottomNavbar());
  }

  @override
  void onChange(Change<LandingHomeStates> change) {
    // TODO: implement onChange
    print(change);
    super.onChange(change);
  }
}
