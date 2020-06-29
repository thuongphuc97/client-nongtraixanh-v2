import 'dart:async';

import 'package:flutter_travel_ui/models/banner_model.dart';
import 'package:flutter_travel_ui/repository/banner_repository.dart';

import '../networking/response.dart';
import '../models/banner_model.dart';

class BannerBloc {
  BannerRepository _bannerRepo;
  StreamController _bannerListController;
/* -------------------------------- List Product ------------------------------- */
  StreamSink<Response<List<Slide>>> get bannerListSink => _bannerListController.sink;
  Stream<Response<List<Slide>>> get bannerListStream => _bannerListController.stream;
/* ------------------------------- Constructor ------------------------------ */
  BannerBloc() {
    _bannerListController = StreamController<Response<List<Slide>>>();
    _bannerRepo = BannerRepository();
  }

// /* ----------------------------- Fetch List Product ---------------------------- */
  fetchProductList() async {
    bannerListSink.add(Response.loading('Loading banner list!'));
    try {
      List<Slide> bannerList = await _bannerRepo.fetchAllBannerListData();
      bannerListSink.add(Response.completed(bannerList));
    } catch (e) {
      bannerListSink.add(Response.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _bannerListController?.close();
  }
}
