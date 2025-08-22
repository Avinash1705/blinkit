import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:swiggy/domain/ApiConstants.dart';

// class OrderController extends GetxController {
  // var ordersByDay = <String, List<Map<String, dynamic>>>{}.obs;
  // var isLoading = false.obs;

  // Future<void> fetchOrders(String filterName,String filterPhone) async {
  //   isLoading.value = true;
  //   try {
  //     var url = Uri.parse(ApiConstants.getAllCustomerOrders); // change to your server URL
  //     var response = await http.get(url);
  //
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //
  //       if (data["success"] == true) {
  //         // store grouped orders
  //         ordersByDay.value =  Map<String, List<dynamic>>.from(data["orders"])
  //             .map((key, value) {
  //           // Filter orders for this date
  //           final filteredList = List<Map<String, dynamic>>.from(value).where((order) {
  //             return order["customer_name"] == filterName &&
  //                 order["customer_phone"] == filterPhone;
  //           }).toList();
  //
  //           return MapEntry(key, filteredList);
  //         })
  //         // Remove empty dates
  //           ..removeWhere((key, value) => value.isEmpty);
  //       } else {
  //         Get.snackbar("Error", data["message"] ?? "No orders found");
  //       }
  //     } else {
  //       Get.snackbar("Error", "Server error: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to load orders: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
// }
