import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/controllers/printController.dart';
import 'package:swiggy/model/cartModel.dart';

import '../controllers/checkoutController.dart';
import 'bottomNav/bottomNavScreen.dart';

class OrderPlacedScreen extends StatefulWidget {
   OrderPlacedScreen({super.key});

  @override
  State<OrderPlacedScreen> createState()  =>_OrderPlacedScreenState();
}
void updateQty(int id, int qty) {
  // CheckOutController().updateItemQuantity(id, qty).then((value) =>
  CheckOutController().updateSubcategoryAndSoldItem(id, qty).then((value) =>
  {
    print("Qty updated successfully $value")
  }).catchError((error) {
    print("Error updating quantity: $error");
  });

}
class _OrderPlacedScreenState extends State<OrderPlacedScreen> {

  @override
  void initState() {


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    var printController = Provider.of<Printcontroller>(context);
    print("cartController items in order placed screen ${jsonEncode(cartController.items)}");
    for(int i=0;i<cartController.itemCount;i++){
      CartItem item = cartController.items.values.elementAt(i);
      // print("item id ${item.productId} title ${item.title} price ${item.price} qty ${item.quantity}");
      updateQty(int.parse(item.productId), item.quantity);
    }
   
    printController.addTransition(cartController.items);
    printController.updateExistingQuantity();

    cartController.clear();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
              SizedBox(height: 24),
              Text(
                "Your Order Has Been Placed!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                "Thank you for shopping with us.\nWe’ll notify you once your order is on the way.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context); // Or navigate to home
                  Get.off(BottomNavScreen(index: 0));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Continue Shopping"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
