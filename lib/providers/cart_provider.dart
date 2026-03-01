import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  void addToCart(Product product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        item.quantity++;
        notifyListeners();
        return;
      }
    }
    _items.add(CartItem(product: product));
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    for (var item in _items) {
      if (item.product.id == productId) {
        item.quantity++;
        notifyListeners();
        break;
      }
    }
  }

  void decrementQuantity(String productId) {
    for (var item in _items) {
      if (item.product.id == productId && item.quantity > 1) {
        item.quantity--;
        notifyListeners();
        break;
      }
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

