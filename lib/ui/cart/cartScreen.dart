import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

import '../address/addressScreen.dart';
import '../widgets/bottomCheckout.dart';
import '../widgets/customAppBar.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController searchController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    var addressController = Get.find<AddressController>();
    // print("cart items Cart Screen ${jsonEncode(cartController.items)}");
    // print("cart Data title");
    // print("cart Data CartScreen ${jsonEncode(cartController.items)}");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff7Cb45),
          title: UiHelper.CustomText(
              text: "Cart",
              color: Color(0xFF000000),
              fontWeight: FontWeight.bold,
              fontsize: 20,
              fontfamily: "bold"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1.3,
              child: Scaffold(
                body: Column(
                  children: [
                    // CustomAppBar(controller: searchController),
                    SizedBox(height: 20),
                    cartController.itemCount <= 0
                        ? UiHelper.CustomImage(img: "cart.png")
                        : SizedBox(
                            height: 400,
                            child: ListView.builder(
                              itemCount: cartController.itemCount,
                              itemBuilder: (context, index) {
                                cartController.totalCartCost();
                                var currentItem =
                                    cartController.items.values.toList()[index];
                                // print("currentUmg" + jsonEncode(currentItem));
                                return Card(
                                  margin: EdgeInsets.all(8),
                                  child: ListTile(
                                    leading:
                                        // UiHelper.CustomImage(img: currentItem.img),
      
                                        UiHelper.CustomImageNetworkSubCategory(
                                            img: currentItem.img)?? UiHelper.CustomImage(img: currentItem.img),
                                    title: Text(
                                      currentItem.title,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Price: ${currentItem.price}'),
                                        Text('Qty: ${currentItem.quantity}'),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            // print(
                                            //     "cart remove ${cartController.items.keys.toList()[index]}");
                                            // cartController.removeItem(cartController
                                            //     .items.keys
                                            //     .toList()[index]);
                                            cartController.removeItemFromCart(
                                                cartController.items.keys
                                                    .toList()[index],
                                                currentItem.title,
                                                currentItem.img,
                                                currentItem.price,
                                                currentItem.existingQuantity);
                                          },
                                        ),
                                        Text('${currentItem.quantity}'),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            currentItem.quantity < int.parse(currentItem.existingQuantity.toString()) ?cartController.addItem(
                                                cartController.items.keys
                                                    .toList()[index],
                                                currentItem.title,
                                                currentItem.img,
                                                currentItem.price,
                                                currentItem.existingQuantity): InteractiveToast.pop(context, title: Text("Quantity exceeded"));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )),
                    SizedBox(height: 20),
                    UiHelper.CustomText(
                        text: "Reordering will be easy",
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontsize: 16,
                        fontfamily: "bold"),
                    UiHelper.CustomText(
                        text:
                            "Items you orders will be shown up here so you can buy it",
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontsize: 12),
                    UiHelper.CustomText(
                        text: "again easily",
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontsize: 12),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        UiHelper.CustomText(
                            text: "Bestsellers",
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontsize: 16,
                            fontfamily: "bold"),
                        SizedBox(height: 10),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Stack(
                          children: [
                            UiHelper.CustomImage(img: "milk.png"),
                            Padding(
                                padding: EdgeInsets.only(top: 95, left: 70),
                                child: UiHelper.CustomButton(() {})),
                            Padding(
                              padding: EdgeInsets.only(top: 120),
                              child: UiHelper.CustomText(
                                  text: "Amul Taaza Toned\nFresh milk",
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.normal,
                                  fontsize: 8),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 150),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 2,
                                  ),
                                  UiHelper.CustomImage(img: "timer 4.png"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  UiHelper.CustomText(
                                      text: "15 min",
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.normal,
                                      fontsize: 8),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 175),
                              child: UiHelper.CustomText(
                                  text: "₹ 24",
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.bold,
                                  fontsize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Stack(
                          children: [
                            UiHelper.CustomImage(img: "potato.png"),
                            Padding(
                                padding: EdgeInsets.only(top: 95, left: 70),
                                child: UiHelper.CustomButton(() {})),
                            Padding(
                              padding: EdgeInsets.only(top: 120),
                              child: UiHelper.CustomText(
                                  text: "Potato (Aloo)",
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.normal,
                                  fontsize: 8),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 150),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 2,
                                  ),
                                  UiHelper.CustomImage(img: "timer 4.png"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  UiHelper.CustomText(
                                      text: "15 min",
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.normal,
                                      fontsize: 8),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 175),
                              child: UiHelper.CustomText(
                                  text: "₹ 30",
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.bold,
                                  fontsize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Stack(
                          children: [
                            UiHelper.CustomImage(img: "tomato.png"),
                            Padding(
                                padding: EdgeInsets.only(top: 95, left: 70),
                                child: UiHelper.CustomButton(() {})),
                            //3rd item
                            Padding(
                              padding: EdgeInsets.only(top: 120),
                              child: UiHelper.CustomText(
                                  text: "Desi Tomato",
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.normal,
                                  fontsize: 8),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 150),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 2,
                                  ),
                                  UiHelper.CustomImage(img: "timer 4.png"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  UiHelper.CustomText(
                                      text: "15 min",
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.normal,
                                      fontsize: 8),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 175),
                              child: UiHelper.CustomText(
                                  text: "₹ 324",
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.bold,
                                  fontsize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(bottom: 0, child: CheckoutScreen()),
        ]),
      ),
    );
  }
}
