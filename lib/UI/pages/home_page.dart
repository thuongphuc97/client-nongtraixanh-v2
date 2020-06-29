import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/pages/search_page.dart';
import 'package:flutter_travel_ui/blocs/banner_bloc.dart';
import 'package:flutter_travel_ui/blocs/product_bloc.dart';
import 'package:flutter_travel_ui/models/banner_model.dart';
import 'package:flutter_travel_ui/models/product_model.dart';
import 'package:flutter_travel_ui/networking/response.dart';
import 'package:flutter_travel_ui/widgets/home_product_list.dart';
import 'package:flutter_travel_ui/widgets/response_widget.dart';
import 'package:flutter_travel_ui/widgets/search_field.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerBloc _bannerBloc;
  ProductBloc _bloc;
  String url = "http://192.168.43.188/client/public/images/";
  @override
  void initState() {
    super.initState();
    _bloc = ProductBloc();
    _bloc.fetchProductList();

    _bannerBloc = BannerBloc();
    _bannerBloc.fetchProductList();
  }

  List listImg = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => _bloc.fetchProductList(),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            _findWidget(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: StreamBuilder<Response<List<Slide>>>(
                stream: _bannerBloc.bannerListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        print('loading');
                        return Loading(loadingMessage: snapshot.data.message);
                        break;
                      case Status.COMPLETED:
                        snapshot.data.data.forEach((element) {
                          listImg.add(NetworkImage(url + element.img));
                        });
                        return _carousel(listImg);

                        break;
                      case Status.ERROR:
                        return Error(
                          errorMessage: snapshot.data.message,
                          onRetryPressed: () =>_bannerBloc.fetchProductList(),
                        );
                        break;
                    }
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(height: 20.0),
            StreamBuilder<Response<List<Product>>>(
              stream: _bloc.productListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      print('loading');
                      return Loading(loadingMessage: snapshot.data.message);
                      break;
                    case Status.COMPLETED:
                      print('completed');
                      return ProductList(products: snapshot.data.data);

                      break;
                    case Status.ERROR:
                      return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () => _bloc.fetchProductList(),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Hôm nay, \nbạn muốn ăn gì?',
            style: TextStyle(
              fontSize: 40,
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

  _carousel(listImg) {
    return Container(
      height: 200,
      child: Carousel(
        // carousel hiệu ứng hình động
        autoplayDuration: Duration(seconds: 10),
        dotSize: 5,
        dotPosition: DotPosition.bottomLeft,
        borderRadius: true,
        images: listImg
      ),
    );
  }
}
