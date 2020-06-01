import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/blocs/tour_bloc.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:flutter_travel_ui/networking/response.dart';
import 'package:flutter_travel_ui/widgets/response_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TourDetailScreen extends StatefulWidget {
  final String tourId;

  TourDetailScreen({this.tourId});

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  TourBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = TourBloc();
    _bloc.fetchTourById(widget.tourId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchTourById(widget.tourId),
        child: StreamBuilder<Response<Tour>>(
          stream: _bloc.tourDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                return   _tourDetail(context, snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchTourById(widget.tourId),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}

_tourDetail(context,Tour tour) {
  return Column(
    children: <Widget>[
      Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image(
                image: NetworkImage(tour.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 30.0,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.sortAmountDown),
                      iconSize: 25.0,
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 20.0,
            bottom: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tour.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.moneyBill,
                      size: 15.0,
                      color: Colors.white70,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      ' ${tour.adultPrice} VND',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 20.0,
            bottom: 20.0,
            child: Icon(
              Icons.location_on,
              color: Colors.white70,
              size: 25.0,
            ),
          ),
        ],
      ),
      Text('Gioi thieu')
   
    ],
  );
}
