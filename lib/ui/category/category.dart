import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

import '../widgets/customAppBar.dart';

class Category extends StatelessWidget {
  Category({super.key});

  //SearchController searchController = Get.find<SearchController>();
  TextEditingController searchController = TextEditingController();

  //array cateory
  var data = [
    {"img": "image 50.png", "text": "Lights, Diyas \n & Candles"},
    {"img": "image 51.png", "text": "Diwali \n Gifts"},
    {"img": "image 52.png", "text": "Appliances  \n & Gadgets"},
    {"img": "image 53.png", "text": "Home \n & Living"}
  ];
  var categroy = [
    {"img": "image 54.png", "text": "Golden Glass\n Wooden Lid Candle (Oudh)"},
    {"img": "image 57.png", "text": "Royal Gulab Jamun\n By Bikano"},
    {"img": "image 63.png", "text": "Golden Glass\n Wooden Lid Candle (Oudh)"},
  ];
  var grocerykitchen = [
    {"img": "image 41.png", "text": "Vegetables & \nFruits"},
    {"img": "image 42.png", "text": "Atta, Dal & \nRice"},
    {"img": "image 43.png", "text": "Oil, Ghee & \nMasala"},
    {"img": "image 44 (1).png", "text": "Dairy, Bread & \nMilk"},
    {"img": "image 45 (1).png", "text": "Biscuits & \nBakery"},
    {"img": "image 45 (1).png", "text": "Biscuits & \nBakery"},
    {"img": "image 45 (1).png", "text": "Biscuits & \nBakery"},
  ];
  var snakesAndDrinks = [
    {"img": "image 31.png", "text": "Chips & \n Namkeens"},
    {"img": "image 32.png", "text": "Sweets & \nChocalates"},
    {"img": "image 33.png", "text": "Drinks & \nJuices"},
    {"img": "image 34.png", "text": "Sauces & \nSpreads"},
    {"img": "image 35.png", "text": "Beauty & \nCosmetics"},
    {"img": "image 35.png", "text": "Beauty & \nCosmetics"},
    {"img": "image 35.png", "text": "Beauty & \nCosmetics"},
  ];
  var houseHoldUtentials = [
    {"img": "image 36.png", "text": "Chips & \n Namkeens"},
    {"img": "image 37.png", "text": "Sweets & \nChocalates"},
    {"img": "image 38.png", "text": "Drinks & \nJuices"},
    {"img": "image 39.png", "text": "Sauces & \nSpreads"},
    {"img": "image 40.png", "text": "Beauty & \nCosmetics"},
    {"img": "image 40.png", "text": "Beauty & \nCosmetics"},
    {"img": "image 40.png", "text": "Beauty & \nCosmetics"}
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 40,
              ),
          CustomAppBar(controller: searchController),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  UiHelper.CustomText(
                      text: "Grocery & Kichen",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 14,
                      fontfamily: "bold")
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 78,
                              width: 71,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFD9EBEB)),
                              child: UiHelper.CustomImage(
                                  img: grocerykitchen[index]["img"].toString()),
                            ),
                            UiHelper.CustomText(
                                text: grocerykitchen[index]["text"].toString(),
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontsize: 10)
                          ],
                        ),
                      );
                    },
                    itemCount: grocerykitchen.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 78,
                              width: 71,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFD9EBEB)),
                              child: UiHelper.CustomImage(
                                  img: grocerykitchen[index]["img"].toString()),
                            ),
                            UiHelper.CustomText(
                                text: grocerykitchen[index]["text"].toString(),
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontsize: 10)
                          ],
                        ),
                      );
                    },
                    itemCount: grocerykitchen.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  UiHelper.CustomText(
                      text: "Grocery & Kichen",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 14,
                      fontfamily: "bold")
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 78,
                              width: 71,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFD9EBEB)),
                              child: UiHelper.CustomImage(
                                  img: snakesAndDrinks[index]["img"].toString()),
                            ),
                            UiHelper.CustomText(
                                text: snakesAndDrinks[index]["text"].toString(),
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontsize: 10)
                          ],
                        ),
                      );
                    },
                    itemCount: snakesAndDrinks.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  UiHelper.CustomText(
                      text: "Household Essentials",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 14,
                      fontfamily: "bold")
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 78,
                          width: 71,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFD9EBEB)),
                          child: UiHelper.CustomImage(
                              img: houseHoldUtentials[index]["img"].toString()),
                        ),
                      );
                    },
                    itemCount: houseHoldUtentials.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
