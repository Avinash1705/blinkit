import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

import '../widgets/customAppBar.dart';

class CartScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(controller: searchController),
          SizedBox(height: 20),
          UiHelper.CustomImage(img: "cart.png"),
          SizedBox(height: 20),
          UiHelper.CustomText(
              text: "Reordering will be easy",
              color: Color(0xFF000000),
              fontWeight: FontWeight.bold,
              fontsize: 16,
              fontfamily: "bold"),
          UiHelper.CustomText(
              text: "Items you orders will be shown up here so you can buy it",
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
    );
  }
}
