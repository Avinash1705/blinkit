import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends ChangeNotifier {
  String _address = "";

  String get address => _address;

  void saveAddress(String address) {
    _address = address;
    // address = "avi test address";
    print("addressMow $address");
    saveLocalAddress(address);
    notifyListeners();
  }

  Future<void> saveLocalAddress(String address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("addressKey", address);
  }
}
