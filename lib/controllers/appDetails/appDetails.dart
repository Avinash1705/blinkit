import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';

import '../../model/appDetails.dart';

class AppDetails extends GetxController {

  static Future testApi() async {
    String url = ApiConstants.appDetail;

    late var response;
    late AppDetailModel urRes;
    try {
      response = await http.get(Uri.parse(url));
      print("response isApp Details ${response.body}");
      urRes = AppDetailModel.fromJson(jsonDecode(response.body));
    } catch (ex) {
      print("testt exception $ex");
    }
    return urRes;
  }
}
