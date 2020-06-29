import 'dart:async';

import '../networking/response.dart';
import '../models/product_model.dart';
import '../repository/product_repository.dart';

class ProductBloc {
  ProductRepository _productRepository;
  StreamController _productDataController;
  StreamController _productListController;

/* ------------------------------- Single Product ------------------------------ */
  StreamSink<Response<Product>> get productDataSink => _productDataController.sink;
  Stream<Response<Product>> get productDataStream => _productDataController.stream;
/* -------------------------------- List Product ------------------------------- */
  StreamSink<Response<List<Product>>> get productListSink => _productListController.sink;
  Stream<Response<List<Product>>> get productListStream => _productListController.stream;
/* ------------------------------- Constructor ------------------------------ */
  ProductBloc() {
    _productDataController = StreamController<Response<Product>>();
    _productListController = StreamController<Response<List<Product>>>();
    _productRepository = ProductRepository();
  }
/* ---------------------------- Fetch Product by Id ---------------------------- */
  fetchProductById(String id) async {
    productDataSink.add(Response.loading('Loading Product data!'));
    try {
      Product product = await _productRepository.fetchProductById(id);
      productDataSink.add(Response.completed(product));
    } catch (e) {
      productDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

// /* ----------------------------- SEARCH BY TITLE ---------------------------- */
//   fetchProductBySearch(String title) async {
//     productListSink.add(Response.loading('Searching'));
//     try {
//       List<Product> productList = await _productRepository.fetchProductSearchData(title);
//       productListSink.add(Response.completed(productList));
//     } catch (e) {
//       productListSink.add(Response.error(e.toString()));
//       print(e);
//     }
//   }

// /* ----------------------------- Fetch List Product ---------------------------- */
  fetchProductList() async {
    productListSink.add(Response.loading('Loading Product list!'));
    try {
      List<Product> productList = await _productRepository.fetchAllProductListData();
      productListSink.add(Response.completed(productList));
    } catch (e) {
      productListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

/* ---------------------------- Authenticate User --------------------------- */

/* -------------------------------------------------------------------------- */

  dispose() {
    _productDataController?.close();
    _productListController?.close();
  }
}
