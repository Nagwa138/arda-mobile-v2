import 'package:PassPort/version2_module/core/widgets/custom_text_field.dart';
import 'package:PassPort/version2_module/features/auth/login/view_model/login_cubit.dart';
import 'package:PassPort/version2_module/features/auth/login/view_model/login_state.dart';
import 'package:PassPort/version2_module/features/auth/signup/view/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../components/color/color.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.message,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            'Welcome back!',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                margin: EdgeInsets.all(16.w),
                duration: Duration(seconds: 2),
              ),
            );

            final navigationRoute =
                LoginCubit.get(context).getNavigationRoute(state.userType);
            print(
                'Login Success: Navigating to $navigationRoute for user type ${state.userType}');
            Navigator.pushNamedAndRemoveUntil(
              context,
              navigationRoute,
              (route) => false,
            );
            print(state.token);
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error_outline_rounded,
                        color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Expanded(child: Text(state.error)),
                  ],
                ),
                backgroundColor: Colors.red.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                margin: EdgeInsets.all(16.w),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);

          return Scaffold(
              body: Stack(
            children: [
              // Background Image
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        CustomLogo(),

                        SizedBox(height: 40.h),

                        // Welcome Section with improved typography
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi!',
                              style: TextStyle(
                                fontSize: 42.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                height: 1.2,
                                letterSpacing: -1,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Text(
                                  'Salam Alaykom',
                                  style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w600,
                                    color: accentColor,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "I'm waiting for you, please enter your details",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 48.h),

                        // Email Field with enhanced styling
                        CustomTextField(
                          label: 'E-mail',
                          controller: cubit.emailController,
                          hint: 'Enter your email address',
                          keyboardType: TextInputType.emailAddress,
                          validator: cubit.validateEmail,
                        ),

                        SizedBox(height: 20.h),

                        // Password Field
                        CustomTextField(
                          label: 'Password',
                          controller: cubit.passwordController,
                          obscureText: !cubit.isPasswordVisible,
                          hint: 'Enter your password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              cubit.isPasswordVisible
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              color: accentColor.withValues(alpha: 0.5),
                            ),
                            onPressed: cubit.togglePasswordVisibility,
                          ),
                          validator: cubit.validatePassword,
                        ),

                        SizedBox(height: 16.h),

                        // Forgot Password Link with better styling
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'forgotPassword');
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: accentColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Sign In Button with enhanced design
                        state is LoginLoading
                            ? Container(
                                height: 56.h,
                                decoration: BoxDecoration(
                                  color: accentColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 24.w,
                                    height: 24.w,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        accentColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 56.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      accentColor,
                                      Color(0xFF1a2d52),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: accentColor.withValues(alpha: 0.3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      cubit.loginUser();
                                    },
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Log In',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Colors.white,
                                            size: 20.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                        SizedBox(height: 24.h),

                        // Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.black12,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.black12,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        // Sign Up Link
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, 'register');
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.sp,
                                    color: accentColor,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ));
        },
      ),
    );
  }
}
