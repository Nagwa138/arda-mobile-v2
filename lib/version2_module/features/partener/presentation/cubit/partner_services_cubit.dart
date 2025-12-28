import 'dart:convert';

import 'package:PassPort/version2_module/features/partener/presentation/models/trip_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/models/partner/ServicesModel.dart';
import 'package:PassPort/version2_module/core/utils/network_logger.dart';

import '../models/partner_service_item.dart';
import 'partner_services_state.dart';

class PartnerServicesCubit extends Cubit<PartnerServicesState> {
  PartnerServicesCubit() : super(PartnerServicesInitial());

  final _storage = const FlutterSecureStorage();
  final _api = Api();

  // Get user ID from profile
  // Future<String?> _getUserId() async {
  //   try {
  //     final token = await _storage.read(key: 'token');
  //     if (token == null) {
  //       print('No token found for getUserId');
  //       return null;
  //     } else {
  //       print('Token found for getUserId');
  //       print('Token: $token');
  //     }

  //     // Get user ID from profile API
  //     final response = await http.get(
  //       Uri.parse('${Api.BASE_URL}/api/PartenerInfo'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       print('Profile response: $responseData');

  //       if (responseData['data'] != null) {
  //         final data = responseData['data'];
  //         print('Profile data fields: ${data.keys.toList()}');

  //         // Get userId directly from profile
  //         if (data['id'] != null) {
  //           final userId = data['id'].toString();
  //           print('Found userId from profile: $userId');
  //           return userId;
  //         }
  //       }
  //     } else {
  //       print(
  //           'Failed to get profile: ${response.statusCode} - ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error getting user ID: $e');
  //   }
  //   return null;
  // }

  Future<String?> _getUserId() async {
    try {
      final token = await _storage.read(key: 'token');
      if (token == null) {
        print('No token found for getUserId');
        return null;
      } else {
        print('Token found for getUserId');
        print('Token: $token');
      }

      // Decode the JWT and extract the userId (nameid)
      final parts = token.split('.');
      if (parts.length != 3) {
        print('Invalid token format');
        return null;
      }

      String normalize(String str) {
        final pad = 4 - (str.length % 4);
        if (pad == 4) return str;
        return str + '=' * pad;
      }

      final payloadBase64 = normalize(parts[1]);
      final payloadString = utf8.decode(base64Url.decode(payloadBase64));
      final payload = json.decode(payloadString) as Map<String, dynamic>;

      final userId = payload['nameid'] ?? payload['sub'] ?? '';

      if (userId.isNotEmpty) {
        print('Decoded userId from token: $userId');
        return userId;
      } else {
        print('UserId not found in token payload');
      }
    } catch (e) {
      print('Error decoding token: $e');
    }
    return null;
  }

  Future<void> loadForCurrentUser({String query = '', int? status}) async {
    final userTypeStr = await _storage.read(key: 'userType');
    final userTypeId = int.tryParse(userTypeStr ?? '');
    PartnerServiceType type = PartnerServiceType.accommodation;
    if (userTypeId == 4) {
      type = PartnerServiceType.activity;
    } else if (userTypeId == 5) {
      type = PartnerServiceType.trip;
    } else if (userTypeId == 6) {
      type = PartnerServiceType.product;
    } else if (userTypeId == 3) {
      type = PartnerServiceType.accommodation;
    }
    await load(type, query: query, status: status);
  }

