import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/partner/profile/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(280.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AppBar(
                leading: BackButton(
                  color: white,
                ),
                flexibleSpace: Container(
                  height: 400.h,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/auth/Intersect.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/ard_logo.png",
                        height: 300.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
      body: BlocProvider(
        create: (context) => ProfileCubit(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileEditLoaded) {
              Fluttertoast.showToast(
                  msg: "Successful",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.pushNamed(context, "personalProfile");
            } else if (state is ProfileEditError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              children: [
                textFormFildBuilder(
                  context,
                  title: 'profile.username'.tr(),
                  hint: args['userName'],
                  controller: context.read<ProfileCubit>().userNameController,
                ),
                textFormFildBuilder(
                  context,
                  title: 'profile.email'.tr(),
                  hint: args['email'],
                  controller: context.read<ProfileCubit>().emailController,
                ),
                textFormFildBuilder(
                  context,
                  title: 'profile.phone'.tr(),
                  hint: args['phoneNumber'],
                  controller: context.read<ProfileCubit>().phoneController,
                  inputType: TextInputType.phone,
                ),

                // Row(
                //   children: [
                //     Expanded(
                //       child: RadioListTile.adaptive(
                //         contentPadding: EdgeInsets.zero,
                //         activeColor: orange,
                //         value: 0,
                //         groupValue: context.read<ProfileCubit>().val,
                //         title: Text('profile.male'.tr()),
                //         onChanged: (value) {
                //           context.read<ProfileCubit>().checkGender(value);
                //         },
                //       ),
                //     ),
                //     Expanded(
                //       child: RadioListTile.adaptive(
                //         value: 1,
                //         groupValue: context.read<ProfileCubit>().val,
                //         activeColor: orange,
                //         title: Text('profile.female'.tr()),
                //         onChanged: (value) {
                //           context.read<ProfileCubit>().checkGender(value);
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                    context.read<ProfileCubit>().updateInformation(
                        name: context
                                .read<ProfileCubit>()
                                .userNameController
                                .text
                                .trim()
                                .isNotEmpty
                            ? context
                                .read<ProfileCubit>()
                                .userNameController
                                .text
                                .trim()
                            : args['userName'],
                        email: context
                                .read<ProfileCubit>()
                                .emailController
                                .text
                                .trim()
                                .isNotEmpty
                            ? context
                                .read<ProfileCubit>()
                                .emailController
                                .text
                                .trim()
                            : args['email'],
                        phone: context
                                .read<ProfileCubit>()
                                .phoneController
                                .text
                                .trim()
                                .isNotEmpty
                            ? context
                                .read<ProfileCubit>()
                                .phoneController
                                .text
                                .trim()
                            : args['userName'],
                        valG: context.read<ProfileCubit>().val == 0 ||
                                context.read<ProfileCubit>().val == 1
                            ? context.read<ProfileCubit>().val
                            : args['gender']);
                  },
                  child: Container(
                    width: 1.sw,
                    height: 56.h,
                    decoration: ShapeDecoration(
                      color: context.read<ProfileCubit>().isAllInputNotEmpty
                          ? orange
                          : Color(0xFF8C8C8C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'profile.save'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget textFormFildBuilder(
    BuildContext context, {
    required String title,
    required String hint,
    required TextEditingController controller,
    bool obstructText = false,
    TextInputType inputType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          TextFormField(
            controller: controller,
            onChanged: (value) {
              context.read<ProfileCubit>().checkIfAllInputIsNotEmpty();
            },
            obscureText: obstructText,
            keyboardType: inputType,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
              hintText: hint.tr(),
              hintStyle: TextStyle(
                color: Color(0xFFCECFD1),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Color(0xFFDFE2E6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
