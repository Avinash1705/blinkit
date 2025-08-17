

import 'package:swiggy/domain/AppConstants.dart';
import 'package:http/http.dart'as http;

class CheckOutController {


  Future updateSubcategoryAndSoldItem(int id ,int qty) async{
    String url  = "${AppConstants.updateSoldItemLog}?id=$id&ordered_qty=$qty";
  try {
      final response = await http.post(Uri.parse(url));
      print("aavi successfully ${response.body}");
      if (response.statusCode == 200) {
        // Handle success
        print("Subcategory and sold item updated successfully ${response.body}");
        return response.body;
      } else {
        // Handle error
        print("Failed to update subcategory and sold item: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exception
      print("Error updating subcategory and sold item: $e");
    }
  }
  Future updateItemQuantity(int id ,int qty) async{
    String url  = "${AppConstants.updateSubcategoryAndSoldItem}?id=$id&ordered_qty=$qty";
  //   http://localhost/fluxkart/apis/updateSubcategoryAndSoldItem.php?id=3312111&ordered_qty=1

    try {
      final response = await http.post(Uri.parse(url));
      print("aavi successfully ${response.body}");
      if (response.statusCode == 200) {
        // Handle success
        print("Item quantity updated successfully ${response.body}");
        return response.body;
      } else {
        // Handle error
        print("Failed to update item quantity: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exception
      print("Error updating item quantity: $e");
    }

  }
}