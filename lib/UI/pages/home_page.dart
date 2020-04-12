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
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                ),
                child: _findText(),
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

            SizedBox(height: 20.0),

            ListTour(title: 'Tour hot',tours: tours),  // ben day thi chi can, truyen cho no title va danh sach tours lay dc tu api( hien tai truyen cuc bo)
            ListTour(title: 'Near You',tours: toursNearYou),  // ben day thi chi can, truyen cho no title va danh sach tours lay dc tu api( hien tai truyen cuc bo)
// Neu de nhu luc truoc thi can 2 file, o day chi can 2 dong goi no ra va thay ten vo , sau nay nhung cai doi tuong danh sach tour nay, duoc goi tu api xuong 
            SizedBox(height: 20.0),
            HotelCarousel(),
          ],
        ),
      );

  }
  _findText() {
    return Text(
      'What would you \nlike to find?',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
}}