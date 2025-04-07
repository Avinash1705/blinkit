import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

import '../cart/cartScreen.dart';
import '../category/category.dart';
import '../home/homeScreen.dart';
import '../print/printScreen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 2;
  List<Widget> pages = [
    HomeScreen(),
    CartScreen(),
    PrintScreen(),
    Category(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: UiHelper.CustomImage(img: "home 1.png"), label: "Home"),
          BottomNavigationBarItem(
              icon: UiHelper.CustomImage(img: "shopping-bag 1.png"),
              label: "Home"),
          BottomNavigationBarItem(
              icon: UiHelper.CustomImage(img: "category 1.png"), label: "Home"),
          BottomNavigationBarItem(
              icon: UiHelper.CustomImage(img: "printer 1.png"), label: "Home"),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
