import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiggy/ui/widgets/customAppBar.dart';

import '../widgets/uihelper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Stack(
            children: [
              Container(
                height: 190,
                width: double.infinity,
                color: Color(0xffec0505),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        UiHelper.CustomText(
                            text: "Blinkit In",
                            color: Color(0xFFffffff),
                            fontWeight: FontWeight.bold,
                            fontsize: 15,
                            fontfamily: "bold")
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        UiHelper.CustomText(
                            text: "15 minutes",
                            color: Color(0xFFffffff),
                            fontWeight: FontWeight.bold,
                            fontsize: 20,
                            fontfamily: "bold")
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        UiHelper.CustomText(
                            text: "HOME-",
                            color: Color(0xFFffffff),
                            fontWeight: FontWeight.bold,
                            fontsize: 14,
                            fontfamily: "bold"),
                        UiHelper.CustomText(
                            text: "Kursi Road Lucknow(Avinash)",
                            color: Color(0xFFffffff),
                            fontWeight: FontWeight.bold,
                            fontsize: 14,
                            fontfamily: "bold")
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: 20,
                  bottom: 100,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  )),
              Positioned(
                  bottom: 30,
                  left: 20,
                  child: UiHelper.CustomTextField(controller: controller))
            ],
          )
        ],
      ),
    );
  }
}
