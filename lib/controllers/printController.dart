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

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;



class PrintController extends ChangeNotifier {
  /// ---------------------------
  /// EXISTING FIELDS (KEPT)
  /// ---------------------------

  List<CartItem> listItem = [];
  List<List<CartItem>> totalListItem = [];
  AddressController addressController = Get.find<AddressController>();
  late CustomerOrderResponseModel customerOrderResponse;

  /// ---------------------------
  /// FIXED STATE (NO .obs)
  /// ---------------------------

  Map<String, List<Map<String, dynamic>>> ordersByDay = {};
  bool isLoading = false;

  /// ---------------------------
  /// ADD TRANSACTION (UNCHANGED LOGIC)
  /// ---------------------------

  void addTransition(Map<String, CartItem> items) {
    listItem.clear();

    for (CartItem item in items.values) {
      listItem.add(item);
    }

    debugPrint("transaction added ${jsonEncode(listItem)}");

    totalListItem.add(List<CartItem>.from(listItem));
    debugPrint("transaction total ${jsonEncode(totalListItem)}");
    debugPrint("transaction address ${addressController.updatedAddress}");

    placeOrder(
      customerPhone: AppConstant.phone,
      customerName: AppConstant.customer_name,
      customerLocation: AppConstant.location,
      cartItems: listItem,
    ).then((response) {
      debugPrint("✅ Order response: $response");
    }).catchError((error) {
      debugPrint("❌ Error placing order: $error");
    });

    listItem.clear();
    notifyListeners();
  }

  /// ---------------------------
  /// UPDATE EXISTING QUANTITY (KEPT)
  /// ---------------------------

  void updateExistingQuantity() {
    for (CartItem item in listItem) {
      final existing = item.existingQuantity ?? 0;
      item.existingQuantity = existing - item.quantity;
    }
    notifyListeners();
  }

  /// ---------------------------
  /// PLACE ORDER API (KEPT)
  /// ---------------------------

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

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      debugPrint("Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["success"] == true) {
          return response.body;
        } else {
          throw Exception(data["message"]);
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Error placing order: $e");
      rethrow;
    }
  }

  /// ---------------------------
  /// FETCH ORDERS (FIXED)
  /// ---------------------------

  Future<void> fetchOrders(String filterName, String filterPhone) async {
    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(ApiConstants.getAllCustomerOrders);
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception("Server error: ${response.statusCode}");
      }

      final data = jsonDecode(response.body);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "No orders found");
      }

      ordersByDay =
      Map<String, List<dynamic>>.from(data["orders"]).map((key, value) {
        final filteredList =
        List<Map<String, dynamic>>.from(value).where((order) {
          return order["customer_name"] == filterName &&
              order["customer_phone"] == filterPhone;
        }).toList();

        return MapEntry(key, filteredList);
      })
        ..removeWhere((_, value) => value.isEmpty);
    } catch (e) {
      debugPrint("❌ Fetch orders error: $e");
      ordersByDay.clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

