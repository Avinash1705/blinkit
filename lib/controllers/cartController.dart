import 'package:flutter/cupertino.dart';

import '../model/cartModel.dart';

class CartController with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get itemCount => _items.length;
  double _totalCost = 0;

  double get totalCost =>_totalCost;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      print("item added${_items.keys}");
      total += item.price * item.quantity;
    });
    return total;
  }

  //added from homescreen so need all fields
  void addItem(String productId, String title, String img, double price) {
    print("cart scree model prodId${productId}");
    if (_items.containsKey(productId)) {
      print("cart scree model prodId same ${productId}");
      _items.update(
        productId,
        (existing) => CartItem(
          productId: productId,
          title: existing.title,
          img: existing.img,
          quantity: existing.quantity + 1,
          price: existing.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          productId: DateTime.now().toString(),
          title: title,
          img: img,
          quantity: 1,
          price: price,
        ),
      );
    }
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
