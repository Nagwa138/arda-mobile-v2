import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/partner/servicesCubit/servicesCubit.dart';
import 'package:PassPort/services/partner/servicesCubit/servicesStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddRoomDetails extends StatelessWidget {
  const AddRoomDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return BlocProvider(
      create: (BuildContext context) => ServicesCubit(),
      child: BlocConsumer<ServicesCubit, ServicesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Color.fromRGBO(19, 10, 3, 1)),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              title: Text(
                "${arguments['name']} Rooms",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(19, 10, 3, 1),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            orange.withOpacity(0.1),
                            orange.withOpacity(0.05)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: orange.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(Icons.hotel, color: white, size: 24.sp),
                          ),
                          SizedBox(width: 16.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Adding New Room",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "${arguments['name']} Room",
                                style: TextStyle(
                                  color: Color.fromRGBO(29, 36, 45, 1),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Room Number Input
                    _buildInputSection(
                      title: 'What is the room number?',
                      hint: 'Enter the room number',
                      icon: Icons.tag,
                      controller: context.read<ServicesCubit>().roomNumber,
                      keyboardType: TextInputType.number,
                    ),

                    // Price Input (for King rooms only)
                    if (arguments['name'] == "King") ...[
                      SizedBox(height: 20.h),
                      _buildInputSection(
                        title: 'What is the room price?',
                        hint: 'Enter the price',
                        icon: Icons.attach_money,
                        controller: context.read<ServicesCubit>().priceNumber,
                        keyboardType: TextInputType.number,
                      ),
                    ],

                    SizedBox(height: 20.h),

                    // Calendar Input
                    _buildCalendarInput(context, arguments),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputSection({
    required String title,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(
              color: Color.fromRGBO(19, 10, 3, 1),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              hintText: hint,
              hintStyle: TextStyle(
                color: Color(0xFFCECFD1),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(icon, color: orange, size: 22.sp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: orange, width: 2),
              ),
              filled: true,
              fillColor: white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarInput(BuildContext context, Map arguments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'What are the busy days?',
            style: TextStyle(
              color: Color.fromRGBO(19, 10, 3, 1),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, "calnder", arguments: {
              'roomNumber':
                  context.read<ServicesCubit>().roomNumber.text.trim(),
              'price': context.read<ServicesCubit>().priceNumber.text.trim(),
              'id': arguments['id'],
              'roomType': arguments['name']
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: orange, size: 22.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Choose busy days',
                    style: TextStyle(
                      color: Color(0xFFCECFD1),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    color: Colors.grey[400], size: 16.sp),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
