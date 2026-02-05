import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class GPayScreen extends StatefulWidget {
  const GPayScreen({super.key});

  @override
  State<GPayScreen> createState() => _GPayScreenState();
}

class _GPayScreenState extends State<GPayScreen> {
  // final String upiId = "arawat696@okhdfcbank"; // your UPI ID
  final String upiId = "avinashrawat1705-2@okicici"; // your UPI ID
  final String name = "Avinash Rawat";
  final String amount = "1.00"; // must be at least 1.00 INR

  Future<void> startGPayPayment() async {
    // Always encode params properly
    final encodedName = Uri.encodeComponent(name);
    final encodedNote = Uri.encodeComponent("Order Payment");

    final uri = Uri.parse(
      "upi://pay?pa=$upiId&pn=$encodedName&am=$amount&cu=INR&tn=$encodedNote",
    );

    // Prefer launching directly into Google Pay if installed
    if (Platform.isAndroid) {
      final gpayPackage = "com.google.android.apps.nbu.paisa.user";

      final gpayUri = Uri.parse(
        "intent://pay?pa=$upiId&pn=$encodedName&am=$amount&cu=INR&tn=$encodedNote#Intent;package=$gpayPackage;scheme=upi;end",
      );

      if (await canLaunchUrl(gpayUri)) {
        await launchUrl(gpayUri, mode: LaunchMode.externalApplication);
        return;
      }
    }

    // Fallback: open system UPI chooser
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No UPI app found to make payment")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay with GPay")),
      body: Center(
        child: ElevatedButton(
          onPressed: startGPayPayment,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text("Pay ₹1 via Google Pay"),
        ),
      ),
    );
  }
}
