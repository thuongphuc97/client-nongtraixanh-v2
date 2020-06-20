import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/screens/payment_success_screen.dart';
import 'package:flutter_travel_ui/widgets/checkout_item.dart';
import 'package:flutter_travel_ui/widgets/paywithmomo.dart';
import 'package:flutter_travel_ui/widgets/paywithpaypal.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin đặt hàng'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          CheckoutItem(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text('Phương thức thanh toán',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19)),
                  ),
                  Divider(),
                  Column(
                    children: [PayWithMomo(), PayWithPayPal()],
                  )
                ],
              ),
            ),
          )
        ],
      )),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentSuccessScreen()));
        },
        child: Container(
          height: 80,
          width: double.infinity,
          color: Colors.lightBlue,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Text(
              'Thanh Toán',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
