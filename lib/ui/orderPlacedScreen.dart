import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/controllers/notificationSendController.dart';
import 'package:swiggy/controllers/printController.dart';
import 'package:swiggy/model/cartModel.dart';
import 'package:swiggy/vender/controller/AllVenderController.dart';
import '../controllers/checkoutController.dart';
import '../vender/venderModels/GetVenderResponseModel.dart';
import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart'
as allVenders;

import 'bottomNav/bottomNavScreen.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  List<allVenders.Data> allVenderData = [];
  bool isProcessing = true;

  late CartController cartController;
  late Printcontroller printController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController = Provider.of<CartController>(context, listen: false);
      printController = Provider.of<Printcontroller>(context, listen: false);

      processOrder();
    });
  }

  /// -------------------------------
  /// UPDATE QTY & NOTIFY VENDOR
  /// -------------------------------
  Future<void> updateQty(
      int id, int qty, List<allVenders.Data> vendors) async {
    try {
      var response =
      await CheckOutController().updateSubcategoryAndSoldItem(id, qty);

      var res = jsonDecode(response);
      String matchedPhone = res["phone"];
      String itemName = res["item_name"];

      for (var vendor in vendors) {
        if (vendor.phone == matchedPhone) {
          print("Vendor matched → ${vendor.phone}");

          if (vendor.fcm_token != null) {
            NotificationController()
                .saveToken("${vendor.venderId}", vendor.fcm_token!);

            NotificationController().sendNotification(
              phone: vendor.phone.toString(),
              vendorId: "${vendor.venderId}",
              title: "Order Placed",
              body: "$itemName x $qty",
            );
          }
        }
      }
    } catch (e) {
      print("Qty update failed → $e");
    }
  }

  /// -------------------------------
  /// FULL ORDER PROCESSING PIPELINE
  /// -------------------------------
  Future<void> processOrder() async {
    print("🚀 Starting order processing...");

    // 1️⃣ Load vendors first
    var vendorResponse = await AllVenderController().fetchVendors();
    allVenderData = vendorResponse.data ?? [];

    print("✔ Vendors Loaded: ${allVenderData.length}");

    // 2️⃣ Sequentially update every cart item
    for (var item in cartController.items.values) {
      await updateQty(
        int.parse(item.productId),
        item.quantity,
        allVenderData,
      );
    }

    print("✔ Qty Updates Finished");

    // 3️⃣ Update local print history
    printController.addTransition(cartController.items);
    await printController.updateExistingQuantity();

    print("✔ PrintController Updated");

    // 4️⃣ Clear cart
    cartController.clear();

    print("✔ Cart Cleared");

    // 5️⃣ Hide loader
    setState(() {
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isProcessing
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
          strokeWidth: 3,
        ),
      )
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline,
                  color: Colors.green, size: 100),
              const SizedBox(height: 24),
              const Text(
                "Your Order Has Been Placed!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Thank you for shopping with us.\nWe’ll notify you once your order is on the way.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Get.off(() => BottomNavScreen(index: 0));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Continue Shopping"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
