import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:swiggy/model/userRole.dart';

class RoleController extends GetxController {
  UserRole userRole = UserRole(false, null, null, null, phone: "");

  Future<UserRole> getRole(String phone) async {
    String url = "https://avitechly.com/fluxKart/apis/getRole.php?phone=$phone";
    try{
      var res =await http.get(Uri.parse(url));
      print("ur Ans ${json.encode(res.body)}");
      userRole = UserRole.fromJson(json.decode(res.body));
      print("userRole $userRole");
      print("ur Ans ${userRole.phone}");
    }
    catch(ex){
      print("error ${ex.toString()}");
    }
    return userRole;
  }
}
