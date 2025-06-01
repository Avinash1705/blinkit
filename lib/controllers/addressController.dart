import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends ChangeNotifier {
  String _address = "";

  String get address => _address;

  void saveAddress(String address) {
    _address = address;
    print("addressMow $address");
    // saveLocalAddress(address);
    notifyListeners();
  }

  Future<void> saveLocalAddress() async {
    print("inside localadd $address");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('addressKey', address);
  }
}
