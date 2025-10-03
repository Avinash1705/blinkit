import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';

class OtpController {
  // final String baseUrl;

  OtpController();

  /// Send OTP
  Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.otpSend),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "error": "Server error: ${response.statusCode}"};
      }
    } catch (e) {
      return {"success": false, "error": e.toString()};
    }
  }

  /// Verify OTP
  Future<Map<String, dynamic>> verifyOtp(String phone, String code) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.otpVerify),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone, "code": code}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "error": "Server error: ${response.statusCode}"};
      }
    } catch (e) {
      return {"success": false, "error": e.toString()};
    }
  }
}
