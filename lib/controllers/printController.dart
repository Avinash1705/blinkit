import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/AppConstant.dart';
import 'package:swiggy/model/cartModel.dart';
import '../domain/ApiConstants.dart';

class Printcontroller extends ChangeNotifier {

  List<CartItem> listItem = [];

  /// ✅ NEW STRUCTURE
  /// date → orderId → items
  Map<String, Map<String, List<Map<String, dynamic>>>> ordersByDay = {};

  bool isLoading = false;

  // ------------------------------------------------------------
  // ADD TRANSITION
  // ------------------------------------------------------------

  Future<void> addTransition(Map<String, CartItem> items,
      {required String address}) async {

    listItem = items.values.toList();

    await placeOrder(
      customerPhone: AppConstant.phone,
      customerName: AppConstant.customer_name,
      customerLocation: address,
      cartItems: listItem,
    );

    notifyListeners();
  }

  // ------------------------------------------------------------
  // PLACE ORDER
  // ------------------------------------------------------------

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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          print("✅ Order placed: ${data['order_id']}");
          return data['order_id'].toString();
        }
      }
    } catch (e) {
      print("❌ placeOrder error $e");
    }

    return "";
  }
  Future<void> updateExistingQuantity() async { for (CartItem item in listItem) { item.existingQuantity = (item.existingQuantity ?? 0) - item.quantity; } }
  // ------------------------------------------------------------
  // FETCH + GROUP ORDERS
  // ------------------------------------------------------------

  Future<void> fetchOrders(
      String customerName,
      String phone,
      ) async {

    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(ApiConstants.getAllCustomerOrders);

      final response = await http.post(url, body: {
        "phone": phone,
        "customer_name": customerName,
      });

      if (response.statusCode != 200) {
        ordersByDay = {};
        return;
      }

      final data = jsonDecode(response.body);

      if (data["success"] != true) {
        ordersByDay = {};
        return;
      }

      Map<String, dynamic> raw = data["orders"];

      /// ✅ GROUP BY DATE → ORDER_ID → ITEMS
      Map<String, Map<String, List<Map<String, dynamic>>>> grouped = {};

      raw.forEach((date, list) {

        final orderList =
        List<Map<String, dynamic>>.from(list);

        for (var o in orderList) {

          final orderId =
              o["order_id"]?.toString() ?? "UNKNOWN";

          grouped.putIfAbsent(date, () => {});
          grouped[date]!.putIfAbsent(orderId, () => []);
          grouped[date]![orderId]!.add(o);
        }
      });

      ordersByDay = grouped;

      print("📅 GROUPED ORDERS = $ordersByDay");

    } catch (e) {
      print("❌ fetchOrders error $e");
      ordersByDay = {};
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
