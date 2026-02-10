import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends ChangeNotifier {

  String _updatedAddress = "";

  String get updatedAddress => _updatedAddress;

  /// SAVE ADDRESS
  Future<void> saveUserLocationData(String location) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('location', location);

    _updatedAddress = location;

    notifyListeners(); // ✅ REQUIRED
    print("Saved address = $location");
  }

  /// LOAD ADDRESS (call on app start)
  Future<void> loadAddress() async {
    final prefs = await SharedPreferences.getInstance();

    _updatedAddress =
        prefs.getString('location') ?? "";

    notifyListeners(); // ✅ REQUIRED
  }
}

