import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeTourItem extends StatelessWidget {
  final Tour tour;
  const HomeTourItem({Key key, this.tour}) : super(key: key);
  //Truyen tham so tour từ danh sách tour tại đây

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Colors.white;
    if (MediaQuery.of(context).platformBrightness == Brightness.dark)
      backgroundColor = Colors.black;
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 210.0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            bottom: 15.0,
            child: Container(
              height: 120.0,
              width: 200.0,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${tour.activities.length} activities', // lấy các giá trị từ đối tượng để show leen
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      tour.desc,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: tour.imagesUrl, // nó cần tag khác nhau k trùng nhau, nếu cso cái trùng thì navigatỏ bị lỗi liền
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      height: 180.0,
                      width: 180.0,
                      image: AssetImage(tour.imagesUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tour.city,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.locationArrow,
                            size: 10.0,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            tour.country,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
