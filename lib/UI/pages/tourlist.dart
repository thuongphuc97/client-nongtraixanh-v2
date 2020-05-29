import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/pages/testpage.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:flutter_travel_ui/blocs/tour_bloc.dart';
import 'package:flutter_travel_ui/networking/response.dart';

import 'testpage.dart';

class GetTourList extends StatefulWidget {
  @override
  _GetChuckyState createState() => _GetChuckyState();
}

class _GetChuckyState extends State<GetTourList> {
  TourBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TourBloc();
    _bloc.fetchTourList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Chucky Categories',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF333333),
      ),
      backgroundColor: Color(0xFF333333),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchTourList(),
        child: StreamBuilder<Response<List<Tour>>>(
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
                  return TourList(tourList: snapshot.data.data);
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
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class TourList extends StatelessWidget {
  final List<Tour> tourList;

  const TourList({Key key, this.tourList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF202020),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 1.0,
              ),
              child: SizedBox(
                height: 65,
                child: InkWell(
                  onTap: () {
                    print("ID:${tourList[index].id}");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GetChuckCategories(
                              tourId: tourList[index].id
                            )));
                            
                  },
                  child: Container(
                    color: Color(0xFF333333),
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child:  Text(tourList[index].title)),
                  ),
                ),
              ));
        },
        itemCount: tourList.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
