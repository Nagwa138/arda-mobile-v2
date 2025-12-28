import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import 'package:PassPort/version2_module/core/enums/booking_status.dart';
import 'package:PassPort/version2_module/core/enums/user_type.dart';
import '../../domain/models/partner_booking_model.dart';
import 'partner_bookings_state.dart';

class PartnerBookingsCubit extends Cubit<PartnerBookingsState> {
  PartnerBookingsCubit() : super(PartnerBookingsInitial());

  static PartnerBookingsCubit get(context) => BlocProvider.of(context);

  final storage = const FlutterSecureStorage();

  List<PartnerBookingModel> _allBookings = [];
  List<PartnerBookingModel> _filteredBookings = [];

  BookingStatus? _currentStatusFilter;
  DateTime? _startDateFilter;
  DateTime? _endDateFilter;
  UserType? _currentPartnerType;

  // Getters
  List<PartnerBookingModel> get allBookings => _allBookings;
  List<PartnerBookingModel> get filteredBookings => _filteredBookings;
  BookingStatus? get currentStatusFilter => _currentStatusFilter;
  DateTime? get startDateFilter => _startDateFilter;
  DateTime? get endDateFilter => _endDateFilter;
  UserType? get currentPartnerType => _currentPartnerType;

  Future<void> loadBookings({
    UserType? partnerType,
    BookingStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    int skip = 0,
    int take = 10,
    bool refresh = false,
  }) async {
    if (refresh || _allBookings.isEmpty) {
      emit(PartnerBookingsLoading());
    }

    try {
      _currentPartnerType = partnerType;
      _currentStatusFilter = status;
      _startDateFilter = startDate;
      _endDateFilter = endDate;

      final token = await storage.read(key: 'token');
      if (token == null) {
        emit(PartnerBookingsError('No authentication token found'));
        return;
      }

      // Debug token format
      log('Partner Bookings: Token length - ${token.length}');
      log('Partner Bookings: Token format check - ${token.contains('.') ? 'Valid JWT format' : 'Invalid format'}');

      // If partnerType is not provided, try to get it from storage
      if (partnerType == null) {
        final userTypeString = await storage.read(key: 'userType');
        if (userTypeString != null) {
          try {
            final userTypeId = int.parse(userTypeString);
            partnerType = UserType.fromId(userTypeId);
            log('Partner Bookings: Got user type from storage - $partnerType');
          } catch (e) {
            log('Partner Bookings: Error parsing user type from storage - $e');
          }
        }
      }

      final endpoint = _getEndpointForPartnerType(partnerType);
      final uri =
          Uri.parse('${Api.BASE_URL}$endpoint').replace(queryParameters: {
        if (status != null) 'status': status.id.toString(),
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
        'skip': skip.toString(),
        'take': take.toString(),
      });

      log('Partner Bookings: Full URL - $uri');
      log('Partner Bookings: Headers - Authorization: Bearer ${token.substring(0, 20)}...');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      log('Partner Bookings Response: ${response.statusCode}');
      log('Partner Bookings Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final bookingsResponse = PartnerBookingsResponse.fromJson(jsonData);

        if (refresh || skip == 0) {
          _allBookings = bookingsResponse.bookings;
        } else {
          _allBookings.addAll(bookingsResponse.bookings);
        }

        _applyFilters();
        emit(PartnerBookingsLoaded(
          bookings: _filteredBookings,
          hasMore: bookingsResponse.hasMore,
          totalCount: bookingsResponse.totalCount,
        ));
      } else if (response.statusCode == 403) {
        log('Partner Bookings: 403 Forbidden - Token may be invalid or expired');
        log('Partner Bookings: Response body - ${response.body}');

        // Try to decode JWT token to check expiration
        try {
          final parts = token.split('.');
          if (parts.length == 3) {
            final payload = parts[1];
            final normalized = base64Url.normalize(payload);
            final resp = utf8.decode(base64Url.decode(normalized));
            final payloadMap = json.decode(resp);

            if (payloadMap['exp'] != null) {
              final exp =
                  DateTime.fromMillisecondsSinceEpoch(payloadMap['exp'] * 1000);
              final now = DateTime.now();
              log('Partner Bookings: Token expires at - $exp');
              log('Partner Bookings: Current time - $now');
              log('Partner Bookings: Token expired - ${now.isAfter(exp)}');

              if (now.isAfter(exp)) {
                emit(PartnerBookingsError(
                    'Authentication token has expired. Please login again.'));
                return;
              }
            }

            // Log user information from token
            if (payloadMap['role'] != null) {
              log('Partner Bookings: User role from token - ${payloadMap['role']}');
            }
            if (payloadMap['unique_name'] != null) {
              log('Partner Bookings: Username from token - ${payloadMap['unique_name']}');
            }
          }
        } catch (e) {
          log('Partner Bookings: Error decoding JWT token - $e');
        }

        // Try alternative endpoint for activity bookings
        if (partnerType == UserType.activity) {
          log('Partner Bookings: Trying alternative endpoint for activity bookings');
          try {
            final altResponse = await http.get(
              Uri.parse('${Api.BASE_URL}/api/Booking/GetMyRequests'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            );
            log('Partner Bookings: Alternative endpoint response - ${altResponse.statusCode}');
            if (altResponse.statusCode == 200) {
              log('Partner Bookings: Alternative endpoint works, using it instead');
              // Use the alternative endpoint
              final jsonData = json.decode(altResponse.body);
              final bookingsResponse =
                  PartnerBookingsResponse.fromJson(jsonData);

              if (refresh || skip == 0) {
                _allBookings = bookingsResponse.bookings;
              } else {
                _allBookings.addAll(bookingsResponse.bookings);
              }

              _applyFilters();
              emit(PartnerBookingsLoaded(
                bookings: _filteredBookings,
                hasMore: bookingsResponse.hasMore,
                totalCount: bookingsResponse.totalCount,
              ));
              return;
            }
          } catch (e) {
            log('Partner Bookings: Alternative endpoint failed - $e');
          }
        }

        // Try to parse error message from response
        String errorMessage =
            'Access denied. Please check your authentication token.';
        if (response.body.isNotEmpty) {
          try {
            final errorJson = json.decode(response.body);
            if (errorJson['message'] != null) {
              errorMessage = errorJson['message'];
            }
          } catch (e) {
            log('Partner Bookings: Could not parse error response - $e');
          }
        }

        emit(PartnerBookingsError(errorMessage));
      } else {
        emit(PartnerBookingsError(
            'Failed to load bookings: ${response.statusCode} - ${response.body}'));
      }
    } catch (e) {
      log('Error loading partner bookings: $e');
      emit(PartnerBookingsError('Error loading bookings: $e'));
    }
  }

  /// Returns the appropriate API endpoint based on partner type
  ///
  /// API Endpoint Mapping:
  /// - Accommodation: /api/Booking/GetMyRequests
  /// - Product: /api/Booking/GetMyOrderRequests
  /// - Activity: /api/Booking/GetMyActivityRequests
  /// - Trip: /api/Booking/GetMyTripRequests
  /// - Default: /api/Booking/GetMyRequests
  String _getEndpointForPartnerType(UserType? partnerType) {
    switch (partnerType) {
      case UserType.accommodation:
        return '/api/Booking/GetMyRequests';
      case UserType.product:
        return '/api/Booking/GetMyOrderRequests';
      case UserType.activity:
        return '/api/Booking/GetMyActivityRequests';
      case UserType.trip:
        return '/api/Booking/GetMyTripRequests';
      default:
        return '/api/Booking/GetMyRequests';
    }
  }

  /// Test API connectivity with a simple endpoint
  Future<bool> testApiConnectivity() async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) return false;

