import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';
import 'package:swiggy/domain/AppConstant.dart';

class ConfigController extends ChangeNotifier {
  bool isLoading = false;
  Map<String, dynamic> configData = {};

  static  final String _url =
      ApiConstants.secretKey;

  Future<void> fetchConfig() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await http.get(Uri.parse(_url));
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body["status"] == true) {
        configData = body["data"];
        // ✅ SET VALUES HERE
        AppConstant.msgAuthKey =
            configData["MSG91_AUTH_KEY"]?.toString() ?? "";

        AppConstant.msgWidgetKey =
            configData["MSG91_WIDGET_ID"]?.toString() ?? "";

        AppConstant.razrorPayLiveKey =
            configData["RAZORPAY_LIVE_KEY"]?.toString() ?? "";

        debugPrint("Config loaded successfully");
      }
    } catch (e) {
      debugPrint("Config API error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
