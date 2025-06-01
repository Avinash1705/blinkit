import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/model/cartModel.dart';

class Printcontroller extends ChangeNotifier {
  List<CartItem> listItem = [];

  // void addTransition(Iterable<CartItem> values ,BuildContext context) {
  //   var cartController = Provider.of<CartController>(context);
  //   for(CartItem tt in cartController.items.values){
  //     listItem.add(tt);
  //   }
  //   print("check set list item3 ${listItem}");
  //   // setItem(values);
  //   box.write("itemkey", values);
  // }
void addTransition(Map<String, CartItem> items){
    for(CartItem tt in items.values){
      listItem.add(tt);
    }
    saveCartItems(listItem);
}


  Future<void> saveCartItems(List<CartItem> cartItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> jsonList = cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('cart_items', jsonList);
  }
  Future<List<CartItem>> getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? jsonList = prefs.getStringList('cart_items');
    if (jsonList == null) return [];

    return jsonList.map((item) => CartItem.fromJson(jsonDecode(item))).toList();
  }
  

  // void setItem(Iterable<CartItem> values) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setStringList("itemTransition", listItem as List<String>);
  //   print("check set list ${pref.getStringList("itemTransition")}");
  //   print("check set list2 ${listItem}");
  // }

/*  void getItem() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("get iem ${pref.getStringList("itemTransition")}");
    listItem.add(pref.getStringList("itemTransition") as String);
  }*/
}
