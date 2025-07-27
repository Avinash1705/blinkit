


import 'dart:convert';

import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart';

import '../../domain/AppConstants.dart';
import 'package:http/http.dart' as http;
class AllVenderController {

  Future<GetVenderResponseModel> fetchVendors() async {
       String url = AppConstants.getAllVenders;
       late GetVenderResponseModel getdas ;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // print("My all Vender ${jsonDecode(response.body)}");
      getdas = GetVenderResponseModel.fromJson(jsonDecode(response.body));
      return getdas;
    } else {
      throw Exception('Failed to load vendors');
    }
  }
}