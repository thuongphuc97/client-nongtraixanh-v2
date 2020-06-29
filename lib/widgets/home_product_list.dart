import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/screens/category_product_screen.dart';
import 'package:flutter_travel_ui/UI/screens/product_detail_screen.dart';
import 'package:flutter_travel_ui/UI/screens/tour_detail_screen.dart';
import 'package:flutter_travel_ui/models/product_model.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:flutter_travel_ui/widgets/home_tour_item.dart';
import 'package:flutter_travel_ui/widgets/product_item.dart';

class ProductList extends StatelessWidget {
  // less
  final List<Product> products;
  const ProductList({Key key, this.products}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Product> listSale = [];
    products.forEach((element) {
      if (element.pricesale > 0) listSale.add(element);
    });
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Sản phẩm giảm giá",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllCategoriesProductScreen()),
                ),
                child: Text(
                  'Xem tất cả',
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
            itemCount: listSale.length,
            itemBuilder: (BuildContext context, int index) {
              // Tour tour = products[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      product: listSale[index],
                    ),
                  ),
                ),
                child: ProductItem(product: listSale[index]),
              );
            },
          ),
        ),

/* -------------------------------------------------------------------------- */

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Sản phẩm",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllCategoriesProductScreen()),
                ),
                child: Text(
                  'Xem tất cả',
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
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              // Tour tour = products[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      product: products[index],
                    ),
                  ),
                ),
                child: ProductItem(product: products[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
