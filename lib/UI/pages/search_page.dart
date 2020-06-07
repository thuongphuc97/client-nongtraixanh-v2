import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/pages/tourlist.dart';

import 'package:flutter_travel_ui/blocs/tour_bloc.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:flutter_travel_ui/networking/response.dart';
import 'package:flutter_travel_ui/widgets/response_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  bool hasSearch = false;
  TourBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = TourBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 0.0,
          child: TextFormField(
            controller: _searchController,
            autofocus: true,
            autocorrect: false,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  hasSearch = true;
                });
                _bloc.fetchTourBySearch(value);
              } else
                setState(() {
                  hasSearch = false;
                });
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                hintText: "Nhập thông tin cần tìm!",
                border: InputBorder.none),
            validator: (value) {
              if (value.isEmpty) {
                return "The search field cannot be empty";
              }
              return null;
            },
          ),
        ),
      ),
      body: StreamBuilder<Response<List<Tour>>>(
        stream: _bloc.tourListStream,
        builder: (context, snapshot) {
          if (!hasSearch) //!Neu khong co du liệu ở khung search thì chuyển đến giao diện no search
            return _noSearch();
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                print('loading');
                return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                print('complete');
                if (snapshot.data.data
                    .isNotEmpty) //!Kiểm tra có dữ liệu thì chuyển đến Líst search
                  return TourList(tourList: snapshot.data.data);
                else
                  return _noResult(); //! Không có thì báo không có thís function below
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
    );
  }

  _noResult() {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[Text('Not found!')],
          ),
        ),
      ),
    );
  }

  _noSearch() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
        'assets/images/search-image.png',
      ))),
    );
  }
}
