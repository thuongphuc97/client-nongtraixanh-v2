import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_travel_ui/blocs/tour_bloc.dart';
import 'package:flutter_travel_ui/models/booking_model.dart';
import 'package:flutter_travel_ui/models/order_item.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:flutter_travel_ui/networking/response.dart';
import 'package:flutter_travel_ui/repository/booking_repository.dart';
import 'package:flutter_travel_ui/repository/tour_repository.dart';
import 'package:flutter_travel_ui/widgets/response_widget.dart';
import 'package:fw_ticket/fw_ticket.dart';
import 'package:intl/intl.dart';

class TicketItem extends StatefulWidget {
  final BookingItems item;

  const TicketItem({Key key, this.item}) : super(key: key);
  @override
  _TicketItemState createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  bool isHide = true;
  final formatter = new NumberFormat("#,###");
  BookingRepository _bookingRepository = new BookingRepository();
  Tour tour;
  TourBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = TourBloc();
    _bloc.fetchTourById(widget.item.tourId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Response<Tour>>(
      stream: _bloc.tourDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Loading(loadingMessage: snapshot.data.message);
              break;
            case Status.COMPLETED:
              return _itemBuilder(context, snapshot.data.data);
              break;
            case Status.ERROR:
              return Error(
                errorMessage: snapshot.data.message,
                onRetryPressed: () => _bloc.fetchTourById(widget.item.tourId),
              );
              break;
          }
        }
        return Container();
      },
    );
  }

  _itemBuilder(context, Tour tour) {
    bool _isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 375,
        child: AnimatedCrossFade(
          duration: kThemeAnimationDuration,
          crossFadeState:
              isHide ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () => _showDetail(),
            child: Ticket(
              outerRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Image.network(
                    tour.imageUrl,
                    width: _width,
                    height: _height / 5,
                    fit: BoxFit.fill,
                  ),
                  Center(
                    child: Text(
                      '${tour.title.substring(0, 21) + "..."}\n${widget.item.type == "adult" ? "Người lớn" : "Trẻ nhỏ"} -${widget.item.quantity} Vé\n${widget.item.type == "adult" ? formatter.format(tour.adultPrice) : formatter.format(tour.childPrice)} VND',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 6,
                            color: Colors.black,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          secondChild: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () => _showDetail(),
                child: Ticket(
                  innerRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                  outerRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Image.network(
                        tour.imageUrl, // item.tour.imagesUrl,
                        width: _width,
                        height: _height / 5,
                        fit: BoxFit.fill,
                      ),
                      Center(
                        child: Text(
                          tour.title.substring(0, 21) + ".....",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 6,
                                color: Colors.black,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Ticket(
                innerRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                outerRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    // offset: Offset(0, 4),
                    // blurRadius: 2.0,
                    // spreadRadius: 2.0,
                    color: _isDark ? Colors.black : Colors.grey[350],
                  )
                ],
                child: Container(
                  //         color: Colors.white,
                  width: _width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                             IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  color: Colors.lightBlue,
                                ),
                                onPressed: () {
                                  _changeValue(widget.item,--widget.item.quantity);
                                }),
                            Text(
                              // '${item.quantity} TICKET',
                              '${widget.item.quantity} Vé',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.lightBlue,
                                ),
                                onPressed: () {
                                  _changeValue(widget.item,++widget.item.quantity);
                                })
                          ],
                        ),
                      ),
                      Divider(height: 0.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Date'),
                                  FittedBox(
                                    child: Text(
                                      '08/17   ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Loại vé'),
                                FittedBox(
                                  child: Text(
                                    '${widget.item.type == "adult" ? "Người lớn" : "Trẻ nhỏ"}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0),
                                  ),
                                )
                              ],
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Price'),
                                FittedBox(
                                  child: Text(
                                    '${widget.item.type == "adult" ? formatter.format(tour.adultPrice) : formatter.format(tour.childPrice)} VND',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0),
                                  ),
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDetail() {
    setState(() {
      isHide = !isHide;
    });
  }

  getToken() async {
    final _storage = FlutterSecureStorage();
    return await _storage.read(key: "token");
  }

  void _changeValue(item,quantity) async {
    String token = await getToken();
    await _bookingRepository.editCart(token, item.tourId, item.type, quantity);
  setState(() {
    
  });
  }
}
