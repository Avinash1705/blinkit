


import 'dart:convert';

import 'package:swiggy/domain/AppConstants.dart';
import 'package:http/http.dart' as http;
import '../model/GetCategoriesResponseModel.dart';

class GetCategoriesController {

   Future<GetCategoriesResponseModel> getCategories() async {

    late GetCategoriesResponseModel categoriesResponseModel;
    late var response;
      String url = AppConstants.getAllCategories;
    try {
      response = await http.get(
          Uri.parse(url));

      categoriesResponseModel = GetCategoriesResponseModel.fromJson(jsonDecode(response.body));
    } catch (ex) {
      print("testt exception $ex");
    }
    return categoriesResponseModel;
  }
}