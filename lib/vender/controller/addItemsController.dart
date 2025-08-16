import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:swiggy/domain/AppConstants.dart';

class AddItemsController {
  // final String baseUrl;

  // AddItemsController(this.baseUrl);

  static Future addItem(String id, String categoryId, String itemName,
      String phone, String itemDescription, int price, int newPrice,
      String weight, int quantity, File imgUrl) async {
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse('${AppConstants.addItems}'
              '?id=$id&category_id=$categoryId&item_name=$itemName&phone=$phone&item_description=$itemDescription&price=$price'
              '&new_price=$newPrice&weight=$weight&quantity=$quantity'));

      request.fields['name'] = itemName;
      // Add file field
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // must match $_FILES['image'] in PHP
          imgUrl.path,
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Item Added successfully: ${response.body}");
      } else {
        print("Failed Item Added: ${response.statusCode}");
      }
      return response.body;
    } catch (e) {
      return e.toString();
    }
  }
}
