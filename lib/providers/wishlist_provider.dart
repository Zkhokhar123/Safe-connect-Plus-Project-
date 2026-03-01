import 'package:flutter/material.dart';
import '../models/product_model.dart';

class WishlistProvider with ChangeNotifier {
  final List<Product> _wishlistItems = [];

  List<Product> get items => _wishlistItems;

  void toggleWishlist(Product product) {
    final index = _wishlistItems.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      _wishlistItems.removeAt(index);
    } else {
      _wishlistItems.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(String productId) {
    return _wishlistItems.any((item) => item.id == productId);
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
