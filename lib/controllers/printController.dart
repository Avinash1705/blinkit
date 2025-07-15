import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/model/cartModel.dart';

class Printcontroller extends ChangeNotifier {
  List<CartItem> listItem = [];

void addTransition(Map<String, CartItem> items){
    for(CartItem tt in items.values){
      listItem.add(tt);
    }
    saveCartItems(listItem);
}


  Future<void> saveCartItems(List<CartItem> cartItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> jsonList = cartItems.map((item) => jsonEncode(item.toJson())).toList();
    print("printCart shared pRef ${jsonList}");
    await prefs.setStringList('cart_items', jsonList);
  }
  Future<List<CartItem>> getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? jsonList = prefs.getStringList('cart_items');
    /*clear old data */
    prefs.clear();
    if (jsonList == null) return [];

    return jsonList.map((item) => CartItem.fromJson(jsonDecode(item))).toList();
  }

}
