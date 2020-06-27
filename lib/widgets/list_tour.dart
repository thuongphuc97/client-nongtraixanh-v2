import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/screens/tour_detail_screen.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:flutter_travel_ui/widgets/home_tour_item.dart';

class ListTour extends StatelessWidget {
  // less
  final String title;
  final List<Tour> tours;
  const ListTour({Key key, this.title, this.tours}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Tour> dalat = [];
    tours.forEach((element) {
      if (element.title.toLowerCase().contains('đà lạt')) dalat.add(element);
    });
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => print('See All'),
                child: Text(
                  'See All',
                  style: TextStyle(
                    // color: Theme.of(context).primaryColor,
                    color: Colors.amber,
                    fontSize: 16.0,
                    // fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tours.length,
            itemBuilder: (BuildContext context, int index) {
              // Tour tour = tours[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TourDetailScreen(
                      tourId: tours[index].id,
                    ),
                  ),
                ),
                child: HomeTourItem(tour: tours[index]),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Đà Lạt',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => print('See All'),
                child: Text(
                  'See All',
                  style: TextStyle(
                    // color: Theme.of(context).primaryColor,
                    color: Colors.amber,
                    fontSize: 16.0,
                    // fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dalat.length,
            itemBuilder: (BuildContext context, int index) {
              // Tour tour = tours[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TourDetailScreen(
                      tourId: dalat[index].id,
                    ),
                  ),
                ),
                child: HomeTourItem(tour: dalat[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
