import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AllCategoriesProductScreen extends StatefulWidget {
  @override
  _AllCategoriesProductScreenState createState() =>
      _AllCategoriesProductScreenState();
}

class _AllCategoriesProductScreenState
    extends State<AllCategoriesProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sản phẩm'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _category(
                    Icon(
                      Feather.menu,
                      size: 40,
                    ),
                    null),
                _category(
                    Icon(
                      Icons.whatshot,
                      color: Colors.red,
                      size: 40,
                    ),
                    null),
                _category(
                    Icon(
                      MaterialCommunityIcons.food_apple,
                      size: 40,
                      color: Colors.green,
                    ),
                    null),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _category(category, functionTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: functionTap,
        child: Container(
          height: 40,
          width: 80,
          child: category,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(26, 255, 26, 0.3),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 6.0))
            ],
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }
}
