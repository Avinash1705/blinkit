import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swiggy/domain/appConsatant.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

import '../login/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    Timer(Duration(seconds: 2),() {
      Get.to(LoginScreen());
    });
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldbackgroud,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.CustomImage(img: "image 1 (1).png")
          ],
        ),
      ),
    );
  }
}
