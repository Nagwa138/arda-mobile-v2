import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';

part 'add_activity_state.dart';

class AddActivityCubit extends Cubit<AddActivityState> {
  AddActivityCubit() : super(AddActivityInitial());

  final imagePicker = ImagePicker();
  final storage = FlutterSecureStorage();
  final Api api = Api();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController durationInHoursController =
      TextEditingController();
  final TextEditingController pricePerPersonController =
      TextEditingController();
  final TextEditingController activityLocationController =
      TextEditingController();
  final TextEditingController providerNameController = TextEditingController();
  final TextEditingController workTimesController = TextEditingController();
  final TextEditingController whatsIncludedController = TextEditingController();
  final TextEditingController rulesAndCancellationPolicyController =
      TextEditingController();
  final TextEditingController importantInformationController =
      TextEditingController();

  // Image
  XFile? activityImage;

  // Pick image
  Future<void> pickImage({bool fromGallery = true}) async {
    try {
      final XFile? image = await imagePicker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      );
      if (image != null) {
        activityImage = image;
        emit(AddActivityImagePicked());
      }
    } catch (e) {
      emit(AddActivityError('Error picking image: $e'));
    }
  }

  // Remove image
  void removeImage() {
    activityImage = null;
    emit(AddActivityImageRemoved());
  }

  // Upload image
  Future<String?> uploadImage(XFile image) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(api.uploadImage));
      request.files
          .add(await http.MultipartFile.fromPath('Images', image.path));

      http.StreamedResponse response = await request.send();
      var responseData =
          await json.decode(await response.stream.bytesToString());

      if (response.statusCode == 200 && responseData.isNotEmpty) {
        return responseData[0]; // Return first uploaded image URL
      }
      return null;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Get user ID and company ID from profile
  Future<Map<String, String?>> getUserAndCompanyIds() async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) {
        print('No token found');
        return {'userId': null, 'companyId': null};
      }

      // Get company information
      final response = await http.get(
        Uri.parse('${Api.BASE_URL}/api/PartenerInfo'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Profile response: $responseData');

        // Extract company ID from the response
        String? companyId;
        if (responseData['data'] != null &&
            responseData['data']['id'] != null) {
          companyId = responseData['data']['id'].toString();
        }

        // For now, we'll use the company ID as user ID since they're often the same for partners
        // You might need to adjust this based on your API structure
        String? userId = companyId;

        print('Extracted userId: $userId, companyId: $companyId');
        return {'userId': userId, 'companyId': companyId};
      } else {
        print(
            'Failed to get profile: ${response.statusCode} - ${response.body}');
        return {'userId': null, 'companyId': null};
      }
    } catch (e) {
      print('Error getting user and company IDs: $e');
      return {'userId': null, 'companyId': null};
    }
  }

  // Add activity
  Future<void> addActivity() async {
    try {
      emit(AddActivityLoading());

      // Validate required fields
      if (nameController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          durationInHoursController.text.isEmpty ||
          pricePerPersonController.text.isEmpty ||
          activityLocationController.text.isEmpty ||
          providerNameController.text.isEmpty ||
          workTimesController.text.isEmpty ||
          whatsIncludedController.text.isEmpty ||
          rulesAndCancellationPolicyController.text.isEmpty ||
          activityImage == null) {
        emit(AddActivityError('Please fill all required fields'));
        return;
      }

      // Get token
      final token = await storage.read(key: "token");
      if (token == null) {
        emit(AddActivityError('Authentication required'));
        return;
      }

      // Upload image
      final imageUrl = await uploadImage(activityImage!);
      if (imageUrl == null) {
        emit(AddActivityError('Failed to upload image'));
        return;
      }

      // Get user ID and company ID from profile
      final ids = await getUserAndCompanyIds();
      final userId = ids['userId'];
      final companyId = ids['companyId'];

      // Prepare request body
      final requestBody = {
        "Name": nameController.text,
        "Description": descriptionController.text,
        "DurationInHours": int.parse(durationInHoursController.text),
        "PricePerPerson": double.parse(pricePerPersonController.text),
        "Image": imageUrl,
        "ActivityLocation": activityLocationController.text,
        "CompanyId": companyId ?? "",
        "UserId": userId ?? "",
        "ProviderName": providerNameController.text,
        "WorkTimes": workTimesController.text,
        "WhatsIncluded": whatsIncludedController.text,
        "RulesAndCancellationPolicy": rulesAndCancellationPolicyController.text,
        "ImportantInformation": importantInformationController.text.isNotEmpty
            ? importantInformationController.text
            : null,
      };

      print('Request body: $requestBody');

      // Send request using multipart/form-data
      var multipartRequest = http.MultipartRequest(
        'POST',
        Uri.parse('${Api.BASE_URL}/api/Companies/AddPartnerActivity'),
      );

      // Add authorization header
      multipartRequest.headers['Authorization'] = 'Bearer $token';

      // Add form fields
      requestBody.forEach((key, value) {
        if (value != null) {
          multipartRequest.fields[key] = value.toString();
        }
      });

      print('=== MULTIPART REQUEST ===');
      print('Request fields: ${multipartRequest.fields}');

      final response = await multipartRequest.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = json.decode(responseBody);

      print('Response status: ${response.statusCode}');
      print('Response body: $responseData');

      if (response.statusCode == 200) {
        emit(AddActivitySuccess());
      } else {
        emit(AddActivityError(
            responseData['message'] ?? 'Failed to add activity'));
      }
    } catch (e) {
      print('Error in addActivity: $e');
      emit(AddActivityError('Error: $e'));
    }
  }

  // Add activity with form data
  Future<void> addActivityWithData(Map<String, dynamic> formData) async {
    try {
      emit(AddActivityLoading());

      // Validate required fields
      if (formData['name']?.toString().isEmpty == true ||
          formData['description']?.toString().isEmpty == true ||
          formData['durationInHours']?.toString().isEmpty == true ||
          formData['pricePerPerson']?.toString().isEmpty == true ||
          formData['activityLocation']?.toString().isEmpty == true ||
          formData['providerName']?.toString().isEmpty == true ||
          formData['workTimes']?.toString().isEmpty == true ||
          formData['whatsIncluded']?.toString().isEmpty == true ||
          formData['rulesAndCancellationPolicy']?.toString().isEmpty == true) {
        emit(AddActivityError('Please fill all required fields'));
        return;
      }

      // Get token
      final token = await storage.read(key: "token");
      if (token == null) {
        emit(AddActivityError('Authentication required'));
        return;
      }

      // Handle image upload
      String? imageUrl;
      final images = formData['image'] as List?;
      print('=== IMAGE DEBUG ===');
      print('Images data type: ${images.runtimeType}');
      print('Images content: $images');

      if (images != null && images.isNotEmpty) {
        print('First image type: ${images[0].runtimeType}');
        print('First image content: ${images[0]}');

        if (images[0] is XFile) {
          print('Processing as XFile');
          imageUrl = await uploadImage(images[0] as XFile);
        } else if (images[0] is String) {
          print('Processing as String path');
          // Convert string path to XFile and upload
          final imagePath = images[0] as String;
          final imageFile = XFile(imagePath);
          print('Created XFile from path: $imagePath');
          imageUrl = await uploadImage(imageFile);
          print('Upload result: $imageUrl');
        }
      }

      if (imageUrl == null) {
        print('Image upload failed or no image provided');
        emit(AddActivityError('Image is required'));
        return;
      }

      print('Final image URL: $imageUrl');

      // Get user ID and company ID from profile
      final ids = await getUserAndCompanyIds();
      final userId = ids['userId'];
      final companyId = ids['companyId'];

      // Prepare request body
      final requestBody = {
        "Name": formData['name']?.toString() ?? "",
        "Description": formData['description']?.toString() ?? "",
        "DurationInHours":
            int.tryParse(formData['durationInHours']?.toString() ?? "0") ?? 0,
        "PricePerPerson":
            double.tryParse(formData['pricePerPerson']?.toString() ?? "0") ??
                0.0,
        "Image": imageUrl,
        "ActivityLocation": formData['activityLocation']?.toString() ?? "",
        "CompanyId": companyId ?? "",
        "UserId": userId ?? "",
        "ProviderName": formData['providerName']?.toString() ?? "",
        "WorkTimes": formData['workTimes']?.toString() ?? "",
        "WhatsIncluded": formData['whatsIncluded']?.toString() ?? "",
        "RulesAndCancellationPolicy":
            formData['rulesAndCancellationPolicy']?.toString() ?? "",
        "ImportantInformation":
            formData['importantInformation']?.toString().isNotEmpty == true
                ? formData['importantInformation']?.toString()
                : null,
      };

      print('=== FINAL REQUEST BODY ===');
      print('Request body: $requestBody');
      print('Image field value: ${requestBody["Image"]}');
      print('Image field type: ${requestBody["Image"].runtimeType}');

      // Send request using multipart/form-data (like in Swagger)
      var multipartRequest = http.MultipartRequest(
        'POST',
        Uri.parse('${Api.BASE_URL}/api/Companies/AddPartnerActivity'),
      );

      // Add authorization header
      multipartRequest.headers['Authorization'] = 'Bearer $token';

      // Add form fields
      requestBody.forEach((key, value) {
        if (value != null) {
          multipartRequest.fields[key] = value.toString();
        }
      });

      print('=== MULTIPART REQUEST ===');
      print('Request fields: ${multipartRequest.fields}');

      final response = await multipartRequest.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = json.decode(responseBody);

      print('Response status: ${response.statusCode}');
      print('Response body: $responseData');

      if (response.statusCode == 200) {
        emit(AddActivitySuccess());
      } else {
        emit(AddActivityError(
            responseData['message'] ?? 'Failed to add activity'));
      }
    } catch (e) {
      print('Error in addActivityWithData: $e');
      emit(AddActivityError('Error: $e'));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    descriptionController.dispose();
    durationInHoursController.dispose();
    pricePerPersonController.dispose();
    activityLocationController.dispose();
    providerNameController.dispose();
    workTimesController.dispose();
    whatsIncludedController.dispose();
    rulesAndCancellationPolicyController.dispose();
    importantInformationController.dispose();
    return super.close();
  }
}
