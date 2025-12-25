


import 'dart:convert';

import 'package:swiggy/domain/ApiConstants.dart';
import 'package:http/http.dart' as http;

import '../venderModels/OrderPlacedModel.dart';

class VenderOrdersController {



  // Add your methods and properties here
  // For example, you might have methods to fetch orders, update order status, etc.

   // late OrderPlacedModel orderPlacedModel ;
  Future<OrderPlacedModel> fetchOrders(String tableName) async{
    // Logic to fetch orders from the database or API
    print("table name in fetch orders $tableName");
    String url = "${ApiConstants.getOrderedPlaced}?tableName=$tableName";
  try{
    var result =await http.get(Uri.parse(url));
    if(result.statusCode == 200) {
      final model = OrderPlacedModel.fromJson(jsonDecode(result.body));
      return model;
    }
    else {
      throw Exception("Server error ${result.statusCode}");
    }
  }
  catch(e) {
    print("Error fetching orders: $e");
    // Handle the error appropriately, maybe show a message to the user
    rethrow;
  }
  // return orderPlacedModel;
  }
}