import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/ui/address/addressScreen.dart';
import 'package:swiggy/ui/orderPlacedScreen.dart';
import '../../controllers/addressController.dart';
import '../../controllers/cartController.dart';
import '../../controllers/checkoutController.dart';

class CheckoutScreen extends StatelessWidget {
  final AddressController addressController = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// LEFT SECTION
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                child: Obx(
                      () => Text(
                    addressController.updatedAddress.value.isEmpty
                        ? "No address added"
                        : addressController.updatedAddress.value,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Total",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              Text(
                "₹${cartController.totalAmount}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          /// RIGHT SECTION
          Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(
                    AddressInputForm(
                      onAddressSaved: (String address) {
                        addressController.updatedAddress.value = address;
                        Get.back();
                      },
                    ),
                  );
                },
                child: const Text(
                  "change",
                  style: TextStyle(fontSize: 14, color: Colors.green),
                ),
              ),

              const SizedBox(height: 20),

              /// ✅ CHECKOUT BUTTON (REACTIVE)
              Obx(() {
                final bool hasItems = cartController.itemCount > 0;
                final bool hasAddress =
                    addressController.updatedAddress.value.trim().isNotEmpty;

                final bool canCheckout = hasItems && hasAddress;

                return ElevatedButton(
                  onPressed: canCheckout
                      ? () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirm Order"),
                        content: const Text(
                            "Are you sure you want to place this order?"),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Get.off(OrderPlacedScreen());
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  }
                      : () {
                    InteractiveToast.popError(
                      context,
                      title: const Text(
                          "Please add items & delivery address"),
                      toastSetting: const PopupToastSetting(
                        toastAlignment: Alignment.center,
                        displayDuration: Duration(seconds: 1),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    canCheckout ? Colors.green : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Checkout",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
