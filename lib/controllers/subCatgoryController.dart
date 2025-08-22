

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';
import 'package:swiggy/model/GetSubCategoryModel.dart';

class SubCategoryController {

  // Add your methods and properties here
  // For example, you might want to fetch subcategories from an API or database
  // and store them in a list or map.
  String url = ApiConstants.getSubCategories;
  late var response;
  // Example method to fetch subcategories
  Future<GetSubCategoryModel> fetchSubCategories() async {
    print("method is called again");
    // Simulate a network call or database query
     response = await http.get(Uri.parse(url));
     // print("check resoibse ${response.body}");
    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON
      return GetSubCategoryModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load subcategories');
    }
  }
}