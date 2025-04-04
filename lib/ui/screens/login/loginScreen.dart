import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UiHelper.CustomImage(img: "Blinkit Onboarding Screen.png"),
            SizedBox(height: 10),
            UiHelper.CustomImage(img: "image 10.png"),
            SizedBox(height: 10),
            UiHelper.CustomText(
                text: "India last min app",
                color: Color(0xFF000000),
                fontWeight: FontWeight.bold,
                fontsize: 20,
                fontfamily: "bold"),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFFFFFFF)),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    UiHelper.CustomText(
                        text: "Avinash",
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontsize: 14),
                    SizedBox(height: 5),
                    UiHelper.CustomText(
                        text: "87000566xx",
                        color: Color(0xFF9c9c9c),
                        fontWeight: FontWeight.bold,
                        fontsize: 14,
                        fontfamily: "bold"),
                    SizedBox(height: 5),
                    SizedBox(
                        height: 48,
                        width: 295,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE23744),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UiHelper.CustomText(
                                  text: "Login with",
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w500,
                                  fontsize: 14),
                              SizedBox(width: 5),
                              UiHelper.CustomImage(img: "image 9.png")
                            ],
                          ),
                        )),
                    SizedBox(height: 8),
                    UiHelper.CustomText(
                        text: "Access your saved address from zomato automatically!",
                        color: Color(0xFF9c9c9c),
                        fontWeight: FontWeight.normal,
                        fontsize: 10,
                        fontfamily: "bold"),
                    SizedBox(height: 16),
                    UiHelper.CustomText(
                        text: "or login with phone number",
                        color: Color(0xFF269237),
                        fontWeight: FontWeight.normal,
                        fontsize: 14),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
