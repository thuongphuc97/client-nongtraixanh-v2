import 'package:flutter_travel_ui/models/banner_model.dart';
import '../networking/api_provider.dart';
import 'dart:async';

class BannerRepository {
  ApiProvider _provider = ApiProvider();

  Future<List<Slide>> fetchAllBannerListData() async {
    final response = await _provider.get("/api/slide");
    return (response as List)
        .map((data) => new Slide.fromJson(data))
        .toList();
  }
}
