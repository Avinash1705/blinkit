import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cartModel.dart';

class CartController with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get itemCount => _items.length;
  double _totalCost = 0;

  double get totalCost => _totalCost;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }
  void removeItemFromCart(String productId, String title, String img, double price,
      int? existingQuantity) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existing) => CartItem(
          productId: productId,
          title: existing.title,
          img: existing.img,
          quantity: existing.quantity - 1,
          price: existing.price,
          existingQuantity: existingQuantity,
        ),
      );
      if (_items[productId]!.quantity <= 0) {
        _items.remove(productId);
      }
    }
    notifyListeners();
  }
  //added from homescreen so need all fields
  void addItem(String productId, String title, String img, double price,
      int? existingQuantity) {

    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (existing) => CartItem(
          productId: productId,
          title: existing.title,
          img: existing.img,
          quantity: existing.quantity + 1,
          price: existing.price,
          existingQuantity: existingQuantity,
        ),
      );
    }
    else {
      _items.putIfAbsent(
        productId,
            () => CartItem(
            productId: productId,
            title: title,
            img: img,
            quantity: 1,
            price: price,
            existingQuantity: existingQuantity),
      );
    }
    print("cart item added ${jsonEncode(_items)}");
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void totalCartCost() {
    for (int i = 0; i < _items.length; i++) {
      _totalCost +=
          _items.values.toList()[i].quantity * _items.values.toList()[i].price;
    }
    // return _totalCost;
  }

//add remove from + and -
  void addItemInCart(int id) {}

  void clear() {
    _items = {};
    notifyListeners();
  }
}
