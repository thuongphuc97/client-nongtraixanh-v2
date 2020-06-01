import 'dart:async';

import '../networking/response.dart';
import '../models/tour_model.dart';
import '../repository/tour_repository.dart';

class TourBloc {
  TourRepository _tourRepository;
  StreamController _tourDataController;
  StreamController _tourListController;

/* ------------------------------- Single Tour ------------------------------ */
  StreamSink<Response<Tour>> get tourDataSink => _tourDataController.sink;
  Stream<Response<Tour>> get tourDataStream => _tourDataController.stream;
/* -------------------------------- List Tour ------------------------------- */
  StreamSink<Response<List<Tour>>> get tourListSink => _tourListController.sink;
  Stream<Response<List<Tour>>> get tourListStream => _tourListController.stream;
/* ------------------------------- Constructor ------------------------------ */
  TourBloc() {
    _tourDataController = StreamController<Response<Tour>>();
    _tourListController = StreamController<Response<List<Tour>>>();
    _tourRepository = TourRepository();
  }
/* ---------------------------- Fetch Tour by Id ---------------------------- */
  fetchTourById(String id) async {
    tourDataSink.add(Response.loading('Loading tour data!'));
    try {
      Tour tour = await _tourRepository.fetchTourById(id);
      tourDataSink.add(Response.completed(tour));
    } catch (e) {
      tourDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

/* ----------------------------- SEARCH BY TITLE ---------------------------- */
  fetchTourBySearch(String title) async {
    tourListSink.add(Response.loading('Searching'));
    try {
      List<Tour> tourList = await _tourRepository.fetchTourSearchData(title);
      tourListSink.add(Response.completed(tourList));
    } catch (e) {
      tourListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

/* ----------------------------- Fetch List Tour ---------------------------- */
  fetchTourList() async {
    tourListSink.add(Response.loading('Loading tour list!'));
    try {
      List<Tour> tourList = await _tourRepository.fetchTourListData();
      tourListSink.add(Response.completed(tourList));
    } catch (e) {
      tourListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

/* ---------------------------- Authenticate User --------------------------- */

/* -------------------------------------------------------------------------- */

  dispose() {
    _tourDataController?.close();
    _tourListController?.close();
  }
}
