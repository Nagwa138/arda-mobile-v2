import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/consts/routes/route.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/service_form_field.dart';
import '../cubit/add_accommodation_cubit.dart';
import '../cubit/add_activity_cubit.dart';
import '../cubit/add_product_cubit.dart';
import '../cubit/add_trip_cubit.dart';
import 'category_dropdown_widget.dart';
import 'custom_form_field.dart';
import 'features_section_widget.dart';
import 'image_upload_widget.dart';
import 'room_section_widget.dart';

class DynamicServiceForm extends StatefulWidget {
  final String partnerType;
  final Function(Map<String, dynamic>)? onFormSubmit;
  final Map<String, dynamic>? initialData;
  final VoidCallback? onLoadingStateChanged;

  const DynamicServiceForm({
    super.key,
    required this.partnerType,
    this.onFormSubmit,
    this.initialData,
    this.onLoadingStateChanged,
  });

  @override
  State<DynamicServiceForm> createState() => DynamicServiceFormState();
}

class DynamicServiceFormState extends State<DynamicServiceForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, dynamic> _formData = {};
  late ServiceFormConfig _config;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    print('=== INIT STATE STARTED ===');
    _config = ServiceFormConfig.forPartnerType(widget.partnerType);
    print('Config loaded for partner type: ${widget.partnerType}');
    _initializeControllers();
    _initializeFormData();
    print('=== INIT STATE COMPLETED ===');
  }

  void _initializeControllers() {
    for (final field in _config.fields) {
      if (field.type != ServiceFieldType.imageUpload &&
          field.type != ServiceFieldType.roomSection &&
          field.type != ServiceFieldType.amenitiesSection &&
          field.type != ServiceFieldType.featuresSection &&
          field.type != ServiceFieldType.categoryDropdown) {
        _controllers[field.key] = TextEditingController(
          text: widget.initialData?[field.key]?.toString() ?? '',
        );
      }
    }
  }

  void _initializeFormData() {
    if (widget.initialData != null) {
      _formData.addAll(widget.initialData!);
    }
  }

  @override
  void dispose() {
    print('=== DISPOSE CALLED ===');
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildCubitProvider() {
    switch (widget.partnerType.toLowerCase()) {
      case 'activity':
      case 'نشاط':
        return BlocProvider(
          create: (context) => AddActivityCubit(),
          child: BlocConsumer<AddActivityCubit, AddActivityState>(
            listener: (context, state) {
              if (state is AddActivitySuccess) {
                context.showCustomSnackBar(
                  'Activity added successfully!',
                  type: SnackBarType.success,
                );
                Navigator.pop(context);
              } else if (state is AddActivityError) {
                context.showCustomSnackBar(
                  'Error: ${state.message}',
                  type: SnackBarType.error,
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<AddActivityCubit>();
              return _buildFormContent(state is AddActivityLoading,
                  cubit: cubit);
            },
          ),
        );

      case 'trip':
      case 'رحلة':
        return BlocProvider(
          create: (context) => AddTripCubit(),
          child: BlocConsumer<AddTripCubit, AddTripState>(
            listener: (context, state) {
              if (state is AddTripSuccess) {
                context.showCustomSnackBar(
                  'Trip added successfully!',
                  type: SnackBarType.success,
                );
                Navigator.pop(context);
              } else if (state is AddTripError) {
                context.showCustomSnackBar(
                  'Error: ${state.message}',
                  type: SnackBarType.error,
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<AddTripCubit>();
              return _buildFormContent(state is AddTripLoading, cubit: cubit);
            },
          ),
        );

      case 'product':
      case 'منتج':
        return BlocProvider(
          create: (context) => AddProductCubit(),
          child: BlocConsumer<AddProductCubit, AddProductState>(
            listener: (context, state) {
              if (state is AddProductSuccess) {
                context.showCustomSnackBar(
                  'Product added successfully!',
                  type: SnackBarType.success,
                );
                Navigator.pop(context);
              } else if (state is AddProductError) {
                context.showCustomSnackBar(
                  'Error: ${state.message}',
                  type: SnackBarType.error,
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<AddProductCubit>();
              return _buildFormContent(state is AddProductLoading,
                  cubit: cubit);
            },
          ),
        );
      case 'addAccommodation':
      case 'إقامة':
        return BlocProvider(
          create: (context) => AddAccommodationCubit(),
          child: BlocConsumer<AddAccommodationCubit, AddAccommodationState>(
            listener: (context, state) {
              if (state is AddAccommodationSuccess) {
                context.showCustomSnackBar(
                  'Accommodation added successfully!',
                  type: SnackBarType.success,
                );
                Navigator.pop(context);
              } else if (state is AddAccommodationError) {
                context.showCustomSnackBar(
                  'Error: ${state.message}',
                  type: SnackBarType.error,
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<AddAccommodationCubit>();
              return _buildFormContent(state is AddAccommodationLoading,
                  cubit: cubit);
            },
          ),
        );

      default:
        // For accommodation or other types, use the callback approach
        return _buildFormContent(_isSubmitting);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C8B8B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C8B8B),
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            // Check if this is accommodation type
            if (widget.partnerType.toLowerCase().contains('accommodation') ||
                widget.partnerType.toLowerCase().contains('accommodation')) {
              print(
                  'Accommodation type detected, navigating to addAccommodation');
              Navigator.pushNamed(context, 'addAccommodation');
            }
          },
          child: Text(
            'Add Service',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _buildCubitProvider(),
    );
  }

  Widget _buildFormContent(bool isLoading, {dynamic cubit}) {
    return Container(
      decoration: const BoxDecoration(
        color: appBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Add ${widget.partnerType}',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: appTextColor,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Form Fields
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: _config.fields.length,
                      itemBuilder: (context, index) {
                        final field = _config.fields[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: _buildFormField(field),
                        );
                      },
                    ),
                  ),

                  // Submit Button
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _submitForm(cubit),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appTextColor,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  'Submitting...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(ServiceFormField field) {
    switch (field.type) {
      case ServiceFieldType.imageUpload:
        return ImageUploadWidget(
          label: field.label,
          onImagesSelected: (images) {
            _formData[field.key] = images;
          },
          initialImages: _formData[field.key] as List<String>? ?? [],
        );

      case ServiceFieldType.roomSection:
        return RoomSectionWidget(
          onRoomsChanged: (roomsData) {
            _formData[field.key] = roomsData;
          },
        );

      case ServiceFieldType.featuresSection:
        return FeaturesSectionWidget(
          onFeaturesChanged: (features) {
            _formData[field.key] = features;
          },
        );

      case ServiceFieldType.categoryDropdown:
        return CategoryDropdownWidget(
          label: field.label,
          placeholder: field.placeholder,
          isRequired: field.isRequired,
          initialValue: _formData[field.key]?.toString(),
          onChanged: (value) {
            print('Category selected: $value');
            _formData[field.key] = value;
          },
        );

      default:
        return CustomFormField(
          field: field,
          controller: _controllers[field.key] ?? TextEditingController(),
          onChanged: (value) {
            _formData[field.key] = value;
          },
        );
    }
  }

  void _submitForm(dynamic cubit) {
    print('=== SUBMIT FORM STARTED ===');

    if (_formKey.currentState!.validate()) {
      print('Form validation passed');

      // Check if required data is present
      final hasRequiredFields = _checkRequiredFields();
      if (!hasRequiredFields) {
        print('Missing required fields');
        context.showCustomSnackBar(
          'Please fill all required fields',
          type: SnackBarType.error,
        );
        return;
      }

      // Collect all form data
      final submissionData = Map<String, dynamic>.from(_formData);

      // Add data from controllers
      for (final entry in _controllers.entries) {
        submissionData[entry.key] = entry.value.text;
      }

      // Add partner type
      submissionData['partner_type'] = widget.partnerType;

      print('Form data collected: ${submissionData.keys}');
      print('📋 Complete form data: $submissionData');
      print('🏷️ Category ID: ${submissionData['categoryId']}');

      // Call appropriate cubit method based on partner type
      switch (widget.partnerType.toLowerCase()) {
        case 'activity':
        case 'نشاط':
          if (cubit != null) {
            cubit.addActivityWithData(submissionData);
          }
          break;

        case 'trip':
        case 'رحلة':
          if (cubit != null) {
            cubit.addTripWithData(submissionData);
          }
          break;

        case 'product':
        case 'منتج':
          if (cubit != null) {
            cubit.addProductWithData(submissionData);
          }
          break;

        case 'accommodation':
        case 'الإقامة':
          if (cubit != null) {
            cubit.addAccommodation(submissionData);
          }
          break;

        default:
          // For accommodation or other types, use the callback approach
          setState(() {
            _isSubmitting = true;
          });

          // Notify parent about loading state change
          widget.onLoadingStateChanged?.call();

          try {
            // Call the callback with collected data
            widget.onFormSubmit?.call(submissionData);

            setState(() {
              _isSubmitting = false;
            });
            widget.onLoadingStateChanged?.call();

            // Show success message
            context.showCustomSnackBar(
              'Data collected successfully',
              type: SnackBarType.success,
            );
          } catch (e) {
            print('Error in _submitForm: $e');
            setState(() {
              _isSubmitting = false;
            });

            // Notify parent about loading state change
            widget.onLoadingStateChanged?.call();

            context.showCustomSnackBar(
              'Error in submitting the form: ${e.toString()}',
              type: SnackBarType.error,
            );
          }
      }
    } else {
      print('Form validation failed');
      context.showCustomSnackBar(
        'Please fill all required fields',
        type: SnackBarType.error,
      );
    }
  }

  bool _checkRequiredFields() {
    for (final field in _config.fields) {
      if (field.isRequired) {
        switch (field.type) {
          case ServiceFieldType.imageUpload:
            final images = _formData[field.key] as List?;
            if (images == null || images.isEmpty) {
              return false;
            }
            break;
          case ServiceFieldType.roomSection:
            final roomsData = _formData[field.key] as Map?;
            if (roomsData == null ||
                roomsData['rooms'] == null ||
                (roomsData['rooms'] as List).isEmpty) {
              return false;
            }
            break;
          case ServiceFieldType.categoryDropdown:
            final categoryValue = _formData[field.key];
            if (categoryValue == null ||
                categoryValue.toString().trim().isEmpty) {
              print('❌ Required field missing: ${field.key} = $categoryValue');
              return false;
            }
            print('✅ Required field present: ${field.key} = $categoryValue');
            break;
          default:
            final controller = _controllers[field.key];
            if (controller == null || controller.text.trim().isEmpty) {
              print(
                  '❌ Required field missing: ${field.key} = ${controller?.text}');
              return false;
            }
            print(
                '✅ Required field present: ${field.key} = ${controller.text}');
        }
      }
    }
    return true;
  }

  // Method to reset loading state (can be called from parent)
  void resetLoadingState() {
    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });
      // Notify parent about loading state change
      widget.onLoadingStateChanged?.call();
    }
  }
}
