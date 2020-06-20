import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/pages/search_page.dart';
import 'package:flutter_travel_ui/blocs/tour_bloc.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:flutter_travel_ui/networking/response.dart';
import 'package:flutter_travel_ui/widgets/response_widget.dart';
import 'package:flutter_travel_ui/widgets/search_field.dart';
import 'package:flutter_travel_ui/widgets/list_tour.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TourBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = TourBloc();
    _bloc.fetchTourList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => _bloc.fetchTourList(),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            _findWidget(),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: _carousel()),
            SizedBox(height: 20.0),
            StreamBuilder<Response<List<Tour>>>(
              stream: _bloc.tourListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      print('loading');
                      return Loading(loadingMessage: snapshot.data.message);
                      break;
                    case Status.COMPLETED:
                      print('completed');
                      return ListTour(
                        tours: snapshot.data.data,
                        title: "TOP Tours",
                      );
                      break;
                    case Status.ERROR:
                      return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () => _bloc.fetchTourList(),
                      );
                      break;
                  }
                }
                return Container();
              },
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  _findWidget() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 0),
          child: Text(
            'What would you like \nto find?',
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

  _carousel() {
    return Container(
      height: 200,
      child: Carousel(
        // carousel hiệu ứng hình động
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
