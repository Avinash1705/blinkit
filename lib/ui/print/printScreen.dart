import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'package:get_storage/get_storage.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/controllers/printController.dart';
import 'package:swiggy/model/cartModel.dart';
import 'package:swiggy/ui/widgets/customAppBar.dart';

import '../widgets/uihelper.dart';

class PrintScreen extends StatefulWidget {
  PrintScreen({super.key});

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  TextEditingController searchController = TextEditingController();
  late Future<List<CartItem>> futureItems; // store future
  @override
  void dispose() {
    super.dispose();
    futureItems = Future.value([]); // clear future on dispose
  }
  @override
  void initState() {
    super.initState();
    var printController = Provider.of<Printcontroller>(context, listen: false);
    futureItems = printController.getCartItems(); // load once
    futureItems.then((items) {
      // This will be called when the future completes
      print("Future completed with ${items[0].title} items");
    }).catchError((error) {
      // Handle any errors that occur during the future execution
      print("Error fetching items: $error");
    });
    print("PrintScreen initState called $futureItems");
  }

  @override
  Widget build(BuildContext context) {
    var addressController = Provider.of<AddressController>(context);
    print("addressController updatedAddress: ${addressController.updatedAddress.value}");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff7Cb45),
          title: UiHelper.CustomText(
              text: "Print Store",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontsize: 20),
          centerTitle: true,
          elevation: 0,
        ),
        body: FutureBuilder<List<CartItem>>(
          future: futureItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No items found"));
            }

            List<CartItem> itemsAll = snapshot.data!;

            return Scaffold(
              backgroundColor: Color(0xfffbf0ce),
              body: Column(
                children: [
                  SizedBox(height: 30),
                  UiHelper.CustomText(
                      text: "Print Store",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 32),
                  UiHelper.CustomText(
                      text: "Blinkit ensure sure print at every step",
                      color: Color(0xff9c9c9c),
                      fontWeight: FontWeight.bold,
                      fontsize: 14),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: itemsAll.length,
                          itemBuilder: (context, index) {
                            var currentItem = itemsAll[index];

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          currentItem.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          "Qty: ${currentItem.quantity}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Colors.redAccent, size: 18),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            addressController
                                                .updatedAddress.value
                                                .isNotEmpty
                                                ? addressController
                                                .updatedAddress.value
                                                : "No address saved",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

