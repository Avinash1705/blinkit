


import 'dart:convert';

import 'package:swiggy/domain/ApiConstants.dart';
import 'package:http/http.dart' as http;

import '../venderModels/OrderPlacedModel.dart';

class VenderOrdersController {

  Future<OrderPlacedModel?> fetchOrders(String tableName) async {
    print("table name in fetch orders $tableName");
    String url = "${ApiConstants.getOrderedPlaced}?tableName=$tableName";

    try {
      final result = await http.get(Uri.parse(url));
      print("Response from server: ${result.body}");

      if (result.statusCode == 200) {
        return OrderPlacedModel.fromJson(jsonDecode(result.body));
      } else {
        print("❌ Server error: ${result.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Error fetching orders: $e");
      return null;
    }
  }
}
