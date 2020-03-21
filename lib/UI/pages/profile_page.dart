import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                child: Icon(Icons.ac_unit),
                radius: 55,
              ),
            ),
            Text('Dinh Hoang Nhung'),
            
          ],
        ),
      ),
    );
  }
}
