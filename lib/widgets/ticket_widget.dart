import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/models/order_item.dart';
import 'package:fw_ticket/fw_ticket.dart';

class TicketItem extends StatefulWidget {
  final OrderItem item;

  const TicketItem({Key key, this.item}) : super(key: key);
  @override
  _TicketItemState createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  int quantity = 2;
  bool isHide = true;
  @override
  Widget build(BuildContext context) {
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
                  Image.asset(
                    item.tour.imagesUrl,
                    width: _width,
                    height: _height / 5,
                    fit: BoxFit.fill,
                  ),
                  Center(
                    child: Text(
                      '${item.tour.title}\n${item.quantity} Vé\nGiá: ${item.tour.price} VNĐ',
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
                      Image.asset(
                        item.tour.imagesUrl,
                        width: _width,
                        height: _height / 5,
                        fit: BoxFit.fill,
                      ),
                      Center(
                        child: Text(
                          item.tour.title,
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
                            GestureDetector(
                              child: Icon(
                                Icons.remove,
                                color: Colors.lightBlue,
                              ),
                            ),
                            Text(
                              '${item.quantity} TICKET',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.lightBlue,
                                ),
                                onPressed: () {
                                  _increasement();
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
                                Text('Time'),
                                FittedBox(
                                  child: Text(
                                    '9:00PM',
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
                                    '${item.tour.price} VND  ',
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

  void _increasement() {
    setState(() {
      item.quantity++;
    });
  }
}
