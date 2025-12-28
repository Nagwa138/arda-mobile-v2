import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';

part 'add_trip_state.dart';

class AddTripCubit extends Cubit<AddTripState> {
  AddTripCubit() : super(AddTripInitial());

  final imagePicker = ImagePicker();
  final storage = FlutterSecureStorage();
  final Api api = Api();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pricePerPersonController =
      TextEditingController();
  final TextEditingController pickupMeetingLocationController =
      TextEditingController();
  final TextEditingController providerNameController = TextEditingController();
  final TextEditingController durationInHoursController =
      TextEditingController();
  final TextEditingController endPointController = TextEditingController();
  final TextEditingController whatsIncludedController = TextEditingController();
  final TextEditingController rulesAndCancellationPolicyController =
      TextEditingController();
  final TextEditingController importantInformationController =
      TextEditingController();

  // Image
  XFile? tripImage;

  // Pick image
  Future<void> pickImage({bool fromGallery = true}) async {
    try {
      final XFile? image = await imagePicker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      );
      if (image != null) {
        tripImage = image;
        emit(AddTripImagePicked());
      }
    } catch (e) {
      emit(AddTripError('Error picking image: $e'));
    }
  }

  // Remove image
  void removeImage() {
    tripImage = null;
    emit(AddTripImageRemoved());
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

  // Add trip
  Future<void> addTrip() async {
    try {
      emit(AddTripLoading());

      // Validate required fields
      if (nameController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          pricePerPersonController.text.isEmpty ||
          pickupMeetingLocationController.text.isEmpty ||
          providerNameController.text.isEmpty ||
          durationInHoursController.text.isEmpty ||
          endPointController.text.isEmpty ||
          whatsIncludedController.text.isEmpty ||
          rulesAndCancellationPolicyController.text.isEmpty ||
          tripImage == null) {
        emit(AddTripError('Please fill all required fields'));
        return;
      }

      // Get token
      final token = await storage.read(key: "token");
      if (token == null) {
        emit(AddTripError('Authentication required'));
        return;
      }

      // Upload image
      final imageUrl = await uploadImage(tripImage!);
      if (imageUrl == null) {
        emit(AddTripError('Failed to upload image'));
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
        "PricePerPerson": double.parse(pricePerPersonController.text),
        "PickupMeetingLocation": pickupMeetingLocationController.text,
        "Image": imageUrl,
        "CompanyId": companyId ?? "",
        "UserId": userId ?? "",
        "ProviderName": providerNameController.text,
        "DurationInHours": durationInHoursController.text,
        "EndPoint": endPointController.text,
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
        Uri.parse('${Api.BASE_URL}/api/Companies/AddPartnerTrip'),
      );

      // Add authorization header
      multipartRequest.headers['Authorization'] = 'Bearer $token';

      // Add form fields
      requestBody.forEach((key, value) {
        if (value != null) {
          multipartRequest.fields[key] = value.toString();
        }
      });

      final response = await multipartRequest.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = json.decode(responseBody);

      print('Response status: ${response.statusCode}');
      print('Response body: $responseData');

      if (response.statusCode == 200) {
        emit(AddTripSuccess());
      } else {
        emit(AddTripError(responseData['message'] ?? 'Failed to add trip'));
      }
    } catch (e) {
      print('Error in addTrip: $e');
      emit(AddTripError('Error: $e'));
    }
  }

  Future<void> addTripWithData(Map<String, dynamic> formData) async {
    try {
      emit(AddTripLoading());

      // Validate required fields
      if (formData['name']?.toString().isEmpty == true ||
          formData['description']?.toString().isEmpty == true ||
          formData['pricePerPerson']?.toString().isEmpty == true ||
          formData['pickupMeetingLocation']?.toString().isEmpty == true ||
          formData['providerName']?.toString().isEmpty == true ||
          formData['durationInHours']?.toString().isEmpty == true ||
          formData['endPoint']?.toString().isEmpty == true ||
          formData['whatsIncluded']?.toString().isEmpty == true ||
          formData['rulesAndCancellationPolicy']?.toString().isEmpty == true) {
        emit(AddTripError('Please fill all required fields'));
        return;
      }

      // Get token
      final token = await storage.read(key: "token");
      if (token == null) {
        emit(AddTripError('Authentication required'));
        return;
      }

      // Handle image upload
      String? imageUrl;
      final images = formData['image'] as List?;
      if (images != null && images.isNotEmpty) {
        if (images[0] is XFile) {
          imageUrl = await uploadImage(images[0] as XFile);
        } else if (images[0] is String) {
          // Convert string path to XFile and upload
          final imagePath = images[0] as String;
          final imageFile = XFile(imagePath);
          imageUrl = await uploadImage(imageFile);
        }
      }

      if (imageUrl == null) {
        emit(AddTripError('Image is required'));
        return;
      }

      // Get user ID and company ID from profile
      final ids = await getUserAndCompanyIds();
      final userId = ids['userId'];
      final companyId = ids['companyId'];

      // Prepare request body
      final requestBody = {
        "Name": formData['name']?.toString() ?? "",
        "Description": formData['description']?.toString() ?? "",
        "PricePerPerson":
            double.tryParse(formData['pricePerPerson']?.toString() ?? "0") ??
                0.0,
        "PickupMeetingLocation":
            formData['pickupMeetingLocation']?.toString() ?? "",
        "Image": imageUrl,
        "CompanyId": companyId ?? "",
        "UserId": userId ?? "",
        "ProviderName": formData['providerName']?.toString() ?? "",
        "DurationInHours": formData['durationInHours']?.toString() ?? "",
        "EndPoint": formData['endPoint']?.toString() ?? "",
        "WhatsIncluded": formData['whatsIncluded']?.toString() ?? "",
        "RulesAndCancellationPolicy":
            formData['rulesAndCancellationPolicy']?.toString() ?? "",
        "ImportantInformation":
            formData['importantInformation']?.toString().isNotEmpty == true
                ? formData['importantInformation']?.toString()
                : null,
      };

      print('Request body: $requestBody');

      // Send request using multipart/form-data (like in Swagger)
      var multipartRequest = http.MultipartRequest(
        'POST',
        Uri.parse('${Api.BASE_URL}/api/Companies/AddPartnerTrip'),
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
        emit(AddTripSuccess());
      } else {
        emit(AddTripError(responseData['message'] ?? 'Failed to add trip'));
      }
    } catch (e) {
      print('Error in addTripWithData: $e');
      emit(AddTripError('Error: $e'));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    descriptionController.dispose();
    pricePerPersonController.dispose();
    pickupMeetingLocationController.dispose();
    providerNameController.dispose();
    durationInHoursController.dispose();
    endPointController.dispose();
    whatsIncludedController.dispose();
    rulesAndCancellationPolicyController.dispose();
    importantInformationController.dispose();
    return super.close();
  }
}
