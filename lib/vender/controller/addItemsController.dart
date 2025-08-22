import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:swiggy/domain/ApiConstants.dart';

class AddItemsController {
  // final String baseUrl;

  // AddItemsController(this.baseUrl);

  static Future addItem( String categoryId, String itemName,
      String phone, String itemDescription, int price, int newPrice,
      String weight, int quantity, File imgUrl) async {
    print("Adding item with details: ${imgUrl.toString().split('/').last}");
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse('${ApiConstants.addItems}'
              '?category_id=$categoryId&item_name=$itemName&phone=$phone&item_description=$itemDescription&price=$price'
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
      print("Error adding item: $e");
      return e.toString();
    }
  }
}
