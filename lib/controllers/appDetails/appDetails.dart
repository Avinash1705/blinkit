import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';

import '../../domain/AppConstant.dart';
import '../../model/appDetails.dart';

class AppDetails extends GetxController {

  static Future<AppDetailModel?> testApi() async {
    String url = ApiConstants.appDetail;

    try {
      final response = await http.get(Uri.parse(url)).timeout(
        Duration(seconds: 10),
      );
      // AppConstant.appName = response.body["app_name"];
      var body = jsonDecode(response.body);
      if (body['data'] != null && body['data'].isNotEmpty) {
        String appName = body['data'][0]['app_name'];
        print("App Name: $appName");
        // AppConstant.appName = appName;
      }

      // print("response isApp Details ${response.body}");
      
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return AppDetailModel.fromJson(jsonData);
      } else {
        print("API request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (ex) {
      print("testt exception $ex");
      return null;
    }
  }
}
