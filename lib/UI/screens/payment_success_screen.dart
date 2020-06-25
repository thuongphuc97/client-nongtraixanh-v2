import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 180,
              ),
            ),
            Text(
              'Thanh toán thành công',
              style: TextStyle(fontSize: 20),
            ),
            FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                label: Text('Kiểm tra vé'))
          ],
        ),
      ),
    );
  }
}
