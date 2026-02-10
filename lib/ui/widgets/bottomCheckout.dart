import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/domain/AppConstant.dart';

import 'package:swiggy/pay/RazorpayPaymentScreen.dart';
import 'package:swiggy/ui/address/addressScreen.dart';
import 'package:swiggy/ui/orderPlacedScreen.dart';
import 'package:swiggy/ui/login/roleBasedLogin/PhoneNumberPage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/addressController.dart';
import '../../controllers/cartController.dart';
import '../../pay/PaymentCheckingScreen.dart';
import '../../pay/razoryPayment.dart';
import '../../testMyCode/OtpFrontendMsg91.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    loggedIn = await isUserLoggedIn();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();
    final addressController = context.watch<AddressController>();

    final hasItems = cartController.itemCount > 0;
    final address = addressController.updatedAddress.value.trim();
    final hasAddress = address.isNotEmpty;

    final canCheckout = hasItems && hasAddress && loggedIn;
    print("chking orderIDNEw ${AppConstant.phone}");
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// LEFT SIDE — ADDRESS + TOTAL
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              SizedBox(
                width: 200,
                child: Obx(() {
                  final addr =
                  addressController.updatedAddress.value.trim();
                  return Text(
                    addr.isEmpty
                        ? "No delivery address selected"
                        : addr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.grey),
                  );
                }),
              ),

              const SizedBox(height: 12),

              const Text("Total",
                  style: TextStyle(fontSize: 14, color: Colors.grey)),

              Text(
                "₹ ${cartController.totalAmount}",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          /// RIGHT SIDE — ACTIONS
          Column(
            children: [

              /// Change address
              InkWell(
                onTap: () {
                  Get.to(
                    AddressInputForm(
                      onAddressSaved: (addr) {
                        addressController
                            .saveUserLocationData(addr);
                      },
                    ),
                  );
                },
                child: const Text(
                  "change",
                  style: TextStyle(
                      fontSize: 14, color: Colors.green),
                ),
              ),

              const SizedBox(height: 16),

              /// CHECKOUT BUTTON
              ElevatedButton(
                onPressed: () async {

                  /// 🔐 LOGIN FIRST — always allowed
                  if (!loggedIn) {
                    await Get.to(PhoneMsg91UI());
                    _checkLogin(); // refresh login state if you have it
                    return;
                  }

                  /// 🛒 CART CHECK
                  if (!hasItems) {
                    _toast("Please add items to cart");
                    return;
                  }

                  /// 📍 ADDRESS CHECK
                  if (!hasAddress) {
                    _toast("Please select delivery address");
                    return;
                  }

                  /// ✅ ALL GOOD
                  _showCheckoutDialog(cartController);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // ALWAYS GREEN
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                child: Text(
                  loggedIn ? "Checkout" : "Login to buy",
                  style: const TextStyle(fontSize: 16),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  /// ✅ Toast helper
  void _toast(String msg) {
    InteractiveToast.popError(
      title: Text(msg),
      toastSetting: const PopupToastSetting(
        toastAlignment: Alignment.center,
        displayDuration: Duration(seconds: 1),
      ),
    );
  }

  /// ✅ Checkout dialog
  void _showCheckoutDialog(CartController cartController) {
    showDialog(
      context: context,
      builder: (_) {
        String selected = "online";

        return StatefulBuilder(
          builder: (_, setState) {
            return AlertDialog(
              title: const Text("Confirm Order"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Text(
                    "Are you sure you want to place this order?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),

                  RadioListTile(
                    title:
                    const Text("Online Payment"),
                    value: "online",
                    groupValue: selected,
                    onChanged: (v) =>
                        setState(() => selected = v!),
                  ),

                  RadioListTile(
                    title:
                    const Text("Cash on Delivery"),
                    value: "cod",
                    groupValue: selected,
                    onChanged: (v) =>
                        setState(() => selected = v!),
                  ),
                ],
              ),
              actions: [

                TextButton(
                  onPressed: Get.back,
                  child: const Text("Cancel"),
                ),

                TextButton(
                  onPressed: () async {
                    if (selected == "online") {
                      // Get.off(
                      //   RazorpayPaymentScreen(
                      //     cartController.totalAmount,
                      //   ),
                      // );
                      await openPayment();

                      Get.to(
                        PaymentCheckingScreen(
                            phoneNumber: AppConstant.phone, // the pay_xxx id you already have
                            expectedAmount:cartController.totalAmount
                        ),
                      );

                    } else {
                      Get.off(OrderPlacedScreen());
                    }
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}


/// ✅ Login check
Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('customer_id');
}
