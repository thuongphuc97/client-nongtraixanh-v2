import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:flutter_travel_ui/widgets/home_tour_item.dart';


class ListTour extends StatelessWidget { //tai sao cjp nauy la less
  final String title;
  final List<Tour> tours;
  const ListTour({Key key, this.title,this.tours}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              Tour tour = tours[index]; 
              return GestureDetector(
                // onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => DestinationScreen(
                //       destination: tour,
                //     ),
                //   ),
                // ),
                child: HomeTourItem(tour:tour), 
                     );
            },
          ),
        ),
      ],
    );
  }
}
