import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/screens/main_screen.dart';
import 'package:flutter_travel_ui/models/destination_model.dart';
import 'UI/screens/destination_screen.dart';
import 'UI/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Destination destination = new Destination(activities: [],imageUrl:"https://scontent-xsp1-2.xx.fbcdn.net/v/t1.0-1/p160x160/85153336_1482219295267143_209555478756196352_o.jpg",city: "HCM",country: "VN");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        // no con rat la nhieu field can setting neu em muon skin no dep nhat co the
        scaffoldBackgroundColor: Color(0xFFF3F5F7),

      ),
       darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.orange),
      home: MainScreen(),
      // DestinationScreen(destination: destination,),
    );
  }
}
