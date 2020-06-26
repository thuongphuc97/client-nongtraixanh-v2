import 'package:flutter/material.dart';


class PayWithMomo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset('assets/momo.png',height: 60,),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thanh toán bằng Ví MoMo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                    'Quý khách vui lòng cài đặt Ví MoMo \ntrước khi thanh toán.')
              ],
            )
          ],
        ),
      ),
    );
  }
}
