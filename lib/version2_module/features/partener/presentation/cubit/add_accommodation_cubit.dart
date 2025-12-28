import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/models/add_accommodation_request.dart';
import 'package:PassPort/consts/api/api.dart';

part 'add_accommodation_state.dart';

class AddAccommodationCubit extends Cubit<AddAccommodationState> {
  AddAccommodationCubit() : super(AddAccommodationInitial());

  Future<void> addAccommodation(request) async {
    emit(AddAccommodationLoading());
    print('API Request: ${request.toJson()}');
    try {
      final url = Uri.parse('${Api.BASE_URL}/api/Accomodation');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddAccommodationSuccess());
      } else {
        emit(AddAccommodationError('Failed: ${response.body}'));
      }
    } catch (e) {
      emit(AddAccommodationError(e.toString()));
    }
  }
}
