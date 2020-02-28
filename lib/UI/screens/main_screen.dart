import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SharedPreferences sharedPreferences;

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') == null)
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (Route<dynamic> route) => false);
  }
  @override
  void initState(){
    super.initState();
    checkLoginStatus();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:90),
                child: Text('Have been login'),
              ),
              FlatButton(
                onPressed: () {
                  sharedPreferences.clear();
                  sharedPreferences.commit();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                },
                color: Colors.red,
                child: Text('Log out'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
