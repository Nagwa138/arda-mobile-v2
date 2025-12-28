import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/homeTravellerNavBarCubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/homeTravellerNavBarStates.dart';

class HomeTravellingNavBar extends StatelessWidget {
  HomeTravellingNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeTravellerNavBarCubit(),
      child: BlocConsumer<HomeTravellerNavBarCubit, HomeTravellerNavBarStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              backgroundColor: appBackgroundColor,
              //extendBody: true,
              body: context.read<HomeTravellerNavBarCubit>().screens[
                  context.read<HomeTravellerNavBarCubit>().currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex:
                    context.read<HomeTravellerNavBarCubit>().currentIndex,
                onTap: (index) {
                  context
                      .read<HomeTravellerNavBarCubit>()
                      .changeCurrentIndex(index);
                },
                selectedItemColor: accentColor,
                unselectedItemColor: const Color(0xFF8C8C8C),
                backgroundColor: appBackgroundColor,
                type: BottomNavigationBarType.fixed,
                elevation: 8,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.search_outlined),
                    label: context.read<HomeTravellerNavBarCubit>().titles[0],
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: context.read<HomeTravellerNavBarCubit>().titles[1],
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.favorite_outline_outlined),
                    label: context.read<HomeTravellerNavBarCubit>().titles[2],
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: context.read<HomeTravellerNavBarCubit>().titles[3],
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person_outline_outlined),
                    label: context.read<HomeTravellerNavBarCubit>().titles[4],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
