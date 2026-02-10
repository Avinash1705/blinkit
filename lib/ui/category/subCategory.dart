import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/cartController.dart';

import '../widgets/customAppBar.dart';
import '../widgets/uihelper.dart';

class Subcategory extends StatelessWidget {
  String categoryName = "";
  Subcategory({required this.categoryName,super.key});

  TextEditingController searchController = TextEditingController();
  var categroy = [
    {
      "id": 1,
      "price": 101,
      "img": "image 54.png",
      "text": "Golden Glass\n Wooden Lid Candle (Oudh)"
    },
    {
      "id": 2,
      "price": 102,
      "img": "image 57.png",
      "text": "Royal Gulab Jamun\n By Bikano\n"
    },
    {
      "id": 3,
      "price": 103,
      "img": "image 63.png",
      "text": "Applicances \n & Gadgets\n"
    },
    {
      "id": 4,
      "price": 104,
      "img": "image 63.png",
      "text": "Bikaji Bhujia\n \n"
    },
    {
      "id": 5,
      "price": 105,
      "img": "image 63.png",
      "text": "Golden Glass\n Wooden Lid Candle (Oudh)"
    },
    {
      "id": 6,
      "price": 106,
      "img": "image 63.png",
      "text": "Golden Glass\n Wooden Lid Candle (Oudh)"
    },
  ];
  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    return Scaffold(
      appBar: AppBar(title: Text(categoryName),toolbarHeight: 100,backgroundColor: Color(0xfff7Cb45)),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1, // width / height
        ),
        itemCount: categroy.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            child:  Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
                child: Flexible(
                  child: Column(
                    children: [
                      UiHelper.CustomImage(
                          img: categroy[index]["img"]
                              .toString()),
                      SizedBox(height: 5),
                      UiHelper.CustomText(
                          text: categroy[index]["text"]
                              .toString(),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontsize: 8),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          UiHelper.CustomImage(
                              img: "timer 4.png"),
                          SizedBox(width: 5),
                          UiHelper.CustomText(
                              text: "17 min",
                              color: Color(0xff9c9c9c),
                              fontWeight: FontWeight.normal,
                              fontsize: 10)
                        ],
                      ),
                      Row(
                        children: [
                          UiHelper.CustomText(
                            // text: "₹ ${Random().nextInt(10)}",
                              text: "₹ ${categroy[index]["price"]
                                  .toString()}",
                              color: Color(0xff000000),
                              fontWeight: FontWeight.bold,
                              fontsize: 15),
                          SizedBox(
                            width: 10,
                          ),
                          UiHelper.CustomButton(() {
                            cartController.addItem(
                                categroy[index]["id"]
                                    .toString(),
                                categroy[index]["text"]
                                    .toString(),
                                categroy[index]["img"]
                                    .toString(),
                                double.parse(
                                    categroy[index]["price"]
                                        .toString()),0);
                            InteractiveToast.pop(
                                title: Text("${categroy[index]["text"]
                                    .toString()} Added"));
                            // Get.snackbar(
                            //     22.toString(),
                            //     "Item added");
                          }),
                        ],
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
