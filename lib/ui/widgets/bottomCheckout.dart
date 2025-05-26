import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/ui/address/addressScreen.dart';

import '../../controllers/addressController.dart';
import '../../controllers/cartController.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    var addressController = Provider.of<AddressController>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(addressController.address,
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text("Total", style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text("${cartController.totalAmount}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(AddressInputForm(
                    onAddressSaved: (String address) {},
                  ));
                },
                child: Text("change",
                    style: TextStyle(fontSize: 14, color: Colors.green)),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  // Navigate to checkout page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Checkout", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
