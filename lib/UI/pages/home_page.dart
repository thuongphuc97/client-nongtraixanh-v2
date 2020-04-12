import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/pages/search_page.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:flutter_travel_ui/widgets/hotel_carousel.dart';
import 'package:flutter_travel_ui/widgets/search_field.dart';
import 'package:flutter_travel_ui/widgets/list_tour.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        children: <Widget>[
         _findWidget(),
          SizedBox(height: 20.0),
          ListTour(title: 'Tour hot', tours: tours),
          SizedBox(height: 20.0),
          HotelCarousel(),
        ],
      ),
    );
  }

  _findWidget() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 120),
          child: Text(
            'What would you \nlike to find?',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: SearchField()),
        ),
      ],
    );
  }
}
