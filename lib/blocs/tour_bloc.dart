import 'dart:async';

import '../networking/response.dart';
import '../models/tour_model.dart';
import '../repository/tour_repository.dart';

class TourBloc {
  TourRepository _chuckRepository;
  StreamController _chuckDataController;

  StreamSink<Response<Tour>> get chuckDataSink =>
      _chuckDataController.sink;

  Stream<Response<Tour>> get chuckDataStream =>
      _chuckDataController.stream;

  TourBloc(String id) {
    _chuckDataController = StreamController<Response<Tour>>();
    _chuckRepository = TourRepository();
    fetchChuckyJoke(id);
  }

  fetchChuckyJoke(String id) async {
    chuckDataSink.add(Response.loading('Getting A Chucky Joke!'));
    try {
      Tour chuckJoke = await _chuckRepository.fetchTourById(id);
      chuckDataSink.add(Response.completed(chuckJoke));
    } catch (e) {
      chuckDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _chuckDataController?.close();
  }
}