import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends GetxController {
  final RxString updatedAddress = "".obs;

  /// SAVE ADDRESS
  Future<void> saveUserLocationData(String location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', location);

    updatedAddress.value = location;
    print("✅ Address saved: $location");
  }

  /// LOAD ADDRESS (call on app start)
  Future<void> loadSavedAddress() async {
    final prefs = await SharedPreferences.getInstance();
    updatedAddress.value = prefs.getString('location') ?? "";
  }
}

