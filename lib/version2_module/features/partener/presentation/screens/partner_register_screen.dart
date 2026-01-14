import 'package:PassPort/version2_module/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/partner_register_entity.dart';
import '../cubit/partner_register_cubit.dart';
import '../cubit/partner_register_state.dart';
import '../widgets/custom_dialogs.dart';

class PartnerRegisterScreen extends StatefulWidget {
  const PartnerRegisterScreen({super.key});

  @override
  State<PartnerRegisterScreen> createState() => _PartnerRegisterScreenState();
}

class _PartnerRegisterScreenState extends State<PartnerRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _applicantNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PartnerRegisterCubit>().getApplicationServices();
    context.read<PartnerRegisterCubit>().getGovernments();
  }

  @override
  void dispose() {
    _applicantNameController.dispose();
    _companyNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text(
              'Partner Registration',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.textColor),
            ),
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.textColor),
          ),
          body: BlocConsumer<PartnerRegisterCubit, PartnerRegisterState>(
            listener: (context, state) {
              if (state is PartnerRegisterLoading) {
                CustomDialogs.showLoadingDialog(
                  context: context,
                  message: 'Registering your partnership...',
                );
              } else if (state is PartnerRegisterSuccess) {
                Navigator.of(context).pop(); // Close loading dialog
                CustomDialogs.showSuccessDialog(
                  context: context,
                  title: 'Welcome Partner!',
                  message: state.message,
                  onOkPressed: () {
                    Navigator.of(context).pop(); // Go back to previous screen
                  },
                );
              } else if (state is PartnerRegisterError) {
                Navigator.of(context).pop(); // Close loading dialog
                CustomDialogs.showErrorDialog(
                  context: context,
                  title: 'Registration Failed',
                  message: state.message,
                  onRetryPressed: () {
                    // User can try again
                  },
                  onCancelPressed: () {
                    // Just close the dialog
                  },
                );
              } else if (state is ServicesError) {
                CustomDialogs.showErrorDialog(
                  context: context,
                  title: 'Connection Error',
                  message:
                      'Unable to load services. Please check your internet connection and try again.',
                  onRetryPressed: () {
                    context
                        .read<PartnerRegisterCubit>()
                        .getApplicationServices();
                    context.read<PartnerRegisterCubit>().getGovernments();
                  },
                  onCancelPressed: () {
                    Navigator.of(context).pop(); // Go back
                  },
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20.h),

                        // Welcome Text
                        Text(
                          'Glad to have you , our partner in growth',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                        SizedBox(height: 30.h),

                        // Applicant Name Field
                        _buildTextField(
                          controller: _applicantNameController,
                          label: 'Applicant Name *',
                          hint: 'Enter applicant name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Applicant name is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Brand/Company Name Field
                        _buildTextField(
                          controller: _companyNameController,
                          label: 'Brand Name *',
                          hint: 'Enter your brand/company name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Brand name is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Email Field
                        _buildTextField(
                          controller: _emailController,
                          label: 'Email *',
                          hint: 'Enter your email address',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Government/City Selection
                        _buildGovernmentSelector(state),
                        SizedBox(height: 20.h),

                        // Service Selection
                        _buildServiceSelector(state),
                        SizedBox(height: 30.h),

                        // Register Button
                        _buildRegisterButton(state),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14.sp,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.buttonColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceSelector(PartnerRegisterState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Type',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 8.h),
        if (state is ServicesLoading)
          const Center(child: CircularProgressIndicator())
        else if (state is ServicesLoaded ||
            context.read<PartnerRegisterCubit>().services.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ApplicationServiceEntity>(
                isExpanded: true,
                value: context.read<PartnerRegisterCubit>().selectedService,
                hint: Text(
                  'Select a service',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14.sp,
                  ),
                ),
                items: context
                    .read<PartnerRegisterCubit>()
                    .services
                    .map((service) {
                  return DropdownMenuItem<ApplicationServiceEntity>(
                    value: service,
                    child: Text(
                      service.serviceName,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (ApplicationServiceEntity? service) {
                  if (service != null) {
                    context.read<PartnerRegisterCubit>().selectService(service);
                  }
                },
              ),
            ),
          )
        else
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'Unable to load services. Please try again.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14.sp,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGovernmentSelector(PartnerRegisterState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'City',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 8.h),
        if (state is ServicesLoading)
          const Center(child: CircularProgressIndicator())
        else if (context.read<PartnerRegisterCubit>().governments.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<GovernmentEntity>(
                isExpanded: true,
                value: context.read<PartnerRegisterCubit>().selectedGovernment,
                hint: Text(
                  'Select city',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14.sp,
                  ),
                ),
                items: context
                    .read<PartnerRegisterCubit>()
                    .governments
                    .map((government) {
                  return DropdownMenuItem<GovernmentEntity>(
                    value: government,
                    child: Text(
                      government.name,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (GovernmentEntity? government) {
                  if (government != null) {
                    context
                        .read<PartnerRegisterCubit>()
                        .selectGovernment(government);
                  }
                },
              ),
            ),
          )
        else
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'Unable to load cities. Please try again.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14.sp,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRegisterButton(PartnerRegisterState state) {
    final isLoading = state is PartnerRegisterLoading;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          colors: [
            AppColors.buttonColor,
            AppColors.buttonColor.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonColor.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : _handleRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isLoading) ...[
              Icon(
                Icons.handshake,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              isLoading ? 'Processing...' : 'Join as Partner',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRegister() {
    print('🎬 UI: Register button pressed!');
    print('📋 UI: Form validation...');

    if (_formKey.currentState!.validate()) {
      print('✅ UI: Form validation passed');
      print('📝 UI: Form data:');
      print('   Applicant Name: ${_applicantNameController.text.trim()}');
      print('   Brand Name: ${_companyNameController.text.trim()}');
      print('   Email: ${_emailController.text.trim()}');
      print('   Address Link: "N/A" (temporary placeholder value)');
      print('   Website Link: null (explicitly set)');

      context.read<PartnerRegisterCubit>().registerPartner(
            email: _emailController.text.trim(),
            companyName: _companyNameController.text.trim(),
            applicantName: _applicantNameController.text.trim(),
            addressLink: 'N/A',
            websiteLink: null,
          );
    } else {
      print('❌ UI: Form validation failed');
    }
  }
}
