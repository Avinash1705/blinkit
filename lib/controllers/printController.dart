import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/addressController.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/model/cartModel.dart';

import '../domain/AppConstants.dart';
import '../model/customerOrderResponseModel.dart';

class Printcontroller extends ChangeNotifier {
  List<CartItem> listItem = [];
  List<List<CartItem>> totalListItem = [];
  AddressController addressController = AddressController();
  late CustomerOrderResponseModel customerOrderResponse;
  void addTransition(Map<String, CartItem> items) {
    for (CartItem tt in items.values) {
      listItem.add(tt);
    }
    print("tansition added ${jsonEncode(listItem)}");

    totalListItem.add(List<CartItem>.from(listItem));
    print("tansition added total ${jsonEncode(totalListItem)}");
    // print("tansition addreess ${addressController.updatedAddress.value}");
    // print("tansition addreess1 ${addressController.getUpdatedAddress()}");
    placeOrder(
      customerPhone: "1234567890", // Replace with actual phone number
      customerName: "John Doe", // Replace with actual customer name
      customerLocation: addressController.updatedAddress.value, // Use the updated address
      cartItems: listItem, // Pass the current list of cart items
    ).then((response) {
      // Handle the response from the placeOrder method
      print("kkkkkOrder response: $response");
    }).catchError((error) {
      // Handle any errors that occur during the order placement
      print("kkkkkError placing order: $error");
    });
    // Clear the list after placing the order
    listItem.clear();
   notifyListeners();
  }



  Future<List<CartItem>> getCartItems() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // List<String>? jsonList = prefs.getStringList('cart_items');
    /*clear old data */
    // prefs.clear();
    // if (jsonList == null) return [];
    //
    // return jsonList.map((item) => CartItem.fromJson(jsonDecode(item))).toList();
    return listItem; // Return the list of CartItem objects
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
  Future<String> placeOrder({
    required String customerPhone,
    required String customerName,
    required String customerLocation,
    required List<CartItem> cartItems,
  }) async {
    final url = Uri.parse(AppConstants.customersPlacedOrder);

    final body = {
      "customer_phone": customerPhone,
      "customer_name": customerName,
      "customer_location": customerLocation,
      "cartItems": cartItems.map((e) => e.toJson()).toList(),
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      print("Response pritn: ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["success"] == true) {
          print("✅ Order placed successfully. Order ID: ${data['order_id']}");
            return response.body;
        } else {
          print("❌ Failed: ${data['message']}");
        }
      } else {
        print("❌ Server error: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error placing order: $e");
    }
    return "Error placing order";
  }
}
