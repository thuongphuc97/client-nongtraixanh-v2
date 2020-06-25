import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travel_ui/models/order_item.dart';
import 'package:fw_ticket/fw_ticket.dart';

class PayWithPayPal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sẽ tích hợp thanh toán PayPal',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Text(
                  'Tính năng đang phát triển')
            ],
          ),
        ),
      ),
    );
  }
}
