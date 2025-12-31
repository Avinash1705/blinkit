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
            UiHelper.customImage(img: "Blinkit Onboarding Screen.png"),
            const SizedBox(height: 10),

            UiHelper.customImage(img: "image 10.png"),
            const SizedBox(height: 10),

            UiHelper.customText(
              text: "India last min app",
              color: const Color(0xFF000000),
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: "bold",
            ),

            const SizedBox(height: 10),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFFFFFF),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    UiHelper.customText(
                      text: "Avinash",
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),

                    const SizedBox(height: 5),

                    UiHelper.customText(
                      text: "87000566xx",
                      color: const Color(0xFF9C9C9C),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: "bold",
                    ),

                    const SizedBox(height: 5),

                    SizedBox(
                      height: 48,
                      width: 295,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE23744),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UiHelper.customText(
                              text: "Login with",
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            const SizedBox(width: 5),
                            UiHelper.customImage(img: "image 9.png"),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    UiHelper.customText(
                      text:
                      "Access your saved address from zomato automatically!",
                      color: const Color(0xFF9C9C9C),
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      fontFamily: "bold",
                    ),

                    const SizedBox(height: 16),

                    UiHelper.customText(
                      text: "or login with phone number",
                      color: const Color(0xFF269237),
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
