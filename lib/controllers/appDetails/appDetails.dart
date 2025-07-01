import 'dart:async';

import 'package:get/get.dart' ;
import 'package:http/http.dart' as http;

class AppDetails extends GetxController {

  static var baseUrl = 'http://172.20.10.4/fluxkart/apis/app_detail.php';


   Future<dynamic> fetchProducts() async{
     final response = await http.get(Uri.parse(baseUrl));
     print("avi ap-p ${response.body}");
     return response.body;
   }

  static Future testApi() async{
     print("testt before");
     late var response ;
   try{
     response = await http.get(Uri.parse("http://172.20.10.4/fluxkart/apis/app_detail.php"));
     print("testt ${response.body}");
   }
   catch(ex){
     print("testt exception $ex");
   }
     return response.body;
   }
}
