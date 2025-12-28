import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/dotted%20container/dottedRect.dart';
import 'package:PassPort/screens/add%20service/room%20details/double%20room%20builder/doubleRoomBuilder.dart';
import 'package:PassPort/screens/add%20service/room%20details/king%20room%20builder/kingRoomBuilder.dart';
import 'package:PassPort/screens/add%20service/room%20details/single%20room%20builder/singleRoomBuilder.dart';
import 'package:PassPort/screens/add%20service/room%20details/triple%20room%20builder/tripleRoomBuilder.dart';
import 'package:PassPort/services/add%20service/add_service_cubit.dart';

class RoomDetails extends StatelessWidget {
  const RoomDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AddServiceCubit>().roomDetailsForm,
      child: ListView(
        children: [
          SizedBox(height: 10.h),
          context.read<AddServiceCubit>().singleRoomNum <= 0 ? SizedBox.shrink() : SingleRoomBuilder(),
          context.read<AddServiceCubit>().doubleRoomNum <= 0 ? SizedBox.shrink() : DoubleRoomBuilder(),
          context.read<AddServiceCubit>().tripleRoomNum <= 0 ? SizedBox.shrink() : TripleRoomBuilder(),
          context.read<AddServiceCubit>().kingRoomNum <= 0 ? SizedBox.shrink() : KingRoomBuilder(),
        ],
      ),
    );
  }
}
