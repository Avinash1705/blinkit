import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/controllers/addressController.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/domain/AppConstant.dart';
import 'package:swiggy/model/cartModel.dart';

import '../domain/ApiConstants.dart';
import '../model/customerOrderResponseModel.dart';

class Printcontroller extends ChangeNotifier {
  List<CartItem> listItem = [];
  List<List<CartItem>> totalListItem = [];
  AddressController addressController = AddressController();
  late CustomerOrderResponseModel customerOrderResponse;


  /*get orders */
  var ordersByDay = <String, List<Map<String, dynamic>>>{}.obs;
  var isLoading = false.obs;
  // init() {
  //   _loadUserData();
  //   print("prf data  ${(customerId) } ${customerName} ${phone} ${location} ${customer_profile}");
  //   fetchOrders("Terror","4444444444");
  // }
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
      customerPhone: AppConstant.phone, // Replace with actual phone number
      customerName: AppConstant.customer_name, // Replace with actual customer name
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
    // Replace with actual filter values
   notifyListeners();
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

  Future<String> placeOrder({
    required String customerPhone,
    required String customerName,
    required String customerLocation,
    required List<CartItem> cartItems,
  }) async {
    final url = Uri.parse(ApiConstants.customersPlacedOrder);

    final body = {
      "customer_phone": AppConstant.phone,
      "customer_name": AppConstant.customer_name,
      "customer_location": AppConstant.location,
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

  Future<void> fetchOrders(String filterName,String filterPhone) async {
    isLoading.value = true;
    try {
      var url = Uri.parse(ApiConstants.getAllCustomerOrders); // change to your server URL
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data["success"] == true) {
          // store grouped orders
          ordersByDay.value =  Map<String, List<dynamic>>.from(data["orders"])
              .map((key, value) {
            // Filter orders for this date
            final filteredList = List<Map<String, dynamic>>.from(value).where((order) {
              return order["customer_name"] == filterName &&
                  order["customer_phone"] == filterPhone;
            }).toList();

            return MapEntry(key, filteredList);
          })
          // Remove empty dates
            ..removeWhere((key, value) => value.isEmpty);
        } else {
          Get.snackbar("Error", data["message"] ?? "No orders found");
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load orders: $e");
    } finally {
      isLoading.value = false;
    }
  }


}
