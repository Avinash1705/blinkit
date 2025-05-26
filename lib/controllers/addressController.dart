import 'package:flutter/cupertino.dart';

class AddressController extends ChangeNotifier {
  String _address = "";

  String get address => _address;

  void saveAddress(String address) {
    _address = address;
    // address = "avi test address";
    print("addressMow $address");
    notifyListeners();
  }
}
