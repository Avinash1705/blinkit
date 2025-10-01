import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';

Future<String?> updateProduct(Map<String, dynamic> product) async {
  var url = Uri.parse(ApiConstants.updateEditProductInVender);

  print("All data updateProducts ${jsonEncode(product)}");
   var response = await http.post(url, body: {
     "id": product["id"].toString(),
     "item_name": product["itemName"],
     "price": product["price"].toString(),
     "item_description": product["itemDescription"],
     "weight": product["weight"].toString(),
     "weightQuantity": product["weightQuantity"].toString(),
     "quantity": product["quantity"].toString(),
   });
   print("Response status: ${response.statusCode}");
  if (response.statusCode == 200) {
    print("ddingd ${response.body}");
    print("✅ Raw Body: ${response.body}");

    try {
      var jsonResponse = jsonDecode(response.body);
      print("✅ API Response: $jsonResponse");
    } catch (e) {
      print("⚠️ JSON Decode failed. Body was: ${response.body}");
    }
  } else {
    print("❌ Error: ${response.statusCode}, Body: ${response.body}");
  }
}

