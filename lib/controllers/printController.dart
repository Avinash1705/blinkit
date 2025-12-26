import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/domain/AppConstant.dart';
import 'package:swiggy/model/cartModel.dart';
import '../domain/ApiConstants.dart';

class Printcontroller extends ChangeNotifier {
  /// Temporary cart items before clearing
  List<CartItem> listItem = [];

  /// Stores orders grouped by date for UI
  Map<String, List<Map<String, dynamic>>> ordersByDay = {};

  bool isLoading = false;

  AddressController addressController = AddressController();

  // ------------------------------------------------------------
  // ADD TRANSITION (called from OrderPlacedScreen)
  // ------------------------------------------------------------
  Future<void> addTransition(Map<String, CartItem> items) async {
    print("🔥 addTransition started");

    listItem.clear();
    for (CartItem item in items.values) {
      listItem.add(item);
    }

    // ✅ LOAD ADDRESS HERE (CRITICAL FIX)
    final prefs = await SharedPreferences.getInstance();
    final address =
        prefs.getString('location') ?? "No Address Found";

    debugPrint("📍 Address used for order: $address");

    // print("🧾 Items to be saved as order: ${jsonEncode(listItem)}");
    // print("placing order printController addTransiion  ${addressController.updatedAddress.value}");
    await placeOrder(
      customerPhone: AppConstant.phone,
      customerName: AppConstant.customer_name,
      customerLocation: address,
      cartItems: listItem,
    );

    notifyListeners();
  }

  // ------------------------------------------------------------
  // UPDATE LOCAL EXISTING QUANTITY
  // ------------------------------------------------------------
  Future<void> updateExistingQuantity() async {
    for (CartItem item in listItem) {
      item.existingQuantity =
          (item.existingQuantity ?? 0) - item.quantity;
    }
  }

  // ------------------------------------------------------------
  // PLACE ORDER API
  // ------------------------------------------------------------
  //api to customerOrderPlaced -
  Future<String> placeOrder({
    required String customerPhone,
    required String customerName,
    required String customerLocation,
    required List<CartItem> cartItems,
  }) async {
    final url = Uri.parse(ApiConstants.customersPlacedOrder);

    final body = {
      "customer_phone": customerPhone,
      "customer_name": customerName,
      "customer_location": customerLocation,
      "cartItems": cartItems.map((e) => e.toJson()).toList(),
    };
    print("placing order printController $body");
    print("📦 Sending order data: ${jsonEncode(body)}");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("🔵 Order API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          print("✅ Order placed successfully. Order ID: ${data['order_id']}");
          return response.body;
        }
      }
    } catch (e) {
      print("❌ Order placement failed: $e");
    }

    return "Order placement failed";
  }

  // ------------------------------------------------------------
  // FETCH ORDERS FOR PRINTSCREEN (Grouped by Dates)
  // ------------------------------------------------------------
  Future<void> fetchOrders(String customerName, String phone) async {
    print("📥 Fetching orders for $phone");

    try {
      isLoading = true;
      notifyListeners();

      final url = Uri.parse(ApiConstants.getAllCustomerOrders);
      final response = await http.post(url, body: {
        "phone": phone,
        "customer_name": customerName,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("📥 API raw orders: ${jsonEncode(data)}");

        if (data["success"] == true) {
          Map<String, dynamic> rawOrders = data["orders"];
          Map<String, List<Map<String, dynamic>>> filtered = {};

          rawOrders.forEach((date, list) {
            List<Map<String, dynamic>> orderList =
            List<Map<String, dynamic>>.from(list);

            List<Map<String, dynamic>> matchedOrders = orderList
                .where((order) =>
            order["customer_phone"].toString().trim() ==
                phone.trim())
                .toList();

            if (matchedOrders.isNotEmpty) {
              filtered[date] = matchedOrders;
            }
          });

          ordersByDay = filtered;
          print("📅 Filtered orders: $filtered");
        } else {
          ordersByDay = {};
          print("❌ No orders found on server");
        }
      } else {
        ordersByDay = {};
        print("❌ Server error: ${response.statusCode}");
      }
    } catch (e) {
      ordersByDay = {};
      print("❌ Error fetching orders: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