      final response = await http.get(
        Uri.parse('${Api.BASE_URL}/api/Booking/GetMyRequests'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      log('Partner Bookings: API connectivity test - ${response.statusCode}');
      return response.statusCode == 200 ||
          response.statusCode == 401 ||
          response.statusCode == 403;
    } catch (e) {
      log('Partner Bookings: API connectivity test failed - $e');
      return false;
    }
  }

  void applyStatusFilter(BookingStatus? status) {
    _currentStatusFilter = status;
    _applyFilters();
    emit(PartnerBookingsLoaded(
      bookings: _filteredBookings,
      hasMore: false,
      totalCount: _filteredBookings.length,
    ));
  }

  void applyDateFilter(DateTime? startDate, DateTime? endDate) {
    _startDateFilter = startDate;
    _endDateFilter = endDate;
    _applyFilters();
    emit(PartnerBookingsLoaded(
      bookings: _filteredBookings,
      hasMore: false,
      totalCount: _filteredBookings.length,
    ));
  }

  void clearFilters() {
    _currentStatusFilter = null;
    _startDateFilter = null;
    _endDateFilter = null;
    _applyFilters();
    emit(PartnerBookingsLoaded(
      bookings: _filteredBookings,
      hasMore: false,
      totalCount: _filteredBookings.length,
    ));
  }

