import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/pages/search_page.dart';
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
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10 , 10),
            child: _carousel()
          ),
          SizedBox(height: 20.0),
    //      ListTour(title: 'Tour hot', tours: tours),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  _findWidget() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 120),
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
  _carousel(){
    return Container(
              height: 200,
              child: Carousel( // cai carousel nay chi can quan tam them hinh vo cho no thoi
                autoplayDuration: Duration(seconds: 10),
                dotSize: 5,
                dotPosition: DotPosition.bottomLeft,
                borderRadius: true,
                images: [
                  NetworkImage(
                      'https://www.tsttourist.com/vnt_upload/tour/01_2020/e7.jpg'),
                  NetworkImage(
                      'https://media.vietravel.net/Images/news/kich-cau-du-lich-thai-lan(0).jpg'),
                ],
              ),
            );
  }
}
