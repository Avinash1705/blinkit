import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swiggy/ui/widgets/customAppBar.dart';

import '../widgets/uihelper.dart';

class PrintScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  PrintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SizedBox(height: 40),
          Stack(
            children:[ Container(
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
                      SizedBox(height: 20, width: 20,),
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
                      SizedBox(height: 20, width: 20,),
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
                      SizedBox(height: 20, width: 20,),
                      UiHelper.CustomImage(img: "star.png"),
                      UiHelper.CustomText(
                          text: "Single side Prints",
                          color: Color(0xff9c9c9c),
                          fontWeight: FontWeight.normal,
                          fontsize: 14),
                    ],
                  ),
                  SizedBox( height: 10),
                  Row(
                    children: [
                      SizedBox( width: 20),
                      Container(height: 40, width: 125,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: ElevatedButton(onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xff27af34)),
                          child: Text("Upload Files",style: TextStyle(fontSize: 13,color: Colors.white),),),)
                    ],
                  )
                ],
              ),
            ),
            Positioned(right: 20,top: 40 ,child:   UiHelper.CustomImage(img: "document.png"),)
            ]
          )
        ],
      ),
    );
  }
}
