import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/ui/screens/splash/splashScreen.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

import '../../controllers/appDetails/appDetails.dart';
import '../../controllers/loginCustomerController.dart';
import '../../domain/AppConstant.dart';
import '../../domain/appConsatant.dart';
import '../../model/appDetails.dart';
import '../../testMyCode/OtpFrontendMsg91.dart';
import '../../testMyCode/OtpMsg91.dart';
import '../cart/cartScreen.dart';
import '../category/category.dart';
import '../chatbot/ChatScreen.dart';
import '../home/homeScreen.dart';
import '../login/loginScreenStatic.dart';
import '../login/roleBasedLogin/verifyOtpMsg91.dart';
import '../login/roleBasedLogin/PhoneNumberPage.dart';
import '../print/printScreen.dart';

class BottomNavScreen extends StatefulWidget {
  int index;
   BottomNavScreen({required this.index,super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late int currentIndex ;
  // CartController _cartController = Get.find<CartController>();
  late AppDetailModel dataLoaded;
  List<Widget> pages = [
    HomeScreen(),
    Category(),
    CartScreen(),
    PrintScreen(),
  ];
@override
  void initState() {
   currentIndex = widget.index;
   // Initialize dataLoaded with a default value
   dataLoaded = AppDetailModel();

   AppDetails.testApi().then((value) {
     if (value != null && value.data != null && value.data!.isNotEmpty) {
       setState(() {
         dataLoaded = value;
         AppConstant.paymentUser = dataLoaded.data![0].paymentUser!;
         AppConstant.appName = dataLoaded.data![0].appName!;
       });
     } else {
       print("API returned null or empty data");
     }
   }).catchError((error) {
     print("Error loading app details: $error");
   });
    super.initState();
  }
  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Yes"),
          ),
        ],
      ),
    ) ??
        false; // Default to false if dismissed
  }
  @override
  Widget build(BuildContext context) {
  CartController _cartController = Provider.of<CartController>(context);
  print("cartddddd  homeCart${_cartController.getItemCount()}");
    return WillPopScope(
      onWillPop: () =>  _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.yellowAppColor.withOpacity(0.9),
          title:  Text(dataLoaded.data == null ? "Loading":dataLoaded.data![0].appName.toString()), // or dynamic title per tab
        ),
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
                label: "Category"),
            BottomNavigationBarItem(
                icon: UiHelper.CustomImage(img: "category 1.png"), label: "Cart"),
            BottomNavigationBarItem(
                icon: UiHelper.CustomImage(img: "printer 1.png"), label: "Print"),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        floatingActionButton: Visibility(
          visible: _cartController.getItemCount() != 0 && currentIndex != 2,
          child: FloatingActionButton(
            onPressed: () {
              Get.to(CartScreen());
            },
            child: Selector<CartController, int>(
              selector: (context, cartController) =>
                  cartController.getItemCount(),
              builder: (context, itemCount, child) {
                return Text(itemCount.toString());
              },
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: AppColors.yellowAppColor),
                child: Text(
                  "Menu",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),

              InkWell( onTap: () => Get.off(PhoneMsg91UI()),
                child: const ListTile(
                  leading: Icon(Icons.login),
                  title: Text("Login in as"),
                ),
              ),
              InkWell( onTap: () => Get.to(ChatScreen()),
                child: const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Support"),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
