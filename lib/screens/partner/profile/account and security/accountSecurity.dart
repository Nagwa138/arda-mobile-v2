import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_cubit.dart';
import 'package:PassPort/services/traveller/uset_cubit/user_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountSecurity extends StatelessWidget {
  const AccountSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context)=>UserCubit(),
      child: BlocConsumer<UserCubit,UserState>(

        listener: (BuildContext context,  state) {  },

        builder: (BuildContext context,  state) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'accountSecurity.title'.tr(),
                style: TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
            ),
            body: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: 20.w,
                  ),
                  title: Text(
                    'accountSecurity.changePassword'.tr(),
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: accentColor,
                    size: 20.sp,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'changePassword');
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: 20.w,
                  ),
                  title: Text(
                    'accountSecurity.privacy'.tr(),
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: accentColor,
                    size: 20.sp,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'privacy');
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: 20.w,
                  ),
                  title: Text(
                    'accountSecurity.delete'.tr(),
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: accentColor,
                    size: 20.sp,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'deleteAccount');
                  },
                ),
              ],
            ),
          ),
            ],
          );
        },

      ),
    );
  }
}
