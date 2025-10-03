import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends ChangeNotifier {

  RxString updatedAddress = "".obs;
   Future<void> saveUserLocationData(String location) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('location', location);
    updatedAddress.value = prefs.getString('location') ?? "No Address Found";
    print("updatedAdd saveUserLoc ${prefs.getString('location')}");
  }

  getUpdatedAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('location');
  }
}