  Future<void> load(PartnerServiceType type,
      {String query = '', int? status}) async {
    emit(PartnerServicesLoading());
    try {
      final token = await _storage.read(key: 'token');
      late Uri uri;

      print('🔄 Loading partner services for type: $type');

      switch (type) {
        case PartnerServiceType.accommodation:
          final userId = await _getUserId();
          if (userId == null) {
            print('❌ Failed to get userId for accommodation');
            emit(PartnerServicesError(
                'Unable to get user ID for accommodation'));
            return;
          }
          final base = _api.getServices;
          // The base URL already ends with '?id=', so we just append the userId
          uri = Uri.parse('$base');
          // if (status != null) {
          //   uri = Uri.parse('$base$userId&status=$status');
          // }
          print('🏨 Accommodation URI: $uri');
          break;
        case PartnerServiceType.activity:
          final userId = await _getUserId();
          if (userId == null) {
            print('❌ Failed to get userId for activities');
            emit(PartnerServicesError('Unable to get user ID for activities'));
            return;
          }
          uri = Uri.parse(
              '${_api.getPartnerActivities}?userId=$userId&skip=0&take=50');
          print('🎯 Activity URI: $uri');
          break;
        case PartnerServiceType.product:
          final userId = await _getUserId();
          if (userId == null) {
            print('❌ Failed to get userId for products');
            emit(PartnerServicesError('Unable to get user ID for products'));
            return;
          }
          uri = Uri.parse(
              '${_api.getPartnerProducts}?userId=$userId&skip=0&take=50');
          print('🛍️ Product URI: $uri');
          break;
        case PartnerServiceType.trip:
          final userId = await _getUserId();
          if (userId == null) {
            print('❌ Failed to get userId for trips');
            emit(PartnerServicesError('Unable to get user ID for trips'));
            return;
          }
          uri = Uri.parse(
              '${_api.getPartnerTrips}?userId=$userId&skip=0&take=50');
          print('🚗 Trip URI: $uri');
          break;
      }

      NetworkLogger.logRequest('GET', uri,
          headers: token == null ? null : {'Authorization': 'Bearer $token'});
      final res = await http.get(uri,
          headers: token == null ? null : {'Authorization': 'Bearer $token'});
      NetworkLogger.logResponse(res);

      print('📥 API Response Status: ${res.statusCode}');
      print('📥 API Response Body: ${res.body}');

      final body = json.decode(res.body);
      // Gracefully handle empty/404 responses for accommodation by emitting empty items
      if (res.statusCode == 404) {
        final message = body is Map ? (body['message']?.toString() ?? '') : '';
        print('ℹ️ Treating 404 as empty list. Message: $message');
        emit(PartnerServicesLoaded(items: const [], type: type, query: query));
        return;
      }
      if (res.statusCode != 200) {
        print('❌ API Error: ${body['message']?.toString() ?? 'Failed'}');
        emit(PartnerServicesError(body['message']?.toString() ?? 'Failed'));
        return;
      }

      List<dynamic> items;
      if (type == PartnerServiceType.accommodation) {
        final dataJson = body['data'];
        if (dataJson == null || (dataJson is List && dataJson.isEmpty)) {
          items = const [];
        } else {
          try {
            print('🔍 Parsing accommodation data...');
            final model = ServicesModel.fromJson(body);
            print('✅ Model parsed, data count: ${model.data.length}');

            final accData = (model.data as List<Datum>);
            print('✅ accData casted successfully');

            items = accData.map((datum) {
              try {
                return _fromAccommodation(datum);
              } catch (e) {
                print('❌ Error in _fromAccommodation: $e');
                print('❌ Datum causing error: ${datum.toJson()}');
                rethrow;
              }
            }).toList();

            print('✅ Items mapped successfully: ${items.length}');
          } catch (e) {
            print('❌ Error parsing accommodation: $e');
            print('❌ Stack trace: ${StackTrace.current}');
            items = const [];
          }
        }
      } else {
        final data = (body['data'] as List?) ?? [];
        if (type == PartnerServiceType.activity) {
          items =
              data.map<PartnerServiceItem>((j) => _fromActivity(j)).toList();
        } else if (type == PartnerServiceType.product) {
          items = data.map<PartnerServiceItem>((j) => _fromProduct(j)).toList();
        } else {
          items = data.map<TripModel>((j) => _fromTrip(j)).toList();
        }
      }

      print('✅ Successfully loaded ${items.length} items');
      final filtered = query.isEmpty
          ? items
          : items
              .where((e) => e.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
      emit(PartnerServicesLoaded(items: filtered, type: type, query: query));
    } catch (e) {
      print('💥 Exception in load: $e');
      emit(PartnerServicesError(e.toString()));
    }
  }

  PartnerServiceItem _fromAccommodation(Datum d) => PartnerServiceItem(
        id: d.id ?? '',
        title: d.serviceName ?? '',
        location: d.address ?? '',
        priceText: '${d.reservationPrice ?? 0} EGP',
        rating: (d.rate is num) ? (d.rate as num).toDouble() : 0,
        imageUrl: d.coverPhotoUrl ?? '',
        status: d.status ?? 'Pending',
      );

  PartnerServiceItem _fromActivity(Map<String, dynamic> j) =>
      PartnerServiceItem(
        id: (j['id'] ?? '').toString(),
        title: (j['name'] ?? '').toString(),
        location: (j['activityLocation'] ?? '').toString(),
        priceText: '${j['pricePerPerson'] ?? 0} EGP',
        rating: 0,
        imageUrl: _resolveImage(_extractImage(j['image'] ?? j['images'])),
        status: (j['progressStatus'] ?? 'N/M').toString(),
      );

  PartnerServiceItem _fromProduct(Map<String, dynamic> j) => PartnerServiceItem(
        id: (j['id'] ?? '').toString(),
        title: (j['name'] ?? j['productName'] ?? '').toString(),
        location: (j['location'] ?? j['store'] ?? '').toString(),
        priceText: '${j['price'] ?? 0} EGP',
        rating: ((j['rate'] ?? 0) as num).toDouble(),
        imageUrl: _resolveImage(_extractImage(j['images'] ?? j['image'])),
        status: (j['progressStatus'] ?? 'Active').toString(),
      );

  TripModel _fromTrip(Map<String, dynamic> j) => TripModel(
        id: (j['id'] ?? '').toString(),
        title: (j['name'] ?? j['tripName'] ?? '').toString(),
        description: (j['description'] ?? '').toString(),
        priceText: (j['pricePerPerson'] ?? 0),
        rating: ((j['rate'] ?? 0) as num).toDouble(),
        location: (j['pickupMeetingLocation'] ?? '').toString(),
        imageUrl: (j['image'] ?? '').toString(),
        companyId: (j['companyId'] ?? '').toString(),
        providerName: (j['providerName'] ?? '').toString(),
        durationInHours: (j['durationInHours'] ?? '').toString(),
        endPoint: (j['endPoint'] ?? '').toString(),
        whatsIncluded: (j['whatsIncluded'] ?? '').toString(),
        rulesAndCancellationPolicy:
            (j['rulesAndCancellationPolicy'] ?? '').toString(),
        importantInformation: (j['importantInformation'] ?? '').toString(),
        status: (j['progressStatus'] ?? '').toString(),
        rejectionReason: (j['rejectionReason'] ?? '').toString(),
        activationStatus: (j['activationStatus'] ?? '').toString(),
      );

  String _resolveImage(dynamic key) {
    if (key == null) return '';
    final s = key.toString();
    if (s.isEmpty) return '';
    if (s.startsWith('http')) return s;
    return '${Api.BASE_URL}/resources/images/$s';
  }

  String _extractImage(dynamic value) {
    if (value == null) return '';
    if (value is List) {
      if (value.isNotEmpty) return value.first.toString();
      return '';
    }
    return value.toString();
  }
}
