import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  final imagePicker = ImagePicker();
  final storage = FlutterSecureStorage();
  final Api api = Api();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController isDeliveryAvailableController =
      TextEditingController();
  final TextEditingController shippingCostController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController rulesAndCancellationPolicyController =
      TextEditingController();
  final TextEditingController importantInformationController =
      TextEditingController();

  // Image
  XFile? productImage;

  // Pick image
  Future<void> pickImage({bool fromGallery = true}) async {
    try {
      final XFile? image = await imagePicker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1920,
      );
      if (image != null) {
        productImage = image;
        emit(AddProductImagePicked());
      }
    } catch (e) {
      emit(AddProductError('Error picking image: $e'));
    }
  }

  // Remove image
  void removeImage() {
    productImage = null;
    emit(AddProductImageRemoved());
  }

  // Upload image
  Future<String?> uploadImage(XFile image) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(api.uploadproductImages));
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

  // Add product
  Future<void> addProduct() async {
    try {
      emit(AddProductLoading());

      // Validate required fields
      if (nameController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          priceController.text.isEmpty ||
          categoryIdController.text.isEmpty ||
          isDeliveryAvailableController.text.isEmpty ||
          locationController.text.isEmpty ||
          rulesAndCancellationPolicyController.text.isEmpty ||
          productImage == null) {
        emit(AddProductError('Please fill all required fields'));
        return;
      }

      // Get token
      final token = await storage.read(key: "token");
      if (token == null) {
        emit(AddProductError('Authentication required'));
        return;
      }

      // Upload image
      final imageUrl = await uploadImage(productImage!);
      if (imageUrl == null) {
        emit(AddProductError('Failed to upload image'));
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
        "Price": double.parse(priceController.text),
        "CategoryId": categoryIdController.text,
        "IsDeliveryAvailable":
            isDeliveryAvailableController.text.toLowerCase() == 'yes',
        "ShippingCost": shippingCostController.text.isNotEmpty
            ? double.parse(shippingCostController.text)
            : null,
        "Location": locationController.text,
        "Image": imageUrl,
        "CompanyId": companyId ?? "",
        "UserId": userId ?? "",
        "RulesAndCancellationPolicy": rulesAndCancellationPolicyController.text,
        "ImportantInformation": importantInformationController.text.isNotEmpty
            ? importantInformationController.text
            : null,
      };

      print('Request body: $requestBody');

      // Send request using JSON
      final response = await http.post(
        Uri.parse('${Api.BASE_URL}/api/Companies/AddPartnerProduct'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      final responseData = json.decode(response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: $responseData');

      if (response.statusCode == 200) {
        emit(AddProductSuccess());
      } else {
        emit(AddProductError(
            responseData['message'] ?? 'Failed to add product'));
      }
    } catch (e) {
      print('Error in addProduct: $e');
      emit(AddProductError('Error: $e'));
    }
  }

  // Add product with form data
  Future<void> addProductWithData(Map<String, dynamic> formData) async {
    try {
      emit(AddProductLoading());

      // Validate required fields
      if (formData['name']?.toString().isEmpty == true ||
          formData['description']?.toString().isEmpty == true ||
          formData['price']?.toString().isEmpty == true ||
          formData['categoryId']?.toString().isEmpty == true ||
          formData['isDeliveryAvailable']?.toString().isEmpty == true ||
          formData['location']?.toString().isEmpty == true ||
          formData['rulesAndCancellationPolicy']?.toString().isEmpty == true) {
        emit(AddProductError('Please fill all required fields'));
        return;
      }

      // Get token
      final token = await storage.read(key: "token");
      if (token == null) {
        emit(AddProductError('Authentication required'));
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
        emit(AddProductError('Image is required'));
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
        "Price": double.tryParse(formData['price']?.toString() ?? "0") ?? 0.0,
        "CategoryId": formData['categoryId']?.toString() ?? "",
        "IsDeliveryAvailable":
            (formData['isDeliveryAvailable']?.toString() ?? "").toLowerCase() ==
                'yes',
        "ShippingCost": formData['shippingCost']?.toString().isNotEmpty == true
            ? double.tryParse(formData['shippingCost']?.toString() ?? "0") ??
                0.0
            : null,
        "Location": formData['location']?.toString() ?? "",
        "Images": imageUrl,
        "CompanyId": companyId ?? "",
        "UserId": userId ?? "",
        "RulesAndCancellationPolicy":
            formData['rulesAndCancellationPolicy']?.toString() ?? "",
        "ImportantInformation":
            formData['importantInformation']?.toString().isNotEmpty == true
                ? formData['importantInformation']?.toString()
                : null,
      };

      print('Request body: $requestBody');

      // Send request using JSON
      final response = await http.post(
        Uri.parse('${Api.BASE_URL}/api/Companies/AddPartnerProduct'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      final responseData = json.decode(response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: $responseData');

      if (response.statusCode == 200) {
        emit(AddProductSuccess());
      } else {
        emit(AddProductError(
            responseData['message'] ?? 'Failed to add product'));
      }
    } catch (e) {
      print('Error in addProductWithData: $e');
      emit(AddProductError('Error: $e'));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryIdController.dispose();
    isDeliveryAvailableController.dispose();
    shippingCostController.dispose();
    locationController.dispose();
    rulesAndCancellationPolicyController.dispose();
    importantInformationController.dispose();
    return super.close();
  }
}
