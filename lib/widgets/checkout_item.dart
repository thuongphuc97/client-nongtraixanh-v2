import 'package:flutter/material.dart';

class CheckoutItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[300],
            // boxShadow: [
            //   BoxShadow(
            //       blurRadius: 10.0,
            //       spreadRadius: 0.0,
            //       offset: Offset(0, 0))
            // ],
            borderRadius: BorderRadius.circular(6.0),
           ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Nha Trang',style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 19
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Người lớn'),
                  Text('Số lượng: 1'),

                  Text('Tổng tiền: 90000 VND'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
