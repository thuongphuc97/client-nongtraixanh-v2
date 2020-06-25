import 'package:flutter_travel_ui/models/booking_model.dart';

import '../networking/api_provider.dart';
import '../models/tour_model.dart';
import 'dart:async';

class BookingRepository {
  ApiProvider _provider = ApiProvider();

  Future<Tour> addTourToCart(
      String token, String tourId, String type, int quantity) async {
    Map<String, String> headers = {
      'authorization': token,
      'Content-Type': 'application/json'
    };
    print(headers);
    final response = await _provider.getWithHeader(
        "api/booking/add-item-to-cart/$tourId/$type/$quantity",
        headersData: headers);

    return Tour.fromJson(response);
  }

  Future<Booking> getCart(String token) async {
    Map<String, String> headers = {
      'authorization': token,
      'Content-Type': 'application/json'
    };
    final response = await _provider.getWithHeader("api/booking/get-cart",
        headersData: headers);
    return Booking.fromJson(response['data']);
  }
}
