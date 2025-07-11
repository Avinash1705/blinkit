import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends ChangeNotifier {
  String _address = "";

  String get address => _address;
  RxString updatedAddress = "".obs;

  void saveAddress(String address) {
    _address = address;

    // saveLocalAddress(address);
    notifyListeners();
  }

  Future<void> saveLocalAddress(String add) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('addressKey', add);
    updatedAddress.value = (prefs.getString("addressKey") ?? "No Address Found") ;

  }
}
