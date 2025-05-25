import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

import '../address/addressScreen.dart';
import '../widgets/customAppBar.dart';

class CartScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    var addressController = Provider.of<AddressController>(context);

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 2,
        child: Scaffold(
          body: Column(
            children: [
              CustomAppBar(controller: searchController),
              SizedBox(height: 20),
              cartController.itemCount <= 0
                  ? UiHelper.CustomImage(img: "cart.png")
                  : Expanded(
                      flex: 2,
                      child: SizedBox(
                          child: ListView.builder(
                        itemCount: cartController.itemCount,
                        itemBuilder: (context, index) {
                          cartController.totalCartCost();
                          var currentItem =
                              cartController.items.values.toList()[index];
                          return Card(
                            margin: EdgeInsets.all(8),
                            child: ListTile(
                              leading:
                                  UiHelper.CustomImage(img: currentItem.img),
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
                                      print(
                                          "cart remove ${cartController.items.keys.toList()[index]}");
                                      cartController.removeItem(cartController
                                          .items.keys
                                          .toList()[index]);
                                    },
                                  ),
                                  Text('${currentItem.quantity}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      // print("cart scree 2  ${cartController.items.keys.first}");
                                      cartController.addItem(
                                          cartController.items.keys
                                              .toList()[index],
                                          currentItem.title,
                                          currentItem.img,
                                          currentItem.price);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                    ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    shape: BoxShape.rectangle,
                    color: Colors.black12),
                child: Column(
                  children: [
                    UiHelper.CustomText(
                        text: cartController.totalAmount.toString(),
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontsize: 20,
                        fontfamily: "bold"),
                    InkWell(
                      onTap: () {
                        Get.to(AddressInputForm(
                          onAddressSaved: (String address) {},
                        ));
                        /*   AddressInputForm(
                          onAddressSaved: (address) {
                            print("Saved address: $address");
                            // You can store or display this in cart summary
                          },
                        );*/
                      },
                      child: UiHelper.CustomText(
                          text:
                              "Current Add${addressController.address.toString()}",
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontsize: 20,
                          fontfamily: "bold"),
                    )
                  ],
                ),
              ),
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
              ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      backgroundColor: Colors.white,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Select an option",
                                  style: TextStyle(fontSize: 18)),
                              ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text("Camera"),
                                onTap: () {
                                  Navigator.pop(context);
                                  // handle camera action
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.photo),
                                title: Text("Gallery"),
                                onTap: () {
                                  Navigator.pop(context);
                                  // handle gallery action
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text("bott")),
            ],
          ),
        ),
      ),
    );
  }
}
