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

  // final box = GetStorage();
  late List<CartItem> itemsAll = [];

  @override
  Widget build(BuildContext context) {
    var printController = Provider.of<Printcontroller>(context);
    var addressController = Provider.of<AddressController>(context);
    // var cartController = Provider.of<CartController>(context);
    // Iterable<CartItem> itemsAll = box.read("itemkey");
    // print("printCart Read new ${printController.getCartItems()}");
    Future<List<CartItem>> loadCartItem() async {
      List<CartItem> cartItem = await printController.getCartItems();
      itemsAll.addAll(cartItem);
      // printController.getCartItems().then((val) => {
      //   itemsAll.addAll(val)
      // });
      return itemsAll;
      print("printCart $itemsAll");
    }

    loadCartItem();
    print("printCart 2 ${itemsAll}");
    return FutureBuilder<List<CartItem>>(
      future: loadCartItem(),
      builder: (context,snapshot) => Scaffold(
        backgroundColor: Color(0xfffbf0ce),
        body: Column(
          children: [
            CustomAppBar(controller: searchController),
            SizedBox(
              height: 30,
            ),
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
            itemsAll.isNotEmpty
                ? Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Flexible(
                              child: SizedBox(
                                child: ListView.builder(
                                    itemCount: itemsAll.length,
                                    itemBuilder: (context, index) {
                                      // var currentItem = itemsAll
                                      //     .items.values
                                      //     .toList()[index];
                                      var currentItem = itemsAll.elementAt(index);
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          UiHelper.CustomText(
                                              text: currentItem.title,
                                              color: Color(0xff9c9c9c),
                                              fontWeight: FontWeight.bold,
                                              fontsize: 12),
                                          UiHelper.CustomText(
                                              text:
                                                  currentItem.quantity.toString(),
                                              color: Color(0xff9c9c9c),
                                              fontWeight: FontWeight.bold,
                                              fontsize: 12),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Text("${addressController.address}"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 40),
            Stack(children: [
              Container(
                height: 180,
                width: 361,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.white),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        UiHelper.CustomText(
                            text: "Documents",
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontsize: 14)
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                        ),
                        UiHelper.CustomImage(img: "star.png"),
                        UiHelper.CustomText(
                            text: "Price starting at rs 3/page",
                            color: Color(0xff9c9c9c),
                            fontWeight: FontWeight.normal,
                            fontsize: 14),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                        ),
                        UiHelper.CustomImage(img: "star.png"),
                        UiHelper.CustomText(
                            text: "Paper quality:70 GSM",
                            color: Color(0xff9c9c9c),
                            fontWeight: FontWeight.normal,
                            fontsize: 14),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                        ),
                        UiHelper.CustomImage(img: "star.png"),
                        UiHelper.CustomText(
                            text: "Single side Prints",
                            color: Color(0xff9c9c9c),
                            fontWeight: FontWeight.normal,
                            fontsize: 14),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Container(
                          height: 40,
                          width: 125,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff27af34)),
                            child: Text(
                              "Upload Files",
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                right: 20,
                top: 40,
                child: UiHelper.CustomImage(img: "document.png"),
              )
            ])
          ],
        ),
      ),
    );
  }
}
