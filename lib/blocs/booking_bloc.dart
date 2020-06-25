import 'dart:async';

import 'package:flutter_travel_ui/models/booking_model.dart';
import 'package:flutter_travel_ui/repository/booking_repository.dart';

import '../networking/response.dart';

class BookingBloc {
  BookingRepository _bookingRepository;
  StreamController _bookingDataController;
  

/* ------------------------------- Single Tour ------------------------------ */
  StreamSink<Response<Booking>> get bookingDataSink => _bookingDataController.sink;
  Stream<Response<Booking>> get bookingDataStream => _bookingDataController.stream;

  BookingBloc() {
    _bookingDataController = StreamController<Response<Booking>>();
    _bookingRepository = BookingRepository();
  }
/* ---------------------------- Fetch Tour by Id ---------------------------- */
  fetchCart(String token) async {
    bookingDataSink.add(Response.loading('Loading cart data!'));
    try {
      Booking booking = await _bookingRepository.getCart(token);
      bookingDataSink.add(Response.completed(booking));
    } catch (e) {
      bookingDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }



  dispose() {
    _bookingDataController?.close();
  }
}
