import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';

class OtpService {
  final String baseUrl = ApiConstants.baseUrl; // 🌐 Replace with your PHP server domain

  /// Send OTP
  Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/twoFactorService/send_otp.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"Status": "Error", "Details": e.toString()};
    }
  }

  /// Verify OTP
  Future<Map<String, dynamic>> verifyOtp(String sessionId, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/twoFactorService/verify_otp.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"session_id": sessionId, "otp": otp}),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"Status": "Error", "Details": e.toString()};
    }
  }
}
