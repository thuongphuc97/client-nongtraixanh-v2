import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/widgets/ticket_widget.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  double _width = 350;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ticket'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TicketItem(),
              TicketItem(),
            ],
          ),
        ));
  }
}
