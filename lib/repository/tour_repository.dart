import '../networking/api_provider.dart';
import '../models/tour_model.dart';
import 'dart:async';

class TourRepository {
  ApiProvider _provider = ApiProvider();

  Future<Tour> fetchTourById(String id) async {
    final response = await _provider.get("api/tours/" + id);
    return Tour.fromJson(response);
  }
}