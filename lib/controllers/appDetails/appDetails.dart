import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/AppConstants.dart';

import '../../model/appDetails.dart';

class AppDetails extends GetxController {

  static Future testApi() async {
    String url = AppConstants.appDetail;

    late var response;
    late AppDetailModel urRes;
    try {
      response = await http.get(
          Uri.parse(url));

      urRes = AppDetailModel.fromJson(jsonDecode(response.body));
    } catch (ex) {
      print("testt exception $ex");
    }
    return urRes;
  }
}
