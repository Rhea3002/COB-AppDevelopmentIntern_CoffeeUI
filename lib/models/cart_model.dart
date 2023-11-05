import 'package:flutter/material.dart';
import '../pages/cartpage.dart';

class CartModel extends ChangeNotifier {
  List<CartItem> cartItems = [];

  void addToCart(CartItem cartItem) {
    cartItems.add(cartItem);
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    cartItems.remove(cartItem);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}