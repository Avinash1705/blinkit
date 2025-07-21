import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:swiggy/domain/AppConstants.dart';

class AddItemsController {
  final String baseUrl;

  AddItemsController(this.baseUrl);

  static Future addItem(String id, String categoryId, String itemName,
      String phone, String itemDescription, int price,int newPrice,String weight,int quantity,imgUrl) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse('${AppConstants.addItems}'
            '?id=$id&category_id=$categoryId&item_name=$itemName&phone=$phone&item_description=$itemDescription&price=$price'
            '&new_price=$newPrice&weight=$weight&quantity=$quantity'));
    request.fields.addAll({'name': 'av1'});
    request.files.add(await http.MultipartFile.fromPath(
        'image', imgUrl)); // Use the correct path to your image file
        // 'image', '/C:/Users/Avinash/Pictures/Screenshots/Screenshot (3).png'));

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
      throw Exception('Failed to add item: ${response.reasonPhrase}');
    }
  }
}
