
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  List productList = [];
  List searchList = [];
  List tempList = [];
  @override


  void searchAction(String searchText) {
    searchList.clear();
    if (searchText.isNotEmpty) {
      productList.forEach((f) {
        if (f.name.toLowerCase().contains(searchText.toLowerCase()))
          setState(() {
            searchList.add(f);
          });
      });

      return;
    } else
      setState(() {
        searchList.clear();
      });
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
                searchAction(value);
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
        body: searchList.isNotEmpty ? result() : _noSearch());
  }

  result() {
    return GridView.builder(
        itemCount: searchList.length,
        scrollDirection: Axis.vertical,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
                  child: Column(
                    children: <Widget>[
                      '${searchList[index].image}' == ''
                          ? Text('No image')
                          : Flexible(
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(8.0),
                                child: FadeInImage.assetNetwork(
                                  image: '${searchList[index].image}' +
                                      '?alt=media',
                                  // fit: BoxFit.scaleDown,
                                  // width: _width / 2.5,
                                  // height: _height / 2.05,
                                  placeholder: 'images/square-logo.png',
                                ),
                              ),
                              // flex: 5,
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${searchList[index].name}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('${searchList[index].price} đ',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w800)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 17,
                                    ),
                                    Text('9')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  _noSearch() {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/search-image.png',
                height: 400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
