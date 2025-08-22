import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';
import 'dart:convert';

import '../venderModels/VenderSpecificProductsModel.dart';

Future<VenderSpecificProductsModel> getVendorCategories(String phone) async {
  final url = Uri.parse('${ApiConstants.getSpecificVenderCategories}?phone=$phone');
  late VenderSpecificProductsModel venderSpecificProductsModel;
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("API Response: $data");
      venderSpecificProductsModel = VenderSpecificProductsModel.fromJson(data);
    } else {
      print("Failed: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
  return venderSpecificProductsModel;
}
