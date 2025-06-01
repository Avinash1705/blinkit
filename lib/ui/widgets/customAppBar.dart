import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

class CustomAppBar extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  CustomAppBar({super.key,required TextEditingController controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 190,
          width: double.infinity,
          color: Color(0xfff7Cb45),
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
                      text: "FluxKart",
                      color: Color(0xFF000000),
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
                      color: Color(0xFF000000),
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
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontsize: 14,
                      fontfamily: "bold"),
                  UiHelper.CustomText(
                      text: "Kursi Road Lucknow(Avinash)",
                      color: Color(0xFF000000),
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
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 20,
              ),
            )),
        Positioned(
            bottom: 30,
            left: 20,
            child: UiHelper.CustomTextField(controller: controller))
      ],
    );
  }
}
