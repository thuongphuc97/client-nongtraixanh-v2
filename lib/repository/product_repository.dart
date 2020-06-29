import '../networking/api_provider.dart';
import '../models/product_model.dart';
import 'dart:async';

class ProductRepository {
  ApiProvider _provider = ApiProvider();

  Future<Product> fetchProductById(String id) async {
    final response = await _provider.get("api/product/" + id);
    return Product.fromJson(response);
  }

  Future<List<Product>> fetchAllProductListData() async {
    final response = await _provider.get("api/product?selectcategory=0");
    return (response as List)
        .map((data) => new Product.fromJson(data))
        .toList();
  }
  // Future<List<Product>> fetchProductSearchData(String title) async {
  //   final response = await _provider.get("api/tours/search/"+ title);
  //   return (response as List).map((data) => new Product.fromJson(data)).toList();
  // }
}
