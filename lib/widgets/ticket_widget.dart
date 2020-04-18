import 'package:flutter/material.dart';
import 'package:fw_ticket/fw_ticket.dart';

class TicketItem extends StatefulWidget {
  @override
  _TicketItemState createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  int quantity = 2;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 375,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Ticket(
              innerRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
              outerRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4.0),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  color: Color.fromRGBO(196, 196, 196, .76),
                )
              ],
              child: Image.asset(
                'assets/images/stmarksbasilica.jpg',
                width: _width,
                height: _height / 4,
                fit: BoxFit.fill,
              ),
            ),
            Ticket(
              innerRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
              outerRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  color: Color.fromRGBO(196, 196, 196, .76),
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
                            '$quantity TICKET',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          IconButton(
                              icon: Icon(Icons.add),
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
                                  '\$15.00  ',
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
                    Container(
                      width: double.infinity,
                      color: Colors.lightBlue,
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          'BUY TICKETS',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _increasement() {
    setState(() {
      quantity++;
    });
  }
}
