import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/screens/checkout_screen.dart';
import 'package:flutter_travel_ui/models/order_item.dart';
import 'package:flutter_travel_ui/widgets/ticket_widget.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  // final OrderItem item = new  OrderItem(1, 1, tour);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //!TODO clear //

            TicketItem(),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CheckoutScreen())),
        child: Container(
          height: 40,
          width: double.infinity,
          color: Colors.lightBlue,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Text( 
              'Mua Vé',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
