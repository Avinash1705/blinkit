import 'dart:async';

import 'package:get/get.dart' ;
import 'package:http/http.dart' as http;

class AppDetails extends GetxController {

  static var baseUrl = "http://localhost/fluxkart/apis/app_detail.php";


  static Future fetchProducts() async{
     final response = await http.get(Uri.parse(baseUrl));
      var data = response.body.toString();
     print("avi ap-p ${response.body}");
   }
}
