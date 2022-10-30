import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../../models/product.dart';
import '../../services/products_service.dart';

// This class use to manage products
class ProductManger with ChangeNotifier{
  List<Product> _items = [];

  final ProductsService _productsService;

  ProductManger([AuthToken? authToken])
    : _productsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _productsService.fetchProducts(filterByUser);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if(newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  // Getter is used to read or get the data of the class field.
  // Setter is used to set the data of the class field to some variable.
  List<Product> get items {
    // insert all the value of a list
    return [..._items];
  }

  List<Product> get favoriteItems {
    // where() : return a new Iterator with all elements that satisfy the predicate test
    // toList() : create a List containing the element of Iterator
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void addProduct(Product product) {
  //   _items.add(
  //     product.copyWith(
  //       id: 'p${DateTime.now().toIso8601String()}',
  //     )
  //   );
  //   notifyListeners();
  // }

  void updateProduct(Product product) {
    final index = _items.indexWhere((item) => item.id == product.id);
    if(index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void toggleFavoriteStatus(Product product) {
    final savedStatus =  product.isFavorite;
    product.isFavorite = !savedStatus;
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    _items.removeAt(index);
    notifyListeners();
  }
}