  void _applyFilters() {
    _filteredBookings = _allBookings.where((booking) {
      // Status filter - use bookingStatus getter instead of status property
      if (_currentStatusFilter != null &&
          booking.bookingStatus != _currentStatusFilter) {
        return false;
      }

      // Date filter - use bookingDate since checkIn/checkOut are not directly available
      if (_startDateFilter != null &&
          booking.bookingDate.isBefore(_startDateFilter!)) {
        return false;
      }

      if (_endDateFilter != null &&
          booking.bookingDate.isAfter(_endDateFilter!)) {
        return false;
      }

      return true;
    }).toList();

    // Sort by booking date (most recent first)
    _filteredBookings.sort((a, b) => b.bookingDate.compareTo(a.bookingDate));
  }

  /// Accept a booking request using the AcceptBooking API endpoint
  Future<void> acceptBooking(String bookingId) async {
    emit(PartnerBookingsLoading());

    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        emit(PartnerBookingsError('No authentication token found'));
        return;
      }

      final response = await http.post(
        Uri.parse('${Api.BASE_URL}/api/Booking/AcceptBooking?id=$bookingId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Update local data
        final bookingIndex = _allBookings
            .indexWhere((b) => b.id == bookingId || b.bookingId == bookingId);
        if (bookingIndex != -1) {
          _allBookings[bookingIndex] =
              _allBookings[bookingIndex].copyWith(status: 'upcoming');
          _applyFilters();
        }

        emit(PartnerBookingsLoaded(
          bookings: _filteredBookings,
          hasMore: false,
          totalCount: _filteredBookings.length,
        ));
      } else {
        emit(PartnerBookingsError('Failed to accept booking'));
      }
    } catch (e) {
      log('Error accepting booking: $e');
      emit(PartnerBookingsError('Error accepting booking: $e'));
    }
  }

  /// Cancel a booking request with reason using the CancelBooking API endpoint
  Future<void> cancelBooking(String bookingId, int reason) async {
    emit(PartnerBookingsLoading());

    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        emit(PartnerBookingsError('No authentication token found'));
        return;
      }

      final response = await http.post(
        Uri.parse(
            '${Api.BASE_URL}/api/Booking/CancelBooking?id=$bookingId&reason=$reason'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Update local data
        final bookingIndex = _allBookings
            .indexWhere((b) => b.id == bookingId || b.bookingId == bookingId);
        if (bookingIndex != -1) {
          _allBookings[bookingIndex] =
              _allBookings[bookingIndex].copyWith(status: 'cancelled');
          _applyFilters();
        }

        emit(PartnerBookingsLoaded(
          bookings: _filteredBookings,
          hasMore: false,
          totalCount: _filteredBookings.length,
        ));
      } else {
        emit(PartnerBookingsError('Failed to cancel booking'));
      }
    } catch (e) {
      log('Error canceling booking: $e');
      emit(PartnerBookingsError('Error canceling booking: $e'));
    }
  }

  /// Legacy method for backward compatibility
  Future<void> updateBookingStatus(
      String bookingId, BookingStatus newStatus) async {
    switch (newStatus) {
      case BookingStatus.upcoming:
        await acceptBooking(bookingId);
        break;
      case BookingStatus.cancelled:
        await cancelBooking(bookingId, 0); // Default reason
        break;
      default:
        // For other status updates, use the original PUT method if needed
        emit(PartnerBookingsLoading());
        try {
          final token = await storage.read(key: 'token');
          if (token == null) {
            emit(PartnerBookingsError('No authentication token found'));
            return;
          }

          final response = await http.put(
            Uri.parse('${Api.BASE_URL}/api/Booking/UpdateBookingStatus'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'bookingId': bookingId,
              'status': newStatus.id,
            }),
          );

          if (response.statusCode == 200) {
            // Update local data
            final bookingIndex =
                _allBookings.indexWhere((b) => b.id == bookingId);
            if (bookingIndex != -1) {
              _allBookings[bookingIndex] = _allBookings[bookingIndex]
                  .copyWith(status: newStatus.displayName.toLowerCase());
              _applyFilters();
            }

            emit(PartnerBookingsLoaded(
              bookings: _filteredBookings,
              hasMore: false,
              totalCount: _filteredBookings.length,
            ));
          } else {
            emit(PartnerBookingsError('Failed to update booking status'));
          }
        } catch (e) {
          log('Error updating booking status: $e');
          emit(PartnerBookingsError('Error updating booking status: $e'));
        }
    }
  }

  List<PartnerBookingModel> getBookingsByStatus(BookingStatus status) {
    return _allBookings
        .where((booking) => booking.bookingStatus == status)
        .toList();
  }

  int getBookingsCountByStatus(BookingStatus status) {
    return getBookingsByStatus(status).length;
  }

  Map<BookingStatus, int> getBookingsCountByAllStatuses() {
    final Map<BookingStatus, int> counts = {};
    for (final status in BookingStatus.values) {
      counts[status] = getBookingsCountByStatus(status);
    }
    return counts;
  }
}
