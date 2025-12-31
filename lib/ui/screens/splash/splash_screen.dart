import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swiggy/domain/app_constants.dart';
import 'package:swiggy/ui/widgets/ui_helper.dart';

import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Get.off(const LoginScreen());
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.customImage(img: "image 1 (1).png"),
          ],
        ),
      ),
    );
  }
}
