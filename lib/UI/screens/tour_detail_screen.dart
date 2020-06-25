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
                  return _tourDetail(context, snapshot.data.data);
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

_tourDetail(context, Tour tour) {
  String _valGender;
  List _listGender = ["Người lớn", "Trẻ em"];
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
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                hint: Text("Chọn độ tuổi"),
                value: _valGender,
                items: _listGender.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {},
              ),
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.keyboard_arrow_down), onPressed: null),
                Text('1'),
                IconButton(icon: Icon(Icons.keyboard_arrow_up), onPressed: () {})
              ],
            ),
          ],
        ),
      ),
      Text(
        'Mô Tả',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Divider(
          color: Colors.black,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '\tNha Trang với khí hậu ôn hòa, biển xanh trong quanh năm cùng những điểm vui chơi bậc nhất và không ngừng đổi mới hằng ngày luôn thu hút du khách gần xa. Đến với Nha Trang, du khách không chỉ tận hưởng những đợt gió biển trong nắng ấm mà còn có dịp thưởng thức hải sản tươi ngon cùng sự chào đón nồng hậu từ những người dân vùng biển nghĩa tình, cho Quý khách trải nghiệm khó quên tại vùng đất này.',
          style: TextStyle(fontSize: 16),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Divider(
          color: Colors.black,
        ),
      ),
      Text(
        'Lịch trình',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Divider(
          color: Colors.black,
        ),
      ),
      FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {},
        child: Icon(Icons.add_shopping_cart),
      )
    ],
  );
}
