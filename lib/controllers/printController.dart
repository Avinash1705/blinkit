import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/model/cartModel.dart';

class Printcontroller extends ChangeNotifier {
  List<CartItem> listItem = [];

  void addTransition(Map<String, CartItem> items) {
    for (CartItem tt in items.values) {
      // print("printCart item for loop ${tt.productId} ${tt.title} ${tt.quantity} ${tt.price}");
      listItem.add(tt);
    }
    saveCartItems(listItem);
  }


  Future<void> saveCartItems(List<CartItem> cartItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> jsonList = cartItems.map((item) => jsonEncode(item.toJson()))
        .toList();
    // print("printCart shared pRef ${jsonList}");
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

/*Existing quantity update in api and
    * make a list of items which has been ordered later using phone filter show to specific vender */
  void updateExistingQuantity() {
//   id basis existingQuantity update
//     print("updateExistingQuantity ${jsonEncode(listItem)}");
    for (CartItem item in listItem) {
      if (item.existingQuantity == null) {
        item.existingQuantity = 0; // Set default value if null
      }
      else {
        item.existingQuantity = item.existingQuantity! - item.quantity;
      }
      // Call your API to update the existing quantity here
    }
  }

  void phoneBasisVendorFilter() {
    // Implement logic to filter items based on phone number and show to specific vendor
    // This might involve fetching vendor details and filtering the listItem based on that
    // For now, this is a placeholder for the actual implementation
    print("Filtering items based on phone number and vendor");
  }
}
