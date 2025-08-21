import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends ChangeNotifier {
  // String _address = "";

  // String get address => _address;
  RxString updatedAddress = "".obs;

  // void saveLocData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   updatedAddress.value = prefs.getString('location') ?? "No Address Found";
  // }
 // void saveAddress(String address) {
 //  updatedAddress.value = address;
 //  }
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

  // Future<String?> getUserLocationData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? location = prefs.getString('location');
  //   if (location != null) {
  //     updatedAddress.value = location;
  //     return location ;
  //     print("updatedAdd getUserLoc ${updatedAddress.value}");
  //   } else {
  //     updatedAddress.value = "No Address Found";
  //     print("updatedAdd getUserLoc No Address Found");
  //   }
  //   return null;
  // }

}
