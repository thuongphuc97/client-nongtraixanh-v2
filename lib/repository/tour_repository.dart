import '../networking/api_provider.dart';
import '../models/tour_model.dart';
import 'dart:async';
import 'dart:convert';

class TourRepository {
  ApiProvider _provider = ApiProvider();

  Future<Tour> fetchTourById(String id) async {
    final response = await _provider.get("api/tours/" + id);
    return Tour.fromJson(response);
  }

  Future<List<Tour>> fetchTourListData() async {
    final response = await _provider.get("api/tours/");
    return (response as List).map((data) => new Tour.fromJson(data)).toList();
  }
  Future<List<Tour>> fetchTourSearchData(String title) async {
    final response = await _provider.get("api/tours/search/"+ title);
    return (response as List).map((data) => new Tour.fromJson(data)).toList();
  }
}
