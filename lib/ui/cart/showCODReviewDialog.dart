import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../orderPlacedScreen.dart';

void showCODReviewDialog(cartController) {

  Get.dialog(
    AlertDialog(
      title: const Text("Confirm COD Order"),

      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Order Summary",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// 🛒 Items list
            ...cartController.items.values.map((item) {
              return Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(item.title)),
                  Text("x${item.quantity}"),
                ],
              );
            }).toList(),

            const Divider(),

            /// 💰 Total
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total"),
                Text("₹${cartController.totalAmount}"),
              ],
            ),

            const SizedBox(height: 8),

            const Text("Payment: Cash on Delivery"),
          ],
        ),
      ),

      actions: [

        TextButton(
          onPressed: Get.back,
          child: const Text("Edit"),
        ),

        ElevatedButton(
          onPressed: () {

            /// 👉 here you should call order API also ideally

            Get.back();
            Get.off(OrderPlacedScreen());
          },
          child: const Text("Place Order"),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
