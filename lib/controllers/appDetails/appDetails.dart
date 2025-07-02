import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/appDetails.dart';

class AppDetails extends GetxController {
  static var baseUrl = 'http://172.20.10.4/fluxkart/apis/app_detail.php';

  Future<dynamic> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    print("avi ap-p ${response.body}");
    return response.body;
  }

  static Future testApi() async {
    print("testt before");
    late var response;
    late AppDetailModel urRes;
    try {
      // response = await http.get(Uri.parse("http://172.20.10.4/fluxkart/apis/app_detail.php"));
      response = await http.get(
          Uri.parse("http://192.168.1.29:8080/fluxkart/apis/app_detail.php"));

      urRes = AppDetailModel.fromJson(jsonDecode(response.body));
    } catch (ex) {
      print("testt exception $ex");
    }
    return urRes;
  }
}
